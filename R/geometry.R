#' SFC Point
#'
#' Create an sfc_point column from coordinate vectors
#'
#' @name sfc_point
#' @param x x coordinate
#' @param y y coordinate
#' @param z z coordinate {optional}
#' @param crs coordinate reference system
#'
#' @export
sfc_point <- function(x, y, z = NULL, crs = 4326) {
  stopifnot(is.numeric(x), is.numeric(y), length(x) == length(y))
  if (!is.null(z)) {
    stopifnot(is.numeric(z), length(z) == length(x))
  }

  data <- data.frame(cbind(x, y, z))
  sf::st_as_sf(
    data,
    coords = names(data),
    crs = crs,
    na.fail = FALSE
  ) %>%
    sf::st_geometry()
}


#' SF Column
#'
#' Defines a flag that indicates the active geometry column of an sf object
#' should be used in a layer's geometry [accessor()].
#' @name sf_column
#' @export
sf_column <- function() structure(list(), class = "sf_column")


# is object a simple features column
is_sfc <- function(object) inherits(object, "sfc")

# is object a simple features column
is_sf <- function(object) inherits(object, "sf")

# is crs = epsg:4326
is_wgs84 <- function(object) {
  crs <- sf::st_crs(object)
  wgs84 <- sf::st_crs(4326)

  crs == wgs84 || !is.na(crs$input) && crs$input == wgs84$input
}


# add or remove z dimension
set_coordinate_dimensions <- function(coordinates, dim = 2) {
  ncol <- ncol(coordinates)
  if (dim > ncol) cbind(coordinates, 0L, deparse.level = 0L)
  else if (dim < ncol) coordinates[, seq_len(dim)]
  else coordinates
}


# get coordinates for deck.gl
get_coordinates <- function(sfc, dim = 2L) UseMethod("get_coordinates")

get_coordinates.sfc_POINT <- function(sfc, dim = 2L) {
  coords <- matrix(unlist(sfc, FALSE, FALSE), length(sfc), byrow = TRUE)
  set_coordinate_dimensions(coords, dim)
}

get_coordinates.sfc_MULTIPOINT <- function(sfc, dim = 2L) {
  coords <- do.call(rbind, sfc)
  set_coordinate_dimensions(coords, dim)
}

get_coordinates.sfc_LINESTRING <- function(sfc, dim = 2L) {
  class(sfc) <- NULL

  # flat coords
  coords <- do.call(rbind, sfc)
  lengths <- lengths(sfc)

  # adjust dim?
  ncol <- ncol(coords)
  if (dim != ncol) {
    coords <- set_coordinate_dimensions(coords, dim)
    lengths <- dim * (lengths %/% ncol)
  }

  # split coords by line
  ids <- rep(as.factor(seq_along(lengths)), lengths)
  lines <- split(t(coords), ids)

  unname(lines)
}

get_coordinates.sfc_MULTILINESTRING <- function(sfc, dim = 2L) {
  get_coordinates.sfc_LINESTRING(unlist(sfc, FALSE, FALSE), dim)
}

get_coordinates.sfc_POLYGON <- function(sfc, dim = 2L) {
  class(sfc) <- NULL

  # flat coords
  coords <- do.call(rbind, unlist(sfc, FALSE, FALSE))
  lengths <- viapply(sfc, function(x) sum(lengths(x)))

  # adjust dim?
  ncol <- ncol(coords)
  if (dim != ncol) {
    coords <- set_coordinate_dimensions(coords, dim)
    lengths <- dim * (lengths %/% ncol)
  }

  # split coords by polygon
  ids <- rep(as.factor(seq_along(lengths)), lengths)
  polygons <- split(t(set_coordinate_dimensions(coords, dim)), ids)

  # holes
  has_holes <- lengths(sfc) > 1L
  holes <- lapply(sfc[has_holes], function(x) cumsum(lengths(x)[-length(x)]))

  complex_polygon <- function(p, h) list(positions = p, holeIndices = h)
  polygons[has_holes] <- purrr::map2(polygons[has_holes], holes, complex_polygon)

  unname(polygons)
}

get_coordinates.sfc_MULTIPOLYGON <- function(sfc, dim = 2L) {
  get_coordinates.sfc_POLYGON(unlist(sfc, FALSE, FALSE), dim)
}

get_coordinates.sfc_GEOMETRY <- function(sfc) {
  types <- unique(sf::st_geometry_type(sfc, TRUE))
  class(sfc) <- NULL

  if (all(types %in% c("POINT", "MULTIPOINT"))) {
    get_coordinates.sfc_MULTIPOINT(sfc)
  } else if (all(types %in% c("LINESTRING", "MULTILINESTRING"))) {
    get_coordinates.sfc_LINESTRING(rlang::flatten_if(sfc3, is.list))
  } else if (all(types %in% c("POLYGON", "MULTIPOLYGON"))) {
    is_multipolygon <- function(x) class(x)[2] == "MULTIPOLYGON" && length(x) != 0L
    get_coordinates.sfc_POLYGON(rlang::flatten_if(sfc, is_multipolygon))
  } else {
    rlang::abort(paste0("Unsupported geometry types: <", paste0(types, collapse = "/"), ">"))
  }
}


# how many features per sfg
get_feature_lengths <- function(sfc) UseMethod("get_feature_lengths")

get_feature_lengths.sfc_POINT <- function(sfc) 1L
get_feature_lengths.sfc_LINESTRING <- get_feature_lengths.sfc_POINT
get_feature_lengths.sfc_POLYGON <- get_feature_lengths.sfc_POINT
get_feature_lengths.sfc_MULTIPOINT <- function(sfc) viapply(sfc, nrow)
get_feature_lengths.sfc_MULTILINESTRING <- function(sfc) lengths(unclass(sfc))
get_feature_lengths.sfc_MULTIPOLYGON <- get_feature_lengths.sfc_MULTILINESTRING

get_feature_lengths.sfc_GEOMETRY <- function(sfc) {
  viapply(sfc, function(x) {
    switch(
      class(x)[2],
      MULTIPOINT = nrow(x),
      MULTILINESTRING = length(x),
      MULTIPOLYGON = length(x),
      1L
    )
  })
}

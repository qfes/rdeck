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

# is crs = epsg:4326
is_wgs84 <- function(object) {
  crs <- sf::st_crs(object)
  wgs84 <- sf::st_crs(4326)

  crs == wgs84 || !is.na(crs$input) && crs$input == wgs84$input
}


get_coordinates <- function(sfc) {
  UseMethod("get_coordinates")
}

get_coordinates.sfc_POINT <- sf::st_coordinates
get_coordinates.sfc <- function(sfc) lapply(unclass(sfc), unclass)

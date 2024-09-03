#' Point vectors
#'
#' @description
#' Create point vectors
#'
#' @name xy
#' @inherit wk::xyz
#' @param x <`double`> Coordinate x dimension
#' @param y <`double`> Coordinate y dimension
#' @param z <`double`> Coordinate z dimension
#' @examples
#' xy(1:5, 1:5)
#' xyz(1:5, 1:5, 1:5)
#' sfc_point(1:5, 1:5)
#' sfc_point(1:5, 1:5, 1:5)
#' @export
NULL

#' @describeIn xy Efficient 2-dimensional point vector
#' @export
xy <- function(x = double(), y = double(), crs = wk::wk_crs_longlat()) {
  wk::xy(x, y, crs)
}


#' @describeIn xy Efficient 3-dimensional point vector
#' @export
xyz <- function(x = double(), y = double(), z = double(), crs = wk::wk_crs_longlat()) {
  wk::xyz(x, y, z, crs)
}

#' @describeIn xy Simple features point vector
#' @export
sfc_point <- function(x = double(), y = double(), z = NULL, crs = wk::wk_crs_longlat()) {
  vec <- wk::wk_handle(
    if (is.null(z)) wk::xy(x, y) else wk::xyz(x, y, z),
    wk::sfc_writer(FALSE)
  )

  wk::wk_set_crs(vec, crs)
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

# create a new sf object
new_sf <- function(x = list(), n = NULL, ...) {
  handleable_cols <- tidyselect::eval_select(
    rlang::expr(c(attr(x, "sf_column", TRUE), wk::is_handleable)),
    x
  )

  sf_col <- handleable_cols[1]

  vctrs::new_data_frame(
    purrr::map_at(
      unclass(x),
      handleable_cols,
      function(x) wk::wk_handle(x, wk::sfc_writer())
    ),
    n %??% length(x[[sf_col]]),
    ...,
    sf_column = names(sf_col),
    class = "sf"
  )
}

# is crs = epsg:4326
is_wgs84 <- function(object) {
  obj_proj <- wk::wk_crs_proj_definition(wk::wk_crs(object))
  wgs84_proj <- c(
    wk::wk_crs_proj_definition("EPSG:4326"),
    wk::wk_crs_proj_definition("OGC:CRS84")
  )

  !is.na(obj_proj) & obj_proj %in% wgs84_proj
}


# interleave xy[z] coordinates
interleave_xy <- function(xy, dims = "xy") {
  xy_dims <- unclass(xy)
  # add / remove z
  xy_dims$z <- if (dims == "xyz" || dims == "XYZ") xy_dims$z %??% 0

  res <- rbind(xy_dims$x, xy_dims$y, xy_dims$z)
  set_dim(res, NULL)
}

# stack xy[z] coordinates
stack_xy <- function(xy, dims = "xy") {
  use_z <- dims == "xyz" || dims == "XYZ"
  if (vctrs::vec_is_empty(xy)) {
    return(matrix(double(), ncol = 2L + use_z))
  }

  xy_dims <- unclass(xy)
  # add / remove z
  xy_dims$z <- if (use_z) xy_dims$z %??% 0
  cbind(xy_dims$x, xy_dims$y, xy_dims$z)
}


# Extracts feature coordinates
# This utility is an extension to wk_coords(), differences:
# - orient polygons counter-clockwise
# - coordinates stored in xy column
xy_coords <- function(handleable) {
  UseMethod("xy_coords")
}

#' @export
xy_coords.data.frame <- function(handleable) {
  wk_col <- purrr::detect(handleable, wk::is_handleable)
  if (is.null(wk_col)) stop("Can't find a handleable column")

  xy_coords(wk_col)
}

#' @export
xy_coords.wk_xy <- function(handleable) {
  feature_id <- seq_along(handleable)

  # drop empty
  if (vctrs::vec_any_missing(handleable)) {
    feature_id <- feature_id[vctrs::vec_detect_complete(handleable)]
    handleable <- handleable[feature_id]
  }

  details <- list(
    feature_id = feature_id,
    part_id = feature_id,
    ring_id = rep.int(0L, length(feature_id))
  )

  vctrs::new_data_frame(c(details, list(xy = handleable)))
}

#' @export
xy_coords.default <- function(handleable) {
  vertex_filter <- wk::wk_vertex_filter(
    wk::xy_writer(),
    add_details = TRUE
  )

  # do we need to reorient any polygons?
  vector_meta <- wk::wk_vector_meta(handleable)
  needs_reorient <- !vector_meta$geometry_type %in%
    wk::wk_geometry_type(c("point", "linestring", "multipoint", "multilinestring"))

  # handleable may contain polygons, ensure they're all ccw
  if (needs_reorient) {
    vertex_filter <- wk::wk_orient_filter(
      vertex_filter,
      direction = wk::wk_counterclockwise()
    )
  }

  xy <- wk::wk_handle(handleable, vertex_filter)
  details <- attr(xy, "wk_details", TRUE)

  vctrs::new_data_frame(c(details, list(xy = xy)))
}

# Number of primitive geometries per feature
wk_primitive_count <- function(coords) {
  part_runs <- vec_runs(coords$part_id)
  feature_runs <- vec_runs(coords$feature_id[part_runs$loc])
  # feature location in coords
  feature_loc <- part_runs$loc[feature_runs$loc]

  vctrs::new_data_frame(list(
    feature_id = coords$feature_id[feature_loc],
    n_geom = feature_runs$size
  ))
}


#' Wk is
#'
#' Are all geometry types in `handleable` one of `geometry_types`?
#' @noRd
#' @keywords internal
wk_is <- function(handleable, geometry_types, ignore_empty = TRUE) {
  vector_meta <- wk::wk_vector_meta(handleable)

  # try determine types from vector if supported
  if (vector_meta$geometry_type %in% geometry_types) {
    return(TRUE)
  }

  # unknown or mixed? test indiviual features
  if (vector_meta$geometry_type == 0L) {
    meta <- wk::wk_meta(handleable)
    feature_types <- if (ignore_empty) meta$geometry_type[!meta$is_empty] else meta$geometry_type

    # NOTE: all() with length-0 is TRUE
    return(all(feature_types %in% geometry_types))
  }

  FALSE
}

#' Wk is point
#'
#' Are all geometry types either `point` or `multipoint`?
#' @noRd
#' @keywords internal
wk_is_point <- function(handleable, ignore_empty = TRUE) {
  wk_is(handleable, wk::wk_geometry_type(c("point", "multipoint")), ignore_empty)
}

#' Wk is linestring
#'
#' Are all geometry types either `linestring` or `multilinestring`?
#' @noRd
#' @keywords internal
wk_is_linestring <- function(handleable, ignore_empty = TRUE) {
  wk_is(handleable, wk::wk_geometry_type(c("linestring", "multilinestring")), ignore_empty)
}

#' Wk is polygon
#'
#' Are all geometry types either `polygon` or `multipolygon`?
#' @noRd
#' @keywords internal
wk_is_polygon <- function(handleable, ignore_empty = TRUE) {
  wk_is(handleable, wk::wk_geometry_type(c("polygon", "multipolygon")), ignore_empty)
}

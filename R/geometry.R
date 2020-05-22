#' Get position format of geometry
#'
#' @name get_position_format
#' @param obj `sf::sf` | `sf::sfc` | `sf::sfg` | `data.frame`
#' @return `XY` | `XYZ`
#'
#' @noRd
get_position_format <- function(obj) UseMethod("get_position_format")

get_position_format.sf <- function(obj) {
  get_position_format(sf::st_geometry(obj))
}

get_position_format.sfc <- function(col) {
  get_position_format(col[[1]])
}

get_position_format.sfg <- function(geom) {
  class(geom)[1]
}

#' Split multi-geometries for deck.gl compatibility.
#'
#' @name split_geometry
#' @param obj
#'  An `sf::sf` object
#' @return `sf::sf`
#'
#' @noRd
split_geometry <- function(obj) {
  stopifnot(inherits(obj, "sf"))
  cast <- function(type) sf::st_cast(obj, type, warn = FALSE, do_split = TRUE)

  geometry_type <- class(sf::st_geometry(obj))[1]
  switch(geometry_type,
    sfc_MULTIPOINT = cast("POINT"),
    sfc_MULTILINESTRING = cast("LINESTRING"),
    sfc_MULTIPOLYGON = cast("POLYGON"),
    obj
  )
}

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

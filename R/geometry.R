#' Create a bounds instance from a simple features object, column or geometry
#'
#' @name bounds
#' @param obj [`sf::sf`] | [`sf::sfc`] | sf::sfg`
#'  A simple features object, column or geometry to compute bounds from
#'
#' @return `bounds`
#'  A vector of [sf::st_point]
#'
#' @export
bounds <- function(obj) {
  stopifnot(inherits(obj, c("sf", "sfc", "sfg")))

  bbox <- sf::st_bbox(obj)
  structure(
    c(
      sf::st_point(bbox[1:2]),
      sf::st_point(bbox[3:4])
    ),
    class = "bounds"
  )
}

#' Get position format of geometry
#'
#' @name get_position_format
#' @param obj [`sf::sf`] | [`sf::sfc`] | `sf::sfg` | [`data.frame`]
#' @return `XY` | `XYZ`
#'
#' @keywords internal
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
#' @param obj [`sf::sf`]
#'  An [sf::sf] object
#'
#' @return [`sf::sf`]
#'
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

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

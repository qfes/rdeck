layer <- function(type, ...) {
  # dispatch off layer type
  class(type) <- type
  UseMethod("layer", type)
}

layer.default <- function(type, ...) {
  props <- c(
    list(
      type = type
    ),
    list(...)
  )

  structure(
    props,
    class = c(type, "layer")
  )
}

# geojson properties stored as an object
# x => x.property
layer.GeoJsonLayer <- function(type,
                               ...,
                               highlight_color,
                               get_line_color,
                               get_fill_color,
                               get_radius,
                               get_line_width,
                               get_elevation) {
  if (!is.null(data)) {
    assert_type(data, "sf")
    data <- sf::st_transform(4326)
  }

  highlight_color$is_columnar <- FALSE
  get_line_color$is_columnar <- FALSE
  get_fill_color$is_columnar <- FALSE
  get_radius$is_columnar <- FALSE
  get_line_width$is_columnar <- FALSE
  get_elevation$is_columnar <- FALSE

  NextMethod()
}

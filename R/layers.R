layer <- function(type, ...) {
  # dispatch off layer type
  class(type) <- type
  UseMethod("layer", type)
}

layer.default <- function(type, ...) {
  props <- c(
    list(type = type),
    rlang:::dots_list(..., .ignore_empty = "all")
  )

  structure(
    props,
    class = c(type, "Layer", "layer")
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
  if (inherits(highlight_color, "accessor")) {
    highlight_color$is_columnar <- FALSE
  }
  if (inherits(get_line_color, "accessor")) {
    get_line_color$is_columnar <- FALSE
  }
  if (inherits(get_fill_color, "accessor")) {
    get_fill_color$is_columnar <- FALSE
  }
  if (inherits(get_radius, "accessor")) {
    get_radius$is_columnar <- FALSE
  }
  if (inherits(get_line_width, "accessor")) {
    get_line_width$is_columnar <- FALSE
  }
  if (inherits(get_elevation, "accessor")) {
    get_elevation$is_columnar <- FALSE
  }
  NextMethod()
}

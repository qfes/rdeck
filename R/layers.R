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

# geojson properties stored as a object
# x => x.properties[propertyName]
layer.GeoJsonLayer <- function(type,
                               ...,
                               highlight_color,
                               get_line_color,
                               get_fill_color,
                               get_radius,
                               get_line_width,
                               get_elevation,
                               tooltip) {
  if (inherits(highlight_color, "accessor")) {
    highlight_color$data_type <- "geojson"
  }
  if (inherits(get_line_color, "accessor")) {
    get_line_color$data_type <- "geojson"
  }
  if (inherits(get_fill_color, "accessor")) {
    get_fill_color$data_type <- "geojson"
  }
  if (inherits(get_radius, "accessor")) {
    get_radius$data_type <- "geojson"
  }
  if (inherits(get_line_width, "accessor")) {
    get_line_width$data_type <- "geojson"
  }
  if (inherits(get_elevation, "accessor")) {
    get_elevation$data_type <- "geojson"
  }
  if (inherits(tooltip, "tooltip")) {
    tooltip$data_type <- "geojson"
  }

  NextMethod()
}

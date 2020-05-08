# generated code: this code was generated from deck.gl v8.1.1


#' @rdname hexagon_layer
#' @template hexagon_layer
#' @family layers
#' @export
hexagon_layer <- function(id = "HexagonLayer",
                          data = data.frame(),
                          visible = TRUE,
                          pickable = FALSE,
                          opacity = 1,
                          position_format = "XYZ",
                          color_format = "RGBA",
                          auto_highlight = FALSE,
                          highlight_color = "#00008080",
                          color_domain = NULL,
                          color_range = c(
                            "#ffffb2",
                            "#fed976",
                            "#feb24c",
                            "#fd8d3c",
                            "#f03b20",
                            "#bd0026"
                          ),
                          get_color_value = NULL,
                          get_color_weight = 1,
                          color_aggregation = "SUM",
                          lower_percentile = 0,
                          upper_percentile = 100,
                          color_scale_type = "quantize",
                          elevation_domain = NULL,
                          elevation_range = c(0, 1000),
                          get_elevation_value = NULL,
                          get_elevation_weight = 1,
                          elevation_aggregation = "SUM",
                          elevation_lower_percentile = 0,
                          elevation_upper_percentile = 100,
                          elevation_scale = 1,
                          elevation_scale_type = "linear",
                          radius = 1000,
                          coverage = 1,
                          extruded = FALSE,
                          hexagon_aggregator = NULL,
                          get_position = position,
                          material = TRUE,
                          ...) {
  arguments <- get_layer_arguments()
  parameters <- c(
    list(type = "HexagonLayer"),
    get_layer_arguments()
  )
  # auto-resolve geometry
  if (inherits(data, "sf")) {
    parameters$get_position <- as.name(attr(data, "sf_column"))
  }

  do.call(layer, parameters)
}

#' @describeIn hexagon_layer
#' Add HexagonLayer to an rdeck map
#' @inheritParams add_layer
#' @export
add_hexagon_layer <- function(rdeck,
                              id = "HexagonLayer",
                              data = data.frame(),
                              visible = TRUE,
                              pickable = FALSE,
                              opacity = 1,
                              position_format = "XYZ",
                              color_format = "RGBA",
                              auto_highlight = FALSE,
                              highlight_color = "#00008080",
                              color_domain = NULL,
                              color_range = c(
                                "#ffffb2",
                                "#fed976",
                                "#feb24c",
                                "#fd8d3c",
                                "#f03b20",
                                "#bd0026"
                              ),
                              get_color_value = NULL,
                              get_color_weight = 1,
                              color_aggregation = "SUM",
                              lower_percentile = 0,
                              upper_percentile = 100,
                              color_scale_type = "quantize",
                              elevation_domain = NULL,
                              elevation_range = c(0, 1000),
                              get_elevation_value = NULL,
                              get_elevation_weight = 1,
                              elevation_aggregation = "SUM",
                              elevation_lower_percentile = 0,
                              elevation_upper_percentile = 100,
                              elevation_scale = 1,
                              elevation_scale_type = "linear",
                              radius = 1000,
                              coverage = 1,
                              extruded = FALSE,
                              hexagon_aggregator = NULL,
                              get_position = position,
                              material = TRUE,
                              ...) {
  parameters <- get_layer_arguments()[-1]
  layer <- do.call(hexagon_layer, parameters)

  add_layer(rdeck, layer)
}

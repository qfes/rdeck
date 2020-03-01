#' Add a [GridLayer](https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/grid-layer.md) deck.gl layer to an [rdeck] map.
#'
#' @name add_grid_layer
#'
#' @param rdeck [`rdeck`]
#'  An [rdeck] map.
#'
#' @inheritParams grid_layer
#' @inheritDotParams grid_layer
#'
#' @returns [`rdeck`]
#'  The [rdeck] map.
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/grid-layer.md}
#'
#' @export
add_grid_layer <- function(rdeck,
                           id = NULL,
                           data = NULL,
                           visible = TRUE,
                           pickable = FALSE,
                           opacity = 1,
                           position_format = "XYZ",
                           color_format = "RGBA",
                           auto_highlight = FALSE,
                           highlight_color = c(0, 0, 128, 128),
                           color_domain = NULL,
                           color_range = list(
                             c(255, 255, 178),
                             c(254, 217, 118),
                             c(254, 178, 76),
                             c(253, 141, 60),
                             c(240, 59, 32),
                             c(189, 0, 38)
                           ),
                           get_color_weight = NULL,
                           color_aggregation = "SUM",
                           elevation_domain = NULL,
                           elevation_range = c(0, 1000),
                           get_elevation_weight = NULL,
                           elevation_aggregation = "SUM",
                           elevation_scale = 1,
                           cell_size = 1000,
                           coverage = 1,
                           get_position = NULL,
                           extruded = FALSE,
                           material = TRUE,
                           get_color_value = NULL,
                           lower_percentile = 0,
                           upper_percentile = 100,
                           color_scale_type = "quantize",
                           get_elevation_value = NULL,
                           elevation_lower_percentile = 0,
                           elevation_upper_percentile = 100,
                           elevation_scale_type = "linear",
                           grid_aggregator = NULL,
                           gpu_aggregation = FALSE,
                           ...) {
  params <- as.list(match.call())[-(1:2)]
  layer <- do.call(grid_layer, params)

  add_layer(rdeck, layer)
}

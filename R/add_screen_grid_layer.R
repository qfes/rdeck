#' Add a [ScreenGridLayer](https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/screen-grid-layer.md) deck.gl layer to an [rdeck] map.
#'
#' @name add_screen_grid_layer
#'
#' @param rdeck [`rdeck`]
#'  An [rdeck] map.
#'
#' @inheritParams screen_grid_layer
#' @inheritDotParams screen_grid_layer
#'
#' @returns [`rdeck`]
#'  The [rdeck] map.
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/screen-grid-layer.md}
#'
#' @export
add_screen_grid_layer <- function(rdeck,
                                  id = NULL,
                                  data = NULL,
                                  visible = TRUE,
                                  pickable = FALSE,
                                  opacity = 1,
                                  position_format = "XYZ",
                                  color_format = "RGBA",
                                  auto_highlight = FALSE,
                                  highlight_color = c(0, 0, 128, 128),
                                  cell_size_pixels = 100,
                                  cell_margin_pixels = 2,
                                  color_domain = NULL,
                                  color_range = list(
                                    c(255, 255, 178),
                                    c(254, 217, 118),
                                    c(254, 178, 76),
                                    c(253, 141, 60),
                                    c(240, 59, 32),
                                    c(189, 0, 38)
                                  ),
                                  get_position = NULL,
                                  get_weight = NULL,
                                  gpu_aggregation = TRUE,
                                  aggregation = "SUM",
                                  ...) {
  params <- as.list(match.call())[-(1:2)]
  layer <- do.call(screen_grid_layer, params)

  add_layer(rdeck, layer)
}

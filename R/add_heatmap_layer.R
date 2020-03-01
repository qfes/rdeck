#' Add a [HeatmapLayer](https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/heatmap-layer.md) deck.gl layer to an [rdeck] map.
#'
#' @name add_heatmap_layer
#'
#' @param rdeck [`rdeck`]
#'  An [rdeck] map.
#'
#' @inheritParams heatmap_layer
#' @inheritDotParams heatmap_layer
#'
#' @returns [`rdeck`]
#'  The [rdeck] map.
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/heatmap-layer.md}
#'
#' @export
add_heatmap_layer <- function(rdeck,
                              id = NULL,
                              data = NULL,
                              visible = TRUE,
                              pickable = FALSE,
                              opacity = 1,
                              position_format = "XYZ",
                              color_format = "RGBA",
                              auto_highlight = FALSE,
                              highlight_color = c(0, 0, 128, 128),
                              get_position = NULL,
                              get_weight = NULL,
                              intensity = 1,
                              radius_pixels = 50,
                              color_range = list(
                                c(255, 255, 178),
                                c(254, 217, 118),
                                c(254, 178, 76),
                                c(253, 141, 60),
                                c(240, 59, 32),
                                c(189, 0, 38)
                              ),
                              threshold = 0.05,
                              color_domain = NULL,
                              ...) {
  params <- as.list(match.call())[-(1:2)]
  layer <- do.call(heatmap_layer, params)

  add_layer(rdeck, layer)
}

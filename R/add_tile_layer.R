#' Add a [TileLayer](https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/tile-layer.md) deck.gl layer to an [rdeck] map.
#'
#' @name add_tile_layer
#'
#' @param rdeck [`rdeck`]
#'  An [rdeck] map.
#'
#' @inheritParams tile_layer
#' @inheritDotParams tile_layer
#'
#' @returns [`rdeck`]
#'  The [rdeck] map.
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/tile-layer.md}
#'
#' @export
add_tile_layer <- function(rdeck,
                           id = NULL,
                           data = NULL,
                           visible = TRUE,
                           pickable = FALSE,
                           opacity = 1,
                           position_format = "XYZ",
                           color_format = "RGBA",
                           auto_highlight = FALSE,
                           highlight_color = c(0, 0, 128, 128),
                           get_tile_data = NULL,
                           max_zoom = NULL,
                           min_zoom = 0,
                           max_cache_size = NULL,
                           ...) {
  params <- as.list(match.call())[-(1:2)]
  layer <- do.call(tile_layer, params)

  add_layer(rdeck, layer)
}

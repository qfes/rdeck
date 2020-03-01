#' Add a [Tile3DLayer](https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/tile-3d-layer.md) deck.gl layer to an [rdeck] map.
#'
#' @name add_tile3d_layer
#'
#' @param rdeck [`rdeck`]
#'  An [rdeck] map.
#'
#' @inheritParams tile3d_layer
#' @inheritDotParams tile3d_layer
#'
#' @returns [`rdeck`]
#'  The [rdeck] map.
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/tile-3d-layer.md}
#'
#' @export
add_tile3d_layer <- function(rdeck,
                             id = NULL,
                             data = NULL,
                             visible = TRUE,
                             pickable = FALSE,
                             opacity = 1,
                             position_format = "XYZ",
                             color_format = "RGBA",
                             auto_highlight = FALSE,
                             highlight_color = c(0, 0, 128, 128),
                             get_point_color = c(0, 0, 0),
                             point_size = 1,
                             load_options = NULL,
                             ...) {
  params <- as.list(match.call())[-(1:2)]
  layer <- do.call(tile3d_layer, params)

  add_layer(rdeck, layer)
}

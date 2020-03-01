#' Add a [BitmapLayer](https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/bitmap-layer.md) deck.gl layer to an [rdeck] map.
#'
#' @name add_bitmap_layer
#'
#' @param rdeck [`rdeck`]
#'  An [rdeck] map.
#'
#' @inheritParams bitmap_layer
#' @inheritDotParams bitmap_layer
#'
#' @returns [`rdeck`]
#'  The [rdeck] map.
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/bitmap-layer.md}
#'
#' @export
add_bitmap_layer <- function(rdeck,
                             id = NULL,
                             data = NULL,
                             visible = TRUE,
                             pickable = FALSE,
                             opacity = 1,
                             position_format = "XYZ",
                             color_format = "RGBA",
                             auto_highlight = FALSE,
                             highlight_color = c(0, 0, 128, 128),
                             image = NULL,
                             bounds = c(1, 0, 0, 1),
                             desaturate = 0,
                             transparent_color = c(0, 0, 0, 0),
                             tint_color = c(255, 255, 255),
                             ...) {
  params <- as.list(match.call())[-(1:2)]
  layer <- do.call(bitmap_layer, params)

  add_layer(rdeck, layer)
}

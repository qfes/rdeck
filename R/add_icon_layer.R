#' Add a [IconLayer](https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/icon-layer.md) deck.gl layer to an [rdeck] map.
#'
#' @name add_icon_layer
#'
#' @param rdeck [`rdeck`]
#'  An [rdeck] map.
#'
#' @inheritParams icon_layer
#' @inheritDotParams icon_layer
#'
#' @returns [`rdeck`]
#'  The [rdeck] map.
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/icon-layer.md}
#'
#' @export
add_icon_layer <- function(rdeck,
                           id = NULL,
                           data = NULL,
                           visible = TRUE,
                           pickable = FALSE,
                           opacity = 1,
                           position_format = "XYZ",
                           color_format = "RGBA",
                           auto_highlight = FALSE,
                           highlight_color = c(0, 0, 128, 128),
                           icon_atlas = NULL,
                           icon_mapping = NULL,
                           size_scale = 1,
                           billboard = TRUE,
                           size_units = "pixels",
                           size_min_pixels = 0,
                           size_max_pixels = 9007199254740991,
                           alpha_cutoff = 0.05,
                           get_position = NULL,
                           get_icon = NULL,
                           get_color = NULL,
                           get_size = NULL,
                           get_angle = NULL,
                           ...) {
  params <- as.list(match.call())[-(1:2)]
  layer <- do.call(icon_layer, params)

  add_layer(rdeck, layer)
}

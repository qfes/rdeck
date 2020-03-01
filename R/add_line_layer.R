#' Add a [LineLayer](https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/line-layer.md) deck.gl layer to an [rdeck] map.
#'
#' @name add_line_layer
#'
#' @param rdeck [`rdeck`]
#'  An [rdeck] map.
#'
#' @inheritParams line_layer
#' @inheritDotParams line_layer
#'
#' @returns [`rdeck`]
#'  The [rdeck] map.
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/line-layer.md}
#'
#' @export
add_line_layer <- function(rdeck,
                           id = NULL,
                           data = NULL,
                           visible = TRUE,
                           pickable = FALSE,
                           opacity = 1,
                           position_format = "XYZ",
                           color_format = "RGBA",
                           auto_highlight = FALSE,
                           highlight_color = c(0, 0, 128, 128),
                           get_source_position = NULL,
                           get_target_position = NULL,
                           get_color = NULL,
                           get_width = NULL,
                           width_units = "pixels",
                           width_scale = 1,
                           width_min_pixels = 0,
                           width_max_pixels = 9007199254740991,
                           ...) {
  params <- as.list(match.call())[-(1:2)]
  layer <- do.call(line_layer, params)

  add_layer(rdeck, layer)
}

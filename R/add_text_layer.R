#' Add a [TextLayer](https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/text-layer.md) deck.gl layer to an [rdeck] map.
#'
#' @name add_text_layer
#'
#' @param rdeck [`rdeck`]
#'  An [rdeck] map.
#'
#' @inheritParams text_layer
#' @inheritDotParams text_layer
#'
#' @returns [`rdeck`]
#'  The [rdeck] map.
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/text-layer.md}
#'
#' @export
add_text_layer <- function(rdeck,
                           id = NULL,
                           data = NULL,
                           visible = TRUE,
                           pickable = FALSE,
                           opacity = 1,
                           position_format = "XYZ",
                           color_format = "RGBA",
                           auto_highlight = FALSE,
                           highlight_color = c(0, 0, 128, 128),
                           billboard = TRUE,
                           size_scale = 1,
                           size_units = "pixels",
                           size_min_pixels = 0,
                           size_max_pixels = 9007199254740991,
                           background_color = NULL,
                           character_set = NULL,
                           font_family = "Monaco, monospace",
                           font_weight = "normal",
                           line_height = 1,
                           font_settings = NULL,
                           word_break = "word-break",
                           max_width = -1,
                           get_text = NULL,
                           get_position = NULL,
                           get_color = NULL,
                           get_size = NULL,
                           get_angle = NULL,
                           get_text_anchor = NULL,
                           get_alignment_baseline = NULL,
                           get_pixel_offset = NULL,
                           ...) {
  params <- as.list(match.call())[-(1:2)]
  layer <- do.call(text_layer, params)

  add_layer(rdeck, layer)
}

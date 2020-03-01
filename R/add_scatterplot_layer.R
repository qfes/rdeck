#' Add a [ScatterplotLayer](https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/scatterplot-layer.md) deck.gl layer to an [rdeck] map.
#'
#' @name add_scatterplot_layer
#'
#' @param rdeck [`rdeck`]
#'  An [rdeck] map.
#'
#' @inheritParams scatterplot_layer
#' @inheritDotParams scatterplot_layer
#'
#' @returns [`rdeck`]
#'  The [rdeck] map.
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/scatterplot-layer.md}
#'
#' @export
add_scatterplot_layer <- function(rdeck,
                                  id = NULL,
                                  data = NULL,
                                  visible = TRUE,
                                  pickable = FALSE,
                                  opacity = 1,
                                  position_format = "XYZ",
                                  color_format = "RGBA",
                                  auto_highlight = FALSE,
                                  highlight_color = c(0, 0, 128, 128),
                                  radius_scale = 1,
                                  radius_min_pixels = 0,
                                  radius_max_pixels = 9007199254740991,
                                  line_width_units = "meters",
                                  line_width_scale = 1,
                                  line_width_min_pixels = 0,
                                  line_width_max_pixels = 9007199254740991,
                                  stroked = FALSE,
                                  filled = TRUE,
                                  get_position = NULL,
                                  get_radius = NULL,
                                  get_fill_color = NULL,
                                  get_line_color = NULL,
                                  get_line_width = NULL,
                                  ...) {
  params <- as.list(match.call())[-(1:2)]
  layer <- do.call(scatterplot_layer, params)

  add_layer(rdeck, layer)
}

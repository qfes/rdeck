#' Add a [ColumnLayer](https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/column-layer.md) deck.gl layer to an [rdeck] map.
#'
#' @name add_column_layer
#'
#' @param rdeck [`rdeck`]
#'  An [rdeck] map.
#'
#' @inheritParams column_layer
#' @inheritDotParams column_layer
#'
#' @returns [`rdeck`]
#'  The [rdeck] map.
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/column-layer.md}
#'
#' @export
add_column_layer <- function(rdeck,
                             id = NULL,
                             data = NULL,
                             visible = TRUE,
                             pickable = FALSE,
                             opacity = 1,
                             position_format = "XYZ",
                             color_format = "RGBA",
                             auto_highlight = FALSE,
                             highlight_color = c(0, 0, 128, 128),
                             disk_resolution = 20,
                             vertices = NULL,
                             radius = 1000,
                             angle = 0,
                             offset = c(0, 0),
                             coverage = 1,
                             elevation_scale = 1,
                             line_width_units = "meters",
                             line_width_scale = 1,
                             line_width_min_pixels = 0,
                             line_width_max_pixels = 9007199254740991,
                             extruded = TRUE,
                             wireframe = FALSE,
                             filled = TRUE,
                             stroked = FALSE,
                             get_position = NULL,
                             get_fill_color = NULL,
                             get_line_color = NULL,
                             get_line_width = NULL,
                             get_elevation = NULL,
                             material = TRUE,
                             ...) {
  params <- as.list(match.call())[-(1:2)]
  layer <- do.call(column_layer, params)

  add_layer(rdeck, layer)
}

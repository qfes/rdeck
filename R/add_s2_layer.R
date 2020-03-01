#' Add a [S2Layer](https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/s2-layer.md) deck.gl layer to an [rdeck] map.
#'
#' @name add_s2_layer
#'
#' @param rdeck [`rdeck`]
#'  An [rdeck] map.
#'
#' @inheritParams s2_layer
#' @inheritDotParams s2_layer
#'
#' @returns [`rdeck`]
#'  The [rdeck] map.
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/s2-layer.md}
#'
#' @export
add_s2_layer <- function(rdeck,
                         id = NULL,
                         data = NULL,
                         visible = TRUE,
                         pickable = FALSE,
                         opacity = 1,
                         position_format = "XYZ",
                         color_format = "RGBA",
                         auto_highlight = FALSE,
                         highlight_color = c(0, 0, 128, 128),
                         get_s2token = NULL,
                         stroked = TRUE,
                         filled = TRUE,
                         extruded = FALSE,
                         elevation_scale = 1,
                         wireframe = FALSE,
                         line_width_units = "meters",
                         line_width_scale = 1,
                         line_width_min_pixels = 0,
                         line_width_max_pixels = 9007199254740991,
                         line_joint_rounded = FALSE,
                         line_miter_limit = 4,
                         get_polygon = NULL,
                         get_fill_color = NULL,
                         get_line_color = NULL,
                         get_line_width = NULL,
                         get_elevation = NULL,
                         material = TRUE,
                         ...) {
  params <- as.list(match.call())[-(1:2)]
  layer <- do.call(s2_layer, params)

  add_layer(rdeck, layer)
}

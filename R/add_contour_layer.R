#' Add a [ContourLayer](https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/contour-layer.md) deck.gl layer to an [rdeck] map.
#'
#' @name add_contour_layer
#'
#' @param rdeck [`rdeck`]
#'  An [rdeck] map.
#'
#' @inheritParams contour_layer
#' @inheritDotParams contour_layer
#'
#' @returns [`rdeck`]
#'  The [rdeck] map.
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/contour-layer.md}
#'
#' @export
add_contour_layer <- function(rdeck,
                              id = NULL,
                              data = NULL,
                              visible = TRUE,
                              pickable = FALSE,
                              opacity = 1,
                              position_format = "XYZ",
                              color_format = "RGBA",
                              auto_highlight = FALSE,
                              highlight_color = c(0, 0, 128, 128),
                              cell_size = 1000,
                              get_position = NULL,
                              get_weight = NULL,
                              gpu_aggregation = TRUE,
                              aggregation = "SUM",
                              contours = c(NULL),
                              z_offset = 0.005,
                              ...) {
  params <- as.list(match.call())[-(1:2)]
  layer <- do.call(contour_layer, params)

  add_layer(rdeck, layer)
}

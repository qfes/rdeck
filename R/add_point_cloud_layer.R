#' Add a [PointCloudLayer](https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/point-cloud-layer.md) deck.gl layer to an [rdeck] map.
#'
#' @name add_point_cloud_layer
#'
#' @param rdeck [`rdeck`]
#'  An [rdeck] map.
#'
#' @inheritParams point_cloud_layer
#' @inheritDotParams point_cloud_layer
#'
#' @returns [`rdeck`]
#'  The [rdeck] map.
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/point-cloud-layer.md}
#'
#' @export
add_point_cloud_layer <- function(rdeck,
                                  id = NULL,
                                  data = NULL,
                                  visible = TRUE,
                                  pickable = FALSE,
                                  opacity = 1,
                                  position_format = "XYZ",
                                  color_format = "RGBA",
                                  auto_highlight = FALSE,
                                  highlight_color = c(0, 0, 128, 128),
                                  size_units = "pixels",
                                  point_size = 10,
                                  get_position = NULL,
                                  get_normal = NULL,
                                  get_color = NULL,
                                  material = TRUE,
                                  ...) {
  params <- as.list(match.call())[-(1:2)]
  layer <- do.call(point_cloud_layer, params)

  add_layer(rdeck, layer)
}

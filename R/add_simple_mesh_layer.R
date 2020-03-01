#' Add a [SimpleMeshLayer](https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/simple-mesh-layer.md) deck.gl layer to an [rdeck] map.
#'
#' @name add_simple_mesh_layer
#'
#' @param rdeck [`rdeck`]
#'  An [rdeck] map.
#'
#' @inheritParams simple_mesh_layer
#' @inheritDotParams simple_mesh_layer
#'
#' @returns [`rdeck`]
#'  The [rdeck] map.
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/simple-mesh-layer.md}
#'
#' @export
add_simple_mesh_layer <- function(rdeck,
                                  id = NULL,
                                  data = NULL,
                                  visible = TRUE,
                                  pickable = FALSE,
                                  opacity = 1,
                                  position_format = "XYZ",
                                  color_format = "RGBA",
                                  auto_highlight = FALSE,
                                  highlight_color = c(0, 0, 128, 128),
                                  mesh = NULL,
                                  texture = NULL,
                                  size_scale = 1,
                                  wireframe = FALSE,
                                  material = TRUE,
                                  get_position = NULL,
                                  get_color = NULL,
                                  get_orientation = NULL,
                                  get_scale = NULL,
                                  get_translation = NULL,
                                  get_transform_matrix = NULL,
                                  ...) {
  params <- as.list(match.call())[-(1:2)]
  layer <- do.call(simple_mesh_layer, params)

  add_layer(rdeck, layer)
}

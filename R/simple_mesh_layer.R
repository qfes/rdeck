#' @name simple_mesh_layer
#' @template simple_mesh_layer
#' @family layers
#' @export
simple_mesh_layer <- function(id = "SimpleMeshLayer",
                              data = data.frame(),
                              visible = TRUE,
                              pickable = FALSE,
                              opacity = 1,
                              position_format = "XYZ",
                              color_format = "RGBA",
                              auto_highlight = FALSE,
                              highlight_color = "#00008080",
                              mesh = NULL,
                              texture = NULL,
                              size_scale = 1,
                              wireframe = FALSE,
                              material = TRUE,
                              get_position = position,
                              get_color = "#000000ff",
                              get_orientation = c(0, 0, 0),
                              get_scale = c(1, 1, 1),
                              get_translation = c(0, 0, 0),
                              get_transform_matrix = NULL,
                              ...) {
  arguments <- get_arguments()
  parameters <- c(
    list(type = "SimpleMeshLayer"),
    get_arguments()
  )
  # auto-resolve geometry
  if (inherits(data, "sf")) {
    parameters$get_position <- as.name(attr(data, "sf_column"))
  }

  do.call(layer, parameters)
}

#' @describeIn simple_mesh_layer
#'  Add SimpleMeshLayer to an rdeck map
#' @inheritParams add_layer
#' @export
add_simple_mesh_layer <- function(rdeck,
                                  id = "SimpleMeshLayer",
                                  data = data.frame(),
                                  visible = TRUE,
                                  pickable = FALSE,
                                  opacity = 1,
                                  position_format = "XYZ",
                                  color_format = "RGBA",
                                  auto_highlight = FALSE,
                                  highlight_color = "#00008080",
                                  mesh = NULL,
                                  texture = NULL,
                                  size_scale = 1,
                                  wireframe = FALSE,
                                  material = TRUE,
                                  get_position = position,
                                  get_color = "#000000ff",
                                  get_orientation = c(0, 0, 0),
                                  get_scale = c(1, 1, 1),
                                  get_translation = c(0, 0, 0),
                                  get_transform_matrix = NULL,
                                  ...) {
  parameters <- get_arguments()[-1]
  layer <- do.call(simple_mesh_layer, parameters)

  add_layer(rdeck, layer)
}

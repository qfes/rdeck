#' @name scenegraph_layer
#' @template scenegraph_layer
#' @family layers
#' @export
scenegraph_layer <- function(id = "ScenegraphLayer",
                             data = data.frame(),
                             visible = TRUE,
                             pickable = FALSE,
                             opacity = 1,
                             position_format = "XYZ",
                             color_format = "RGBA",
                             auto_highlight = FALSE,
                             highlight_color = c(0, 0, 128, 128),
                             scenegraph = NULL,
                             get_scene = NULL,
                             get_animator = NULL,
                             size_scale = 1,
                             size_min_pixels = 0,
                             size_max_pixels = 9007199254740991,
                             get_position = position,
                             get_color = c(255, 255, 255, 255),
                             get_orientation = c(0, 0, 0),
                             get_scale = c(1, 1, 1),
                             get_translation = c(0, 0, 0),
                             get_transform_matrix = NULL,
                             ...) {
  arguments <- get_arguments()
  parameters <- c(
    list(type = "ScenegraphLayer"),
    get_arguments()
  )
  # auto-resolve geometry
  if (inherits(data, "sf")) {
    parameters$get_position <- as.name(attr(data, "sf_column"))
  }

  do.call(layer, parameters)
}

#' @name add_scenegraph_layer
#' @template scenegraph_layer
#' @param rdeck `rdeck`
#' @family add_layers
#' @export
add_scenegraph_layer <- function(rdeck,
                                 id = "ScenegraphLayer",
                                 data = data.frame(),
                                 visible = TRUE,
                                 pickable = FALSE,
                                 opacity = 1,
                                 position_format = "XYZ",
                                 color_format = "RGBA",
                                 auto_highlight = FALSE,
                                 highlight_color = c(0, 0, 128, 128),
                                 scenegraph = NULL,
                                 get_scene = NULL,
                                 get_animator = NULL,
                                 size_scale = 1,
                                 size_min_pixels = 0,
                                 size_max_pixels = 9007199254740991,
                                 get_position = position,
                                 get_color = c(255, 255, 255, 255),
                                 get_orientation = c(0, 0, 0),
                                 get_scale = c(1, 1, 1),
                                 get_translation = c(0, 0, 0),
                                 get_transform_matrix = NULL,
                                 ...) {
  parameters <- get_arguments()[-1]
  layer <- do.call(scenegraph_layer, parameters)

  add_layer(rdeck, layer)
}

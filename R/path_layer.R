#' @name path_layer
#' @template path_layer
#' @family layers
#' @export
path_layer <- function(id = "PathLayer",
                       data = data.frame(),
                       visible = TRUE,
                       pickable = FALSE,
                       opacity = 1,
                       position_format = "XYZ",
                       color_format = "RGBA",
                       auto_highlight = FALSE,
                       highlight_color = c(0, 0, 128, 128),
                       width_units = "meters",
                       width_scale = 1,
                       width_min_pixels = 0,
                       width_max_pixels = 9007199254740991,
                       rounded = FALSE,
                       miter_limit = 4,
                       billboard = FALSE,
                       get_path = path,
                       get_color = c(0, 0, 0, 255),
                       get_width = 1,
                       ...) {
  arguments <- get_arguments()
  parameters <- c(
    list(type = "PathLayer"),
    get_arguments()
  )
  # auto-resolve geometry
  if (inherits(data, "sf")) {
    parameters$get_path <- as.name(attr(data, "sf_column"))
  }

  do.call(layer, parameters)
}

#' @name add_path_layer
#' @template path_layer
#' @param rdeck `rdeck`
#' @family add_layers
#' @export
add_path_layer <- function(rdeck,
                           id = "PathLayer",
                           data = data.frame(),
                           visible = TRUE,
                           pickable = FALSE,
                           opacity = 1,
                           position_format = "XYZ",
                           color_format = "RGBA",
                           auto_highlight = FALSE,
                           highlight_color = c(0, 0, 128, 128),
                           width_units = "meters",
                           width_scale = 1,
                           width_min_pixels = 0,
                           width_max_pixels = 9007199254740991,
                           rounded = FALSE,
                           miter_limit = 4,
                           billboard = FALSE,
                           get_path = path,
                           get_color = c(0, 0, 0, 255),
                           get_width = 1,
                           ...) {
  parameters <- get_arguments()[-1]
  layer <- do.call(path_layer, parameters)

  add_layer(rdeck, layer)
}

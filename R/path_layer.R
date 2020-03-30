# generated code: this code was generated from deck.gl v8.1.1


#' @rdname path_layer
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
                       highlight_color = "#00008080",
                       width_units = "meters",
                       width_scale = 1,
                       width_min_pixels = 0,
                       width_max_pixels = 9007199254740991,
                       rounded = FALSE,
                       miter_limit = 4,
                       billboard = FALSE,
                       get_path = path,
                       get_color = "#000000ff",
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

#' @describeIn path_layer
#' Add PathLayer to an rdeck map
#' @inheritParams add_layer
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
                           highlight_color = "#00008080",
                           width_units = "meters",
                           width_scale = 1,
                           width_min_pixels = 0,
                           width_max_pixels = 9007199254740991,
                           rounded = FALSE,
                           miter_limit = 4,
                           billboard = FALSE,
                           get_path = path,
                           get_color = "#000000ff",
                           get_width = 1,
                           ...) {
  parameters <- get_arguments()[-1]
  layer <- do.call(path_layer, parameters)

  add_layer(rdeck, layer)
}

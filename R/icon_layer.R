#' @name icon_layer
#' @template icon_layer
#' @family layers
#' @export
icon_layer <- function(id = "IconLayer",
                       data = data.frame(),
                       visible = TRUE,
                       pickable = FALSE,
                       opacity = 1,
                       position_format = "XYZ",
                       color_format = "RGBA",
                       auto_highlight = FALSE,
                       highlight_color = c(0, 0, 128, 128),
                       icon_atlas = NULL,
                       icon_mapping = NULL,
                       size_scale = 1,
                       billboard = TRUE,
                       size_units = "pixels",
                       size_min_pixels = 0,
                       size_max_pixels = 9007199254740991,
                       alpha_cutoff = 0.05,
                       get_position = position,
                       get_icon = icon,
                       get_color = c(0, 0, 0, 255),
                       get_size = 1,
                       get_angle = 0,
                       ...) {
  arguments <- get_arguments()
  parameters <- c(
    list(type = "IconLayer"),
    get_arguments()
  )
  # auto-resolve geometry
  if (inherits(data, "sf")) {
    parameters$get_position <- as.name(attr(data, "sf_column"))
  }

  do.call(layer, parameters)
}

#' @name add_icon_layer
#' @template icon_layer
#' @param rdeck `rdeck`
#' @family add_layers
#' @export
add_icon_layer <- function(rdeck,
                           id = "IconLayer",
                           data = data.frame(),
                           visible = TRUE,
                           pickable = FALSE,
                           opacity = 1,
                           position_format = "XYZ",
                           color_format = "RGBA",
                           auto_highlight = FALSE,
                           highlight_color = c(0, 0, 128, 128),
                           icon_atlas = NULL,
                           icon_mapping = NULL,
                           size_scale = 1,
                           billboard = TRUE,
                           size_units = "pixels",
                           size_min_pixels = 0,
                           size_max_pixels = 9007199254740991,
                           alpha_cutoff = 0.05,
                           get_position = position,
                           get_icon = icon,
                           get_color = c(0, 0, 0, 255),
                           get_size = 1,
                           get_angle = 0,
                           ...) {
  parameters <- get_arguments()[-1]
  layer <- do.call(icon_layer, parameters)

  add_layer(rdeck, layer)
}

# generated code: this code was generated from deck.gl v8.1.1


#' @rdname icon_layer
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
                       highlight_color = "#00008080",
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
                       get_color = "#000000ff",
                       get_size = 1,
                       get_angle = 0,
                       get_pixel_offset = c(0, 0),
                       ...) {
  arguments <- get_layer_arguments()
  parameters <- c(
    list(type = "IconLayer"),
    get_layer_arguments()
  )
  # auto-resolve geometry
  if (inherits(data, "sf")) {
    parameters$get_position <- as.name(attr(data, "sf_column"))
  }

  do.call(layer, parameters)
}

#' @describeIn icon_layer
#' Add IconLayer to an rdeck map
#' @inheritParams add_layer
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
                           highlight_color = "#00008080",
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
                           get_color = "#000000ff",
                           get_size = 1,
                           get_angle = 0,
                           get_pixel_offset = c(0, 0),
                           ...) {
  parameters <- get_layer_arguments()[-1]
  layer <- do.call(icon_layer, parameters)

  add_layer(rdeck, layer)
}

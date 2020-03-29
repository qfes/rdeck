# generated code: this code was generated from deck.gl v8.1.0


#' @rdname line_layer
#' @template line_layer
#' @family layers
#' @export
line_layer <- function(id = "LineLayer",
                       data = data.frame(),
                       visible = TRUE,
                       pickable = FALSE,
                       opacity = 1,
                       position_format = "XYZ",
                       color_format = "RGBA",
                       auto_highlight = FALSE,
                       highlight_color = "#00008080",
                       get_source_position = source_position,
                       get_target_position = target_position,
                       get_color = "#000000ff",
                       get_width = 1,
                       width_units = "pixels",
                       width_scale = 1,
                       width_min_pixels = 0,
                       width_max_pixels = 9007199254740991,
                       ...) {
  arguments <- get_arguments()
  parameters <- c(
    list(type = "LineLayer"),
    get_arguments()
  )

  do.call(layer, parameters)
}

#' @describeIn line_layer
#' Add LineLayer to an rdeck map
#' @inheritParams add_layer
#' @export
add_line_layer <- function(rdeck,
                           id = "LineLayer",
                           data = data.frame(),
                           visible = TRUE,
                           pickable = FALSE,
                           opacity = 1,
                           position_format = "XYZ",
                           color_format = "RGBA",
                           auto_highlight = FALSE,
                           highlight_color = "#00008080",
                           get_source_position = source_position,
                           get_target_position = target_position,
                           get_color = "#000000ff",
                           get_width = 1,
                           width_units = "pixels",
                           width_scale = 1,
                           width_min_pixels = 0,
                           width_max_pixels = 9007199254740991,
                           ...) {
  parameters <- get_arguments()[-1]
  layer <- do.call(line_layer, parameters)

  add_layer(rdeck, layer)
}

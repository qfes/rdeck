# generated code: this code was generated from deck.gl v8.1.0


#' @rdname great_circle_layer
#' @template great_circle_layer
#' @family layers
#' @export
great_circle_layer <- function(id = "GreatCircleLayer",
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
                               get_source_color = "#000000ff",
                               get_target_color = "#000000ff",
                               get_width = 1,
                               get_height = 1,
                               get_tilt = 0,
                               width_units = "pixels",
                               width_scale = 1,
                               width_min_pixels = 0,
                               width_max_pixels = 9007199254740991,
                               ...) {
  arguments <- get_arguments()
  parameters <- c(
    list(type = "GreatCircleLayer"),
    get_arguments()
  )

  do.call(layer, parameters)
}

#' @describeIn great_circle_layer
#' Add GreatCircleLayer to an rdeck map
#' @inheritParams add_layer
#' @export
add_great_circle_layer <- function(rdeck,
                                   id = "GreatCircleLayer",
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
                                   get_source_color = "#000000ff",
                                   get_target_color = "#000000ff",
                                   get_width = 1,
                                   get_height = 1,
                                   get_tilt = 0,
                                   width_units = "pixels",
                                   width_scale = 1,
                                   width_min_pixels = 0,
                                   width_max_pixels = 9007199254740991,
                                   ...) {
  parameters <- get_arguments()[-1]
  layer <- do.call(great_circle_layer, parameters)

  add_layer(rdeck, layer)
}

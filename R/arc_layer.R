#' @name arc_layer
#' @template arc_layer
#' @family layers
#' @export
arc_layer <- function(id = "ArcLayer",
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
    list(type = "ArcLayer"),
    get_arguments()
  )

  do.call(layer, parameters)
}

#' @describeIn arc_layer
#'  Add ArcLayer to an rdeck map
#' @inheritParams add_layer
#' @export
add_arc_layer <- function(rdeck,
                          id = "ArcLayer",
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
  layer <- do.call(arc_layer, parameters)

  add_layer(rdeck, layer)
}

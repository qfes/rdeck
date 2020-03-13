#' @name h3_hexagon_layer
#' @template h3_hexagon_layer
#' @family layers
#' @export
h3_hexagon_layer <- function(id = "H3HexagonLayer",
                             data = data.frame(),
                             visible = TRUE,
                             pickable = FALSE,
                             opacity = 1,
                             position_format = "XYZ",
                             color_format = "RGBA",
                             auto_highlight = FALSE,
                             highlight_color = c(0, 0, 128, 128),
                             stroked = TRUE,
                             filled = TRUE,
                             extruded = TRUE,
                             elevation_scale = 1,
                             wireframe = FALSE,
                             line_width_units = "meters",
                             line_width_scale = 1,
                             line_width_min_pixels = 0,
                             line_width_max_pixels = 9007199254740991,
                             line_joint_rounded = FALSE,
                             line_miter_limit = 4,
                             get_polygon = polygon,
                             get_fill_color = c(0, 0, 0, 255),
                             get_line_color = c(0, 0, 0, 255),
                             get_line_width = 1,
                             get_elevation = 1000,
                             material = TRUE,
                             high_precision = FALSE,
                             coverage = 1,
                             get_hexagon = hexagon,
                             ...) {
  arguments <- get_arguments()
  parameters <- c(
    list(type = "H3HexagonLayer"),
    get_arguments()
  )
  # auto-resolve geometry
  if (inherits(data, "sf")) {
    parameters$get_polygon <- as.name(attr(data, "sf_column"))
  }

  do.call(layer, parameters)
}

#' @name add_h3_hexagon_layer
#' @template h3_hexagon_layer
#' @param rdeck `rdeck`
#' @family add_layers
#' @export
add_h3_hexagon_layer <- function(rdeck,
                                 id = "H3HexagonLayer",
                                 data = data.frame(),
                                 visible = TRUE,
                                 pickable = FALSE,
                                 opacity = 1,
                                 position_format = "XYZ",
                                 color_format = "RGBA",
                                 auto_highlight = FALSE,
                                 highlight_color = c(0, 0, 128, 128),
                                 stroked = TRUE,
                                 filled = TRUE,
                                 extruded = TRUE,
                                 elevation_scale = 1,
                                 wireframe = FALSE,
                                 line_width_units = "meters",
                                 line_width_scale = 1,
                                 line_width_min_pixels = 0,
                                 line_width_max_pixels = 9007199254740991,
                                 line_joint_rounded = FALSE,
                                 line_miter_limit = 4,
                                 get_polygon = polygon,
                                 get_fill_color = c(0, 0, 0, 255),
                                 get_line_color = c(0, 0, 0, 255),
                                 get_line_width = 1,
                                 get_elevation = 1000,
                                 material = TRUE,
                                 high_precision = FALSE,
                                 coverage = 1,
                                 get_hexagon = hexagon,
                                 ...) {
  parameters <- get_arguments()[-1]
  layer <- do.call(h3_hexagon_layer, parameters)

  add_layer(rdeck, layer)
}

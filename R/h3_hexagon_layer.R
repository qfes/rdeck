# generated code: this code was generated from deck.gl v8.1.1


#' @rdname h3_hexagon_layer
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
                             highlight_color = "#00008080",
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
                             get_fill_color = "#000000ff",
                             get_line_color = "#000000ff",
                             get_line_width = 1,
                             get_elevation = 1000,
                             material = TRUE,
                             high_precision = FALSE,
                             coverage = 1,
                             center_hexagon = NULL,
                             get_hexagon = hexagon,
                             ...) {
  arguments <- get_layer_arguments()
  parameters <- c(
    list(type = "H3HexagonLayer"),
    get_layer_arguments()
  )
  # auto-resolve geometry
  if (inherits(data, "sf")) {
    parameters$get_polygon <- as.name(attr(data, "sf_column"))
  }

  do.call(layer, parameters)
}

#' @describeIn h3_hexagon_layer
#' Add H3HexagonLayer to an rdeck map
#' @inheritParams add_layer
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
                                 highlight_color = "#00008080",
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
                                 get_fill_color = "#000000ff",
                                 get_line_color = "#000000ff",
                                 get_line_width = 1,
                                 get_elevation = 1000,
                                 material = TRUE,
                                 high_precision = FALSE,
                                 coverage = 1,
                                 center_hexagon = NULL,
                                 get_hexagon = hexagon,
                                 ...) {
  parameters <- get_layer_arguments()[-1]
  layer <- do.call(h3_hexagon_layer, parameters)

  add_layer(rdeck, layer)
}

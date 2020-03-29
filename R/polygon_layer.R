# generated code: this code was generated from deck.gl v8.1.0


#' @rdname polygon_layer
#' @template polygon_layer
#' @family layers
#' @export
polygon_layer <- function(id = "PolygonLayer",
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
                          extruded = FALSE,
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
                          ...) {
  arguments <- get_arguments()
  parameters <- c(
    list(type = "PolygonLayer"),
    get_arguments()
  )
  # auto-resolve geometry
  if (inherits(data, "sf")) {
    parameters$get_polygon <- as.name(attr(data, "sf_column"))
  }

  do.call(layer, parameters)
}

#' @describeIn polygon_layer
#' Add PolygonLayer to an rdeck map
#' @inheritParams add_layer
#' @export
add_polygon_layer <- function(rdeck,
                              id = "PolygonLayer",
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
                              extruded = FALSE,
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
                              ...) {
  parameters <- get_arguments()[-1]
  layer <- do.call(polygon_layer, parameters)

  add_layer(rdeck, layer)
}

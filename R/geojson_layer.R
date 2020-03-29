# generated code: this code was generated from deck.gl v8.1.0


#' @rdname geojson_layer
#' @template geojson_layer
#' @family layers
#' @export
geojson_layer <- function(id = "GeoJsonLayer",
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
                          wireframe = FALSE,
                          line_width_units = "meters",
                          line_width_scale = 1,
                          line_width_min_pixels = 0,
                          line_width_max_pixels = 9007199254740991,
                          line_joint_rounded = FALSE,
                          line_miter_limit = 4,
                          elevation_scale = 1,
                          point_radius_scale = 1,
                          point_radius_min_pixels = 0,
                          point_radius_max_pixels = 9007199254740991,
                          get_line_color = "#000000ff",
                          get_fill_color = "#000000ff",
                          get_radius = 1,
                          get_line_width = 1,
                          get_elevation = 1000,
                          material = TRUE,
                          ...) {
  arguments <- get_arguments()
  parameters <- c(
    list(type = "GeoJsonLayer"),
    get_arguments()
  )

  do.call(layer, parameters)
}

#' @describeIn geojson_layer
#' Add GeoJsonLayer to an rdeck map
#' @inheritParams add_layer
#' @export
add_geojson_layer <- function(rdeck,
                              id = "GeoJsonLayer",
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
                              wireframe = FALSE,
                              line_width_units = "meters",
                              line_width_scale = 1,
                              line_width_min_pixels = 0,
                              line_width_max_pixels = 9007199254740991,
                              line_joint_rounded = FALSE,
                              line_miter_limit = 4,
                              elevation_scale = 1,
                              point_radius_scale = 1,
                              point_radius_min_pixels = 0,
                              point_radius_max_pixels = 9007199254740991,
                              get_line_color = "#000000ff",
                              get_fill_color = "#000000ff",
                              get_radius = 1,
                              get_line_width = 1,
                              get_elevation = 1000,
                              material = TRUE,
                              ...) {
  parameters <- get_arguments()[-1]
  layer <- do.call(geojson_layer, parameters)

  add_layer(rdeck, layer)
}

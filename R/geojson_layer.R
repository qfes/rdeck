# generated code: this code was generated from deck.gl v8.1.1

#' @rdname geojson_layer
#' @template geojson_layer
#' @family layers
#' @export
add_geojson_layer <- function(rdeck,
                              ...,
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
                              tooltip = FALSE) {
  arg_names <- rlang::call_args_names(sys.call())[-1]

  props <- c(
    list(
      type = "GeoJsonLayer",
      id = id,
      data = data,
      visible = visible,
      pickable = pickable,
      opacity = opacity,
      position_format = position_format,
      color_format = color_format,
      auto_highlight = auto_highlight,
      highlight_color = highlight_color,
      stroked = stroked,
      filled = filled,
      extruded = extruded,
      wireframe = wireframe,
      line_width_units = line_width_units,
      line_width_scale = line_width_scale,
      line_width_min_pixels = line_width_min_pixels,
      line_width_max_pixels = line_width_max_pixels,
      line_joint_rounded = line_joint_rounded,
      line_miter_limit = line_miter_limit,
      elevation_scale = elevation_scale,
      point_radius_scale = point_radius_scale,
      point_radius_min_pixels = point_radius_min_pixels,
      point_radius_max_pixels = point_radius_max_pixels,
      get_line_color = make_scalable_accessor(rlang::enquo(get_line_color), data, FALSE),
      get_fill_color = make_scalable_accessor(rlang::enquo(get_fill_color), data, FALSE),
      get_radius = make_scalable_accessor(rlang::enquo(get_radius), data, FALSE),
      get_line_width = make_scalable_accessor(rlang::enquo(get_line_width), data, FALSE),
      get_elevation = make_scalable_accessor(rlang::enquo(get_elevation), data, FALSE),
      material = material,
      tooltip = make_tooltip(rlang::enquo(tooltip), data)
    ),
    list(...)
  )[c("type", arg_names)]
  geojson_layer <- do.call(layer, props)
  add_layer(rdeck, geojson_layer)
}

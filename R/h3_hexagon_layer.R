# generated code: this code was generated from deck.gl v8.1.1

#' @rdname h3_hexagon_layer
#' @template h3_hexagon_layer
#' @family layers
#' @export
add_h3_hexagon_layer <- function(rdeck,
                                 ...,
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
                                 get_fill_color = "#000000ff",
                                 get_line_color = "#000000ff",
                                 get_line_width = 1,
                                 get_elevation = 1000,
                                 material = TRUE,
                                 high_precision = FALSE,
                                 coverage = 1,
                                 center_hexagon = NULL,
                                 get_hexagon = hexagon,
                                 tooltip = FALSE) {
  arg_names <- rlang::call_args_names(sys.call())[-1]
  # auto-resolve geometry
  if (inherits(data, "sf")) {
    get_polygon <- as.name(attr(data, "sf_column"))
    arg_names <- c(arg_names, "get_polygon") %>% unique()
  }
  props <- c(
    list(
      type = "H3HexagonLayer",
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
      elevation_scale = elevation_scale,
      wireframe = wireframe,
      line_width_units = line_width_units,
      line_width_scale = line_width_scale,
      line_width_min_pixels = line_width_min_pixels,
      line_width_max_pixels = line_width_max_pixels,
      line_joint_rounded = line_joint_rounded,
      line_miter_limit = line_miter_limit,
      get_fill_color = make_scalable_accessor(rlang::enquo(get_fill_color), data, TRUE),
      get_line_color = make_scalable_accessor(rlang::enquo(get_line_color), data, TRUE),
      get_line_width = make_scalable_accessor(rlang::enquo(get_line_width), data, TRUE),
      get_elevation = make_scalable_accessor(rlang::enquo(get_elevation), data, TRUE),
      material = material,
      high_precision = high_precision,
      coverage = coverage,
      center_hexagon = center_hexagon,
      get_hexagon = make_accessor(rlang::enquo(get_hexagon), data, TRUE),
      tooltip = make_tooltip(rlang::enquo(tooltip), data)
    ),
    list(...)
  )[c("type", arg_names)]
  h3_hexagon_layer <- do.call(layer, props)
  add_layer(rdeck, h3_hexagon_layer)
}

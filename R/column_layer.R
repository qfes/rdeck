# generated code: this code was generated from deck.gl v8.1.1

#' @rdname column_layer
#' @template column_layer
#' @family layers
#' @export
add_column_layer <- function(rdeck,
                             ...,
                             id = "ColumnLayer",
                             data = data.frame(),
                             visible = TRUE,
                             pickable = FALSE,
                             opacity = 1,
                             position_format = "XYZ",
                             color_format = "RGBA",
                             auto_highlight = FALSE,
                             highlight_color = "#00008080",
                             disk_resolution = 20,
                             vertices = NULL,
                             radius = 1000,
                             angle = 0,
                             offset = c(0, 0),
                             coverage = 1,
                             elevation_scale = 1,
                             line_width_units = "meters",
                             line_width_scale = 1,
                             line_width_min_pixels = 0,
                             line_width_max_pixels = 9007199254740991,
                             extruded = TRUE,
                             wireframe = FALSE,
                             filled = TRUE,
                             stroked = FALSE,
                             get_position = position,
                             get_fill_color = "#000000ff",
                             get_line_color = "#000000ff",
                             get_line_width = 1,
                             get_elevation = 1000,
                             material = TRUE,
                             tooltip = FALSE) {
  arg_names <- rlang::call_args_names(sys.call())[-1]
  # auto-resolve geometry
  if (inherits(data, "sf")) {
    get_position <- as.name(attr(data, "sf_column"))
    arg_names <- c(arg_names, "get_position") %>% unique()
  }
  props <- c(
    list(
      type = "ColumnLayer",
      id = id,
      data = data,
      visible = visible,
      pickable = pickable,
      opacity = opacity,
      position_format = position_format,
      color_format = color_format,
      auto_highlight = auto_highlight,
      highlight_color = highlight_color,
      disk_resolution = disk_resolution,
      vertices = vertices,
      radius = radius,
      angle = angle,
      offset = offset,
      coverage = coverage,
      elevation_scale = elevation_scale,
      line_width_units = line_width_units,
      line_width_scale = line_width_scale,
      line_width_min_pixels = line_width_min_pixels,
      line_width_max_pixels = line_width_max_pixels,
      extruded = extruded,
      wireframe = wireframe,
      filled = filled,
      stroked = stroked,
      get_position = make_accessor(rlang::enquo(get_position), data, TRUE),
      get_fill_color = make_scalable_accessor(rlang::enquo(get_fill_color), data, TRUE),
      get_line_color = make_scalable_accessor(rlang::enquo(get_line_color), data, TRUE),
      get_line_width = make_scalable_accessor(rlang::enquo(get_line_width), data, TRUE),
      get_elevation = make_scalable_accessor(rlang::enquo(get_elevation), data, TRUE),
      material = material,
      tooltip = make_tooltip(rlang::enquo(tooltip), data)
    ),
    list(...)
  )[c("type", arg_names)]
  column_layer <- do.call(layer, props)
  add_layer(rdeck, column_layer)
}

# generated code: this code was generated from deck.gl v8.1.1

#' @rdname solid_polygon_layer
#' @template solid_polygon_layer
#' @family layers
#' @export
add_solid_polygon_layer <- function(rdeck,
                                    ...,
                                    id = "SolidPolygonLayer",
                                    data = data.frame(),
                                    visible = TRUE,
                                    pickable = FALSE,
                                    opacity = 1,
                                    position_format = "XYZ",
                                    color_format = "RGBA",
                                    auto_highlight = FALSE,
                                    highlight_color = "#00008080",
                                    filled = TRUE,
                                    extruded = FALSE,
                                    wireframe = FALSE,
                                    elevation_scale = 1,
                                    get_polygon = polygon,
                                    get_elevation = 1000,
                                    get_fill_color = "#000000ff",
                                    get_line_color = "#000000ff",
                                    material = TRUE,
                                    tooltip = FALSE) {
  arg_names <- rlang::call_args_names(sys.call())[-1]
  # auto-resolve geometry
  if (inherits(data, "sf")) {
    get_polygon <- as.name(attr(data, "sf_column"))
    arg_names <- c(arg_names, "get_polygon") %>% unique()
  }
  props <- c(
    list(
      type = "SolidPolygonLayer",
      id = id,
      data = data,
      visible = visible,
      pickable = pickable,
      opacity = opacity,
      position_format = position_format,
      color_format = color_format,
      auto_highlight = auto_highlight,
      highlight_color = highlight_color,
      filled = filled,
      extruded = extruded,
      wireframe = wireframe,
      elevation_scale = elevation_scale,
      get_polygon = make_accessor(rlang::enquo(get_polygon), data, TRUE),
      get_elevation = make_scalable_accessor(rlang::enquo(get_elevation), data, TRUE),
      get_fill_color = make_scalable_accessor(rlang::enquo(get_fill_color), data, TRUE),
      get_line_color = make_scalable_accessor(rlang::enquo(get_line_color), data, TRUE),
      material = material,
      tooltip = make_tooltip(rlang::enquo(tooltip), data)
    ),
    list(...)
  )[c("type", arg_names)]
  solid_polygon_layer <- do.call(layer, props)
  add_layer(rdeck, solid_polygon_layer)
}

# generated code: this code was generated from deck.gl v8.1.1

#' @rdname scatterplot_layer
#' @template scatterplot_layer
#' @family layers
#' @export
add_scatterplot_layer <- function(rdeck,
                                  ...,
                                  id = "ScatterplotLayer",
                                  data = data.frame(),
                                  visible = TRUE,
                                  pickable = FALSE,
                                  opacity = 1,
                                  position_format = "XYZ",
                                  color_format = "RGBA",
                                  auto_highlight = FALSE,
                                  highlight_color = "#00008080",
                                  radius_scale = 1,
                                  radius_min_pixels = 0,
                                  radius_max_pixels = 9007199254740991,
                                  line_width_units = "meters",
                                  line_width_scale = 1,
                                  line_width_min_pixels = 0,
                                  line_width_max_pixels = 9007199254740991,
                                  stroked = FALSE,
                                  filled = TRUE,
                                  get_position = position,
                                  get_radius = 1,
                                  get_fill_color = "#000000ff",
                                  get_line_color = "#000000ff",
                                  get_line_width = 1,
                                  tooltip = FALSE) {
  arg_names <- rlang::call_args_names(sys.call())[-1]
  # auto-resolve geometry
  if (inherits(data, "sf")) {
    get_position <- as.name(attr(data, "sf_column"))
    arg_names <- c(arg_names, "get_position") %>% unique()
  }
  props <- c(
    list(
      type = "ScatterplotLayer",
      id = id,
      data = data,
      visible = visible,
      pickable = pickable,
      opacity = opacity,
      position_format = position_format,
      color_format = color_format,
      auto_highlight = auto_highlight,
      highlight_color = highlight_color,
      radius_scale = radius_scale,
      radius_min_pixels = radius_min_pixels,
      radius_max_pixels = radius_max_pixels,
      line_width_units = line_width_units,
      line_width_scale = line_width_scale,
      line_width_min_pixels = line_width_min_pixels,
      line_width_max_pixels = line_width_max_pixels,
      stroked = stroked,
      filled = filled,
      get_position = make_accessor(rlang::enquo(get_position), data, TRUE),
      get_radius = make_scalable_accessor(rlang::enquo(get_radius), data, TRUE),
      get_fill_color = make_scalable_accessor(rlang::enquo(get_fill_color), data, TRUE),
      get_line_color = make_scalable_accessor(rlang::enquo(get_line_color), data, TRUE),
      get_line_width = make_scalable_accessor(rlang::enquo(get_line_width), data, TRUE),
      tooltip = make_tooltip(rlang::enquo(tooltip), data)
    ),
    list(...)
  )[c("type", arg_names)]
  scatterplot_layer <- do.call(layer, props)
  add_layer(rdeck, scatterplot_layer)
}

# generated code: this code was generated from deck.gl v8.1.1

#' @rdname great_circle_layer
#' @template great_circle_layer
#' @family layers
#' @export
add_great_circle_layer <- function(rdeck,
                                   ...,
                                   id = "GreatCircleLayer",
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
                                   tooltip = FALSE) {
  arg_names <- rlang::call_args_names(sys.call())[-1]
  # auto-resolve geometry
  if (inherits(data, "sf")) {
    get_source_position <- as.name(attr(data, "sf_column"))
    arg_names <- c(arg_names, "get_source_position") %>% unique()
  }
  props <- c(
    list(
      type = "GreatCircleLayer",
      id = id,
      data = data,
      visible = visible,
      pickable = pickable,
      opacity = opacity,
      position_format = position_format,
      color_format = color_format,
      auto_highlight = auto_highlight,
      highlight_color = highlight_color,
      get_source_position = make_accessor(rlang::enquo(get_source_position), data, TRUE),
      get_target_position = make_accessor(rlang::enquo(get_target_position), data, TRUE),
      get_source_color = make_scalable_accessor(rlang::enquo(get_source_color), data, TRUE),
      get_target_color = make_scalable_accessor(rlang::enquo(get_target_color), data, TRUE),
      get_width = make_scalable_accessor(rlang::enquo(get_width), data, TRUE),
      get_height = make_scalable_accessor(rlang::enquo(get_height), data, TRUE),
      get_tilt = make_accessor(rlang::enquo(get_tilt), data, TRUE),
      width_units = width_units,
      width_scale = width_scale,
      width_min_pixels = width_min_pixels,
      width_max_pixels = width_max_pixels,
      tooltip = make_tooltip(rlang::enquo(tooltip), data)
    ),
    list(...)
  )[c("type", arg_names)]
  great_circle_layer <- do.call(layer, props)
  add_layer(rdeck, great_circle_layer)
}

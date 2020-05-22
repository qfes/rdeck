# generated code: this code was generated from deck.gl v8.1.1

#' @rdname icon_layer
#' @template icon_layer
#' @family layers
#' @export
add_icon_layer <- function(rdeck,
                           ...,
                           id = "IconLayer",
                           data = data.frame(),
                           visible = TRUE,
                           pickable = FALSE,
                           opacity = 1,
                           position_format = "XYZ",
                           color_format = "RGBA",
                           auto_highlight = FALSE,
                           highlight_color = "#00008080",
                           icon_atlas = NULL,
                           icon_mapping = NULL,
                           size_scale = 1,
                           billboard = TRUE,
                           size_units = "pixels",
                           size_min_pixels = 0,
                           size_max_pixels = 9007199254740991,
                           alpha_cutoff = 0.05,
                           get_position = position,
                           get_icon = icon,
                           get_color = "#000000ff",
                           get_size = 1,
                           get_angle = 0,
                           get_pixel_offset = c(0, 0),
                           tooltip = FALSE) {
  arg_names <- rlang::call_args_names(sys.call())[-1]
  # auto-resolve geometry
  if (inherits(data, "sf")) {
    get_position <- as.name(attr(data, "sf_column"))
    arg_names <- c(arg_names, "get_position") %>% unique()
  }
  props <- c(
    list(
      type = "IconLayer",
      id = id,
      data = data,
      visible = visible,
      pickable = pickable,
      opacity = opacity,
      position_format = position_format,
      color_format = color_format,
      auto_highlight = auto_highlight,
      highlight_color = highlight_color,
      icon_atlas = icon_atlas,
      icon_mapping = icon_mapping,
      size_scale = size_scale,
      billboard = billboard,
      size_units = size_units,
      size_min_pixels = size_min_pixels,
      size_max_pixels = size_max_pixels,
      alpha_cutoff = alpha_cutoff,
      get_position = make_accessor(rlang::enquo(get_position), data, TRUE),
      get_icon = make_accessor(rlang::enquo(get_icon), data, TRUE),
      get_color = make_scalable_accessor(rlang::enquo(get_color), data, TRUE),
      get_size = make_scalable_accessor(rlang::enquo(get_size), data, TRUE),
      get_angle = make_accessor(rlang::enquo(get_angle), data, TRUE),
      get_pixel_offset = make_accessor(rlang::enquo(get_pixel_offset), data, TRUE),
      tooltip = make_tooltip(rlang::enquo(tooltip), data)
    ),
    list(...)
  )[c("type", arg_names)]
  icon_layer <- do.call(layer, props)
  add_layer(rdeck, icon_layer)
}

# generated code: this code was generated from deck.gl v8.1.1

#' @rdname path_layer
#' @template path_layer
#' @family layers
#' @export
add_path_layer <- function(rdeck,
                           ...,
                           id = "PathLayer",
                           data = data.frame(),
                           visible = TRUE,
                           pickable = FALSE,
                           opacity = 1,
                           position_format = "XYZ",
                           color_format = "RGBA",
                           auto_highlight = FALSE,
                           highlight_color = "#00008080",
                           width_units = "meters",
                           width_scale = 1,
                           width_min_pixels = 0,
                           width_max_pixels = 9007199254740991,
                           rounded = FALSE,
                           miter_limit = 4,
                           billboard = FALSE,
                           get_path = path,
                           get_color = "#000000ff",
                           get_width = 1,
                           tooltip = FALSE) {
  arg_names <- rlang::call_args_names(sys.call())[-1]
  # auto-resolve geometry
  if (inherits(data, "sf")) {
    get_path <- as.name(attr(data, "sf_column"))
    arg_names <- c(arg_names, "get_path") %>% unique()
  }
  props <- c(
    list(
      type = "PathLayer",
      id = id,
      data = data,
      visible = visible,
      pickable = pickable,
      opacity = opacity,
      position_format = position_format,
      color_format = color_format,
      auto_highlight = auto_highlight,
      highlight_color = highlight_color,
      width_units = width_units,
      width_scale = width_scale,
      width_min_pixels = width_min_pixels,
      width_max_pixels = width_max_pixels,
      rounded = rounded,
      miter_limit = miter_limit,
      billboard = billboard,
      get_path = make_accessor(rlang::enquo(get_path), data, TRUE),
      get_color = make_scalable_accessor(rlang::enquo(get_color), data, TRUE),
      get_width = make_scalable_accessor(rlang::enquo(get_width), data, TRUE),
      tooltip = make_tooltip(rlang::enquo(tooltip), data)
    ),
    list(...)
  )[c("type", arg_names)]
  path_layer <- do.call(layer, props)
  add_layer(rdeck, path_layer)
}

# generated code: this code was generated from deck.gl v8.1.1

#' @rdname scenegraph_layer
#' @template scenegraph_layer
#' @family layers
#' @export
add_scenegraph_layer <- function(rdeck,
                                 ...,
                                 id = "ScenegraphLayer",
                                 data = data.frame(),
                                 visible = TRUE,
                                 pickable = FALSE,
                                 opacity = 1,
                                 position_format = "XYZ",
                                 color_format = "RGBA",
                                 auto_highlight = FALSE,
                                 highlight_color = "#00008080",
                                 scenegraph = NULL,
                                 get_scene = NULL,
                                 get_animator = NULL,
                                 size_scale = 1,
                                 size_min_pixels = 0,
                                 size_max_pixels = 9007199254740991,
                                 get_position = position,
                                 get_color = "#ffffffff",
                                 get_orientation = c(0, 0, 0),
                                 get_scale = c(1, 1, 1),
                                 get_translation = c(0, 0, 0),
                                 get_transform_matrix = NULL,
                                 tooltip = FALSE) {
  arg_names <- rlang::call_args_names(sys.call())[-1]
  # auto-resolve geometry
  if (inherits(data, "sf")) {
    get_position <- as.name(attr(data, "sf_column"))
    arg_names <- c(arg_names, "get_position") %>% unique()
  }
  props <- c(
    list(
      type = "ScenegraphLayer",
      id = id,
      data = data,
      visible = visible,
      pickable = pickable,
      opacity = opacity,
      position_format = position_format,
      color_format = color_format,
      auto_highlight = auto_highlight,
      highlight_color = highlight_color,
      scenegraph = scenegraph,
      get_scene = get_scene,
      get_animator = get_animator,
      size_scale = size_scale,
      size_min_pixels = size_min_pixels,
      size_max_pixels = size_max_pixels,
      get_position = make_accessor(rlang::enquo(get_position), data, TRUE),
      get_color = make_scalable_accessor(rlang::enquo(get_color), data, TRUE),
      get_orientation = make_accessor(rlang::enquo(get_orientation), data, TRUE),
      get_scale = make_accessor(rlang::enquo(get_scale), data, TRUE),
      get_translation = make_accessor(rlang::enquo(get_translation), data, TRUE),
      get_transform_matrix = make_accessor(rlang::enquo(get_transform_matrix), data, TRUE),
      tooltip = make_tooltip(rlang::enquo(tooltip), data)
    ),
    list(...)
  )[c("type", arg_names)]
  scenegraph_layer <- do.call(layer, props)
  add_layer(rdeck, scenegraph_layer)
}

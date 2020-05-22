# generated code: this code was generated from deck.gl v8.1.1

#' @rdname text_layer
#' @template text_layer
#' @family layers
#' @export
add_text_layer <- function(rdeck,
                           ...,
                           id = "TextLayer",
                           data = data.frame(),
                           visible = TRUE,
                           pickable = FALSE,
                           opacity = 1,
                           position_format = "XYZ",
                           color_format = "RGBA",
                           auto_highlight = FALSE,
                           highlight_color = "#00008080",
                           billboard = TRUE,
                           size_scale = 1,
                           size_units = "pixels",
                           size_min_pixels = 0,
                           size_max_pixels = 9007199254740991,
                           background_color = NULL,
                           character_set = default_character_set(),
                           font_family = "Monaco, monospace",
                           font_weight = "normal",
                           line_height = 1,
                           font_settings = NULL,
                           word_break = "word-break",
                           max_width = -1,
                           get_text = text,
                           get_position = position,
                           get_color = "#000000ff",
                           get_size = 32,
                           get_angle = 0,
                           get_text_anchor = "middle",
                           get_alignment_baseline = "center",
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
      type = "TextLayer",
      id = id,
      data = data,
      visible = visible,
      pickable = pickable,
      opacity = opacity,
      position_format = position_format,
      color_format = color_format,
      auto_highlight = auto_highlight,
      highlight_color = highlight_color,
      billboard = billboard,
      size_scale = size_scale,
      size_units = size_units,
      size_min_pixels = size_min_pixels,
      size_max_pixels = size_max_pixels,
      background_color = background_color,
      character_set = character_set,
      font_family = font_family,
      font_weight = font_weight,
      line_height = line_height,
      font_settings = font_settings,
      word_break = word_break,
      max_width = max_width,
      get_text = make_accessor(rlang::enquo(get_text), data, TRUE),
      get_position = make_accessor(rlang::enquo(get_position), data, TRUE),
      get_color = make_scalable_accessor(rlang::enquo(get_color), data, TRUE),
      get_size = make_scalable_accessor(rlang::enquo(get_size), data, TRUE),
      get_angle = make_accessor(rlang::enquo(get_angle), data, TRUE),
      get_text_anchor = make_accessor(rlang::enquo(get_text_anchor), data, TRUE),
      get_alignment_baseline = make_accessor(rlang::enquo(get_alignment_baseline), data, TRUE),
      get_pixel_offset = make_accessor(rlang::enquo(get_pixel_offset), data, TRUE),
      tooltip = make_tooltip(rlang::enquo(tooltip), data)
    ),
    list(...)
  )[c("type", arg_names)]
  text_layer <- do.call(layer, props)
  add_layer(rdeck, text_layer)
}

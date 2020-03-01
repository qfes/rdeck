#' [TextLayer](https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/text-layer.md) deck.gl layer.
#'
#' @name text_layer
#'
#' @param id [`character`]
#'  The id of the layer. Layer ids must be unique per layer `type` for deck.gl
#'  to properly distinguish between them.
#'
#' @param data [`data.frame`] | [`sf::sf`]
#'
#' @param visible [`logical`]
#'
#' @param pickable [`logical`]
#'
#' @param opacity [`numeric`]
#'
#' @param position_format `XY` | `XYZ`
#'
#' @param color_format `RGB` | `RGBA`
#'
#' @param auto_highlight [`logical`]
#'
#' @param highlight_color [`integer`]
#'
#' @param billboard [`logical`]
#'
#' @param size_scale [`numeric`]
#'
#' @param size_units `pixels` | `meters`
#'
#' @param size_min_pixels [`numeric`]
#'
#' @param size_max_pixels [`numeric`]
#'
#' @param background_color [`integer`]
#'
#' @param character_set `[character]`
#'
#' @param font_family [`character`]
#'
#' @param font_weight [`character`]
#'
#' @param line_height [`numeric`]
#'
#' @param font_settings [`list`]
#'
#' @param word_break `break-all` | `break-word`
#'
#' @param max_width [`numeric`]
#'
#' @param get_text accessor | [`htmlwidgets::JS`]
#'
#' @param get_position accessor | [`htmlwidgets::JS`]
#'
#' @param get_color accessor
#'
#' @param get_size accessor | [`numeric`]
#'
#' @param get_angle accessor | [`numeric`]
#'
#' @param get_text_anchor accessor | `[character]`
#'
#' @param get_alignment_baseline accessor | `[character]`
#'
#' @param get_pixel_offset accessor
#'
#' @param ... additional layer parameters to pass to deck.gl.
#'  `snake_case` parameters will be converted to `camelCase`.
#'
#' @returns `TextLayer` & [`layer`]
#'  A [TextLayer](https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/text-layer.md) layer.
#'  Add to an [rdeck] map via [`add_layer`] or [`rdeck`].
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/text-layer.md}
#'
#' @export
text_layer <- function(id = NULL,
                       data = NULL,
                       visible = TRUE,
                       pickable = FALSE,
                       opacity = 1,
                       position_format = "XYZ",
                       color_format = "RGBA",
                       auto_highlight = FALSE,
                       highlight_color = c(0, 0, 128, 128),
                       billboard = TRUE,
                       size_scale = 1,
                       size_units = "pixels",
                       size_min_pixels = 0,
                       size_max_pixels = 9007199254740991,
                       background_color = NULL,
                       character_set = NULL,
                       font_family = "Monaco, monospace",
                       font_weight = "normal",
                       line_height = 1,
                       font_settings = NULL,
                       word_break = "word-break",
                       max_width = -1,
                       get_text = NULL,
                       get_position = NULL,
                       get_color = NULL,
                       get_size = NULL,
                       get_angle = NULL,
                       get_text_anchor = NULL,
                       get_alignment_baseline = NULL,
                       get_pixel_offset = NULL,
                       ...) {
  get_text <- substitute(get_text) %>%
    accessor(data = data, columnar = TRUE)

  # auto-resolve geometry column
  if (inherits(data, "sf")) {
    get_position <- as.name(attr(data, "sf_column")) %>%
      accessor(data = data, columnar = TRUE)
  }

  get_color <- substitute(get_color) %>%
    accessor(data = data, columnar = TRUE)

  get_size <- substitute(get_size) %>%
    accessor(data = data, columnar = TRUE)

  get_angle <- substitute(get_angle) %>%
    accessor(data = data, columnar = TRUE)

  get_text_anchor <- substitute(get_text_anchor) %>%
    accessor(data = data, columnar = TRUE)

  get_alignment_baseline <- substitute(get_alignment_baseline) %>%
    accessor(data = data, columnar = TRUE)

  get_pixel_offset <- substitute(get_pixel_offset) %>%
    accessor(data = data, columnar = TRUE)

  params <- c(
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
      get_text = get_text,
      get_position = get_position,
      get_color = get_color,
      get_size = get_size,
      get_angle = get_angle,
      get_text_anchor = get_text_anchor,
      get_alignment_baseline = get_alignment_baseline,
      get_pixel_offset = get_pixel_offset
    ),
    list(...)
  )

  do.call(layer, params)
}

#' Add a [TextLayer](https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/text-layer.md) deck.gl layer to an [rdeck] map.
#'
#' @name add_text_layer
#'
#' @param rdeck [`rdeck`]
#'  An [rdeck] map.
#'
#' @inheritParams text_layer
#' @inheritDotParams text_layer
#'
#' @returns [`rdeck`]
#'  The [rdeck] map.
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/text-layer.md}
#'
#' @export
add_text_layer <- function(rdeck,
                           id = NULL,
                           data = NULL,
                           visible = TRUE,
                           pickable = FALSE,
                           opacity = 1,
                           position_format = "XYZ",
                           color_format = "RGBA",
                           auto_highlight = FALSE,
                           highlight_color = c(0, 0, 128, 128),
                           billboard = TRUE,
                           size_scale = 1,
                           size_units = "pixels",
                           size_min_pixels = 0,
                           size_max_pixels = 9007199254740991,
                           background_color = NULL,
                           character_set = NULL,
                           font_family = "Monaco, monospace",
                           font_weight = "normal",
                           line_height = 1,
                           font_settings = NULL,
                           word_break = "word-break",
                           max_width = -1,
                           get_text = NULL,
                           get_position = NULL,
                           get_color = NULL,
                           get_size = NULL,
                           get_angle = NULL,
                           get_text_anchor = NULL,
                           get_alignment_baseline = NULL,
                           get_pixel_offset = NULL,
                           ...) {
  params <- as.list(match.call())[-(1:2)]
  layer <- do.call(text_layer, params)

  add_layer(rdeck, layer)
}

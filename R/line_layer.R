#' [LineLayer](https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/line-layer.md) deck.gl layer.
#'
#' @name line_layer
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
#' @param get_source_position accessor | [`htmlwidgets::JS`]
#'
#' @param get_target_position accessor | [`htmlwidgets::JS`]
#'
#' @param get_color accessor
#'
#' @param get_width accessor | [`numeric`]
#'
#' @param width_units `pixels` | `meters`
#'
#' @param width_scale [`numeric`]
#'
#' @param width_min_pixels [`numeric`]
#'
#' @param width_max_pixels [`numeric`]
#'
#' @param ... additional layer parameters to pass to deck.gl.
#'  `snake_case` parameters will be converted to `camelCase`.
#'
#' @returns `LineLayer` & [`layer`]
#'  A [LineLayer](https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/line-layer.md) layer.
#'  Add to an [rdeck] map via [`add_layer`] or [`rdeck`].
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/line-layer.md}
#'
#' @export
line_layer <- function(id = NULL,
                       data = NULL,
                       visible = TRUE,
                       pickable = FALSE,
                       opacity = 1,
                       position_format = "XYZ",
                       color_format = "RGBA",
                       auto_highlight = FALSE,
                       highlight_color = c(0, 0, 128, 128),
                       get_source_position = NULL,
                       get_target_position = NULL,
                       get_color = NULL,
                       get_width = NULL,
                       width_units = "pixels",
                       width_scale = 1,
                       width_min_pixels = 0,
                       width_max_pixels = 9007199254740991,
                       ...) {
  get_source_position <- substitute(get_source_position) %>%
    accessor(data = data, columnar = TRUE)

  get_target_position <- substitute(get_target_position) %>%
    accessor(data = data, columnar = TRUE)

  get_color <- substitute(get_color) %>%
    accessor(data = data, columnar = TRUE)

  get_width <- substitute(get_width) %>%
    accessor(data = data, columnar = TRUE)

  params <- c(
    list(
      type = "LineLayer",
      id = id,
      data = data,
      visible = visible,
      pickable = pickable,
      opacity = opacity,
      position_format = position_format,
      color_format = color_format,
      auto_highlight = auto_highlight,
      highlight_color = highlight_color,
      get_source_position = get_source_position,
      get_target_position = get_target_position,
      get_color = get_color,
      get_width = get_width,
      width_units = width_units,
      width_scale = width_scale,
      width_min_pixels = width_min_pixels,
      width_max_pixels = width_max_pixels
    ),
    list(...)
  )

  do.call(layer, params)
}

#' Add a [LineLayer](https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/line-layer.md) deck.gl layer to an [rdeck] map.
#'
#' @name add_line_layer
#'
#' @param rdeck [`rdeck`]
#'  An [rdeck] map.
#'
#' @inheritParams line_layer
#' @inheritDotParams line_layer
#'
#' @returns [`rdeck`]
#'  The [rdeck] map.
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/line-layer.md}
#'
#' @export
add_line_layer <- function(rdeck,
                           id = NULL,
                           data = NULL,
                           visible = TRUE,
                           pickable = FALSE,
                           opacity = 1,
                           position_format = "XYZ",
                           color_format = "RGBA",
                           auto_highlight = FALSE,
                           highlight_color = c(0, 0, 128, 128),
                           get_source_position = NULL,
                           get_target_position = NULL,
                           get_color = NULL,
                           get_width = NULL,
                           width_units = "pixels",
                           width_scale = 1,
                           width_min_pixels = 0,
                           width_max_pixels = 9007199254740991,
                           ...) {
  params <- as.list(match.call())[-(1:2)]
  layer <- do.call(line_layer, params)

  add_layer(rdeck, layer)
}

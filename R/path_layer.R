#' [PathLayer](https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/path-layer.md) deck.gl layer.
#'
#' @name path_layer
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
#' @param width_units `pixels` | `meters`
#'
#' @param width_scale [`numeric`]
#'
#' @param width_min_pixels [`numeric`]
#'
#' @param width_max_pixels [`numeric`]
#'
#' @param rounded [`logical`]
#'
#' @param miter_limit [`numeric`]
#'
#' @param billboard [`logical`]
#'
#' @param get_path accessor | [`htmlwidgets::JS`]
#'
#' @param get_color accessor
#'
#' @param get_width accessor | [`numeric`]
#'
#' @param ... additional layer parameters to pass to deck.gl.
#'  `snake_case` parameters will be converted to `snakeCase`.
#'
#' @returns `PathLayer` & [`layer`]
#'  A [PathLayer](https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/path-layer.md) layer.
#'  Add to an [rdeck] map via [`add_layer`] or [`rdeck`].
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/path-layer.md}
#'
#' @export
path_layer <- function(id = NULL,
                       data = NULL,
                       visible = TRUE,
                       pickable = FALSE,
                       opacity = 1,
                       position_format = "XYZ",
                       color_format = "RGBA",
                       auto_highlight = FALSE,
                       highlight_color = c(0, 0, 128, 128),
                       width_units = "meters",
                       width_scale = 1,
                       width_min_pixels = 0,
                       width_max_pixels = 9007199254740991,
                       rounded = FALSE,
                       miter_limit = 4,
                       billboard = FALSE,
                       get_path = NULL,
                       get_color = NULL,
                       get_width = NULL,
                       ...) {
  # auto-resolve geometry column
  if (inherits(data, "sf")) {
    get_path <- as.name(attr(data, "sf_column")) %>%
      accessor(data = data, columnar = TRUE)
  }

  get_color <- substitute(get_color) %>%
    accessor(data = data, columnar = TRUE)

  get_width <- substitute(get_width) %>%
    accessor(data = data, columnar = TRUE)

  params <- c(
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
      get_path = get_path,
      get_color = get_color,
      get_width = get_width
    ),
    list(...)
  )

  do.call(layer, params)
}

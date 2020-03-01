#' [IconLayer](https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/icon-layer.md) deck.gl layer.
#'
#' @name icon_layer
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
#' @param icon_atlas [`list`]
#'
#' @param icon_mapping [`list`]
#'
#' @param size_scale [`numeric`]
#'
#' @param billboard [`logical`]
#'
#' @param size_units `pixels` | `meters`
#'
#' @param size_min_pixels [`numeric`]
#'
#' @param size_max_pixels [`numeric`]
#'
#' @param alpha_cutoff [`numeric`]
#'
#' @param get_position accessor | [`htmlwidgets::JS`]
#'
#' @param get_icon accessor | [`htmlwidgets::JS`]
#'
#' @param get_color accessor
#'
#' @param get_size accessor | [`numeric`]
#'
#' @param get_angle accessor | [`numeric`]
#'
#' @param ... additional layer parameters to pass to deck.gl.
#'  `snake_case` parameters will be converted to `camelCase`.
#'
#' @returns `IconLayer` & [`layer`]
#'  A [IconLayer](https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/icon-layer.md) layer.
#'  Add to an [rdeck] map via [`add_layer`] or [`rdeck`].
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/icon-layer.md}
#'
#' @export
icon_layer <- function(id = NULL,
                       data = NULL,
                       visible = TRUE,
                       pickable = FALSE,
                       opacity = 1,
                       position_format = "XYZ",
                       color_format = "RGBA",
                       auto_highlight = FALSE,
                       highlight_color = c(0, 0, 128, 128),
                       icon_atlas = NULL,
                       icon_mapping = NULL,
                       size_scale = 1,
                       billboard = TRUE,
                       size_units = "pixels",
                       size_min_pixels = 0,
                       size_max_pixels = 9007199254740991,
                       alpha_cutoff = 0.05,
                       get_position = NULL,
                       get_icon = NULL,
                       get_color = NULL,
                       get_size = NULL,
                       get_angle = NULL,
                       ...) {
  # auto-resolve geometry column
  if (inherits(data, "sf")) {
    get_position <- as.name(attr(data, "sf_column")) %>%
      accessor(data = data, columnar = TRUE)
  }

  get_icon <- substitute(get_icon) %>%
    accessor(data = data, columnar = TRUE)

  get_color <- substitute(get_color) %>%
    accessor(data = data, columnar = TRUE)

  get_size <- substitute(get_size) %>%
    accessor(data = data, columnar = TRUE)

  get_angle <- substitute(get_angle) %>%
    accessor(data = data, columnar = TRUE)

  params <- c(
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
      get_position = get_position,
      get_icon = get_icon,
      get_color = get_color,
      get_size = get_size,
      get_angle = get_angle
    ),
    list(...)
  )

  do.call(layer, params)
}

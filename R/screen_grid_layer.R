#' [ScreenGridLayer](https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/screen-grid-layer.md) deck.gl layer.
#'
#' @name screen_grid_layer
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
#' @param cell_size_pixels [`numeric`]
#'
#' @param cell_margin_pixels [`numeric`]
#'
#' @param color_domain [`numeric`]
#'
#' @param color_range [`list`]
#'
#' @param get_position accessor | [`htmlwidgets::JS`]
#'
#' @param get_weight accessor | [`htmlwidgets::JS`]
#'
#' @param gpu_aggregation [`logical`]
#'
#' @param aggregation `SUM` | `MEAN` | `MIN` | `MAX`
#'
#' @param ... additional layer parameters to pass to deck.gl.
#'  `snake_case` parameters will be converted to `camelCase`.
#'
#' @returns `ScreenGridLayer` & [`layer`]
#'  A [ScreenGridLayer](https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/screen-grid-layer.md) layer.
#'  Add to an [rdeck] map via [`add_layer`] or [`rdeck`].
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/screen-grid-layer.md}
#'
#' @export
screen_grid_layer <- function(id = NULL,
                              data = NULL,
                              visible = TRUE,
                              pickable = FALSE,
                              opacity = 1,
                              position_format = "XYZ",
                              color_format = "RGBA",
                              auto_highlight = FALSE,
                              highlight_color = c(0, 0, 128, 128),
                              cell_size_pixels = 100,
                              cell_margin_pixels = 2,
                              color_domain = NULL,
                              color_range = list(
                                c(255, 255, 178),
                                c(254, 217, 118),
                                c(254, 178, 76),
                                c(253, 141, 60),
                                c(240, 59, 32),
                                c(189, 0, 38)
                              ),
                              get_position = NULL,
                              get_weight = NULL,
                              gpu_aggregation = TRUE,
                              aggregation = "SUM",
                              ...) {
  # auto-resolve geometry column
  if (inherits(data, "sf")) {
    get_position <- as.name(attr(data, "sf_column")) %>%
      accessor(data = data, columnar = TRUE)
  }

  get_weight <- substitute(get_weight) %>%
    accessor(data = data, columnar = TRUE)

  params <- c(
    list(
      type = "ScreenGridLayer",
      id = id,
      data = data,
      visible = visible,
      pickable = pickable,
      opacity = opacity,
      position_format = position_format,
      color_format = color_format,
      auto_highlight = auto_highlight,
      highlight_color = highlight_color,
      cell_size_pixels = cell_size_pixels,
      cell_margin_pixels = cell_margin_pixels,
      color_domain = color_domain,
      color_range = color_range,
      get_position = get_position,
      get_weight = get_weight,
      gpu_aggregation = gpu_aggregation,
      aggregation = aggregation
    ),
    list(...)
  )

  do.call(layer, params)
}

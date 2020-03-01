#' [ContourLayer](https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/contour-layer.md) deck.gl layer.
#'
#' @name contour_layer
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
#' @param cell_size [`numeric`]
#'
#' @param get_position accessor | [`htmlwidgets::JS`]
#'
#' @param get_weight accessor | [`htmlwidgets::JS`]
#'
#' @param gpu_aggregation [`logical`]
#'
#' @param aggregation `SUM` | `MEAN` | `MIN` | `MAX`
#'
#' @param contours [`list`]
#'
#' @param z_offset [`numeric`]
#'
#' @param ... additional layer parameters to pass to deck.gl.
#'  `snake_case` parameters will be converted to `snakeCase`.
#'
#' @returns `ContourLayer` & [`layer`]
#'  A [ContourLayer](https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/contour-layer.md) layer.
#'  Add to an [rdeck] map via [`add_layer`] or [`rdeck`].
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/contour-layer.md}
#'
#' @export
contour_layer <- function(id = NULL,
                          data = NULL,
                          visible = TRUE,
                          pickable = FALSE,
                          opacity = 1,
                          position_format = "XYZ",
                          color_format = "RGBA",
                          auto_highlight = FALSE,
                          highlight_color = c(0, 0, 128, 128),
                          cell_size = 1000,
                          get_position = NULL,
                          get_weight = NULL,
                          gpu_aggregation = TRUE,
                          aggregation = "SUM",
                          contours = c(NULL),
                          z_offset = 0.005,
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
      type = "ContourLayer",
      id = id,
      data = data,
      visible = visible,
      pickable = pickable,
      opacity = opacity,
      position_format = position_format,
      color_format = color_format,
      auto_highlight = auto_highlight,
      highlight_color = highlight_color,
      cell_size = cell_size,
      get_position = get_position,
      get_weight = get_weight,
      gpu_aggregation = gpu_aggregation,
      aggregation = aggregation,
      contours = contours,
      z_offset = z_offset
    ),
    list(...)
  )

  do.call(layer, params)
}

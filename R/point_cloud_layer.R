#' [PointCloudLayer](https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/point-cloud-layer.md) deck.gl layer.
#'
#' @name point_cloud_layer
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
#' @param size_units `pixels` | `meters`
#'
#' @param point_size [`numeric`]
#'
#' @param get_position accessor | [`htmlwidgets::JS`]
#'
#' @param get_normal accessor
#'
#' @param get_color accessor
#'
#' @param material [`logical`]
#'
#' @param ... additional layer parameters to pass to deck.gl.
#'  `snake_case` parameters will be converted to `camelCase`.
#'
#' @returns `PointCloudLayer` & [`layer`]
#'  A [PointCloudLayer](https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/point-cloud-layer.md) layer.
#'  Add to an [rdeck] map via [`add_layer`] or [`rdeck`].
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/point-cloud-layer.md}
#'
#' @export
point_cloud_layer <- function(id = NULL,
                              data = NULL,
                              visible = TRUE,
                              pickable = FALSE,
                              opacity = 1,
                              position_format = "XYZ",
                              color_format = "RGBA",
                              auto_highlight = FALSE,
                              highlight_color = c(0, 0, 128, 128),
                              size_units = "pixels",
                              point_size = 10,
                              get_position = NULL,
                              get_normal = NULL,
                              get_color = NULL,
                              material = TRUE,
                              ...) {
  # auto-resolve geometry column
  if (inherits(data, "sf")) {
    get_position <- as.name(attr(data, "sf_column")) %>%
      accessor(data = data, columnar = TRUE)
  }

  get_normal <- substitute(get_normal) %>%
    accessor(data = data, columnar = TRUE)

  get_color <- substitute(get_color) %>%
    accessor(data = data, columnar = TRUE)

  params <- c(
    list(
      type = "PointCloudLayer",
      id = id,
      data = data,
      visible = visible,
      pickable = pickable,
      opacity = opacity,
      position_format = position_format,
      color_format = color_format,
      auto_highlight = auto_highlight,
      highlight_color = highlight_color,
      size_units = size_units,
      point_size = point_size,
      get_position = get_position,
      get_normal = get_normal,
      get_color = get_color,
      material = material
    ),
    list(...)
  )

  do.call(layer, params)
}

#' Add a [PointCloudLayer](https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/point-cloud-layer.md) deck.gl layer to an [rdeck] map.
#'
#' @name add_point_cloud_layer
#'
#' @param rdeck [`rdeck`]
#'  An [rdeck] map.
#'
#' @inheritParams point_cloud_layer
#' @inheritDotParams point_cloud_layer
#'
#' @returns [`rdeck`]
#'  The [rdeck] map.
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/point-cloud-layer.md}
#'
#' @export
add_point_cloud_layer <- function(rdeck,
                                  id = NULL,
                                  data = NULL,
                                  visible = TRUE,
                                  pickable = FALSE,
                                  opacity = 1,
                                  position_format = "XYZ",
                                  color_format = "RGBA",
                                  auto_highlight = FALSE,
                                  highlight_color = c(0, 0, 128, 128),
                                  size_units = "pixels",
                                  point_size = 10,
                                  get_position = NULL,
                                  get_normal = NULL,
                                  get_color = NULL,
                                  material = TRUE,
                                  ...) {
  params <- as.list(match.call())[-(1:2)]
  layer <- do.call(point_cloud_layer, params)

  add_layer(rdeck, layer)
}

#' Add PointCloudLayer to an rdeck map.
#'
#' @name add_point_cloud_layer
#' @param rdeck \`{rdeck}\` an rdeck widget instance
#' @param data `{data.frame | sf}`
#' @param visible `{logical}`
#' @param pickable `{logical}`
#' @param opacity `{numeric}`
#' @param position_format `{"XY" | "XYZ"}`
#' @param color_format `{"RGB" | "RGBA"}`
#' @param auto_highlight `{logical}`
#' @param highlight_color `{integer}`
#' @param size_units `{"pixels" | "meters"}`
#' @param point_size `{numeric}`
#' @param get_position `{accessor | JS}`
#' @param get_normal `{accessor}`
#' @param get_color `{accessor}`
#' @param material `{logical}`
#' @param ... additional layer parameters to pass to deck.gl
#' @returns \`{rdeck}\`
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/point-cloud-layer.md}
#'
#' @export
add_point_cloud_layer <- function(rdeck,
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
  stopifnot(inherits(rdeck, "rdeck"))

  if (inherits(data, "sf")) {
    get_position <- accessor(as.name(attr(data, "sf_column")), data, columnar = TRUE)
  }
  get_normal <- accessor(substitute(get_normal), data, columnar = TRUE)
  get_color <- accessor(substitute(get_color), data, columnar = TRUE)

  params <- c(
    list(
      type = "PointCloudLayer",
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

  do.call(layer, params) %>%
    add_layer(rdeck, .)
}

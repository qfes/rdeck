#' Add HeatmapLayer to an rdeck map.
#'
#' @name add_heatmap_layer
#' @param rdeck \`{rdeck}\` an rdeck widget instance
#' @param data `{data.frame | sf}`
#' @param visible `{logical}`
#' @param pickable `{logical}`
#' @param opacity `{numeric}`
#' @param position_format `{"XY" | "XYZ"}`
#' @param color_format `{"RGB" | "RGBA"}`
#' @param auto_highlight `{logical}`
#' @param highlight_color `{integer}`
#' @param get_position `{accessor | JS}`
#' @param get_weight `{accessor | numeric}`
#' @param intensity `{numeric}`
#' @param radius_pixels `{numeric}`
#' @param color_range `{list}`
#' @param threshold `{numeric}`
#' @param color_domain `{numeric}`
#' @param ... additional layer parameters to pass to deck.gl
#' @returns \`{rdeck}\`
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/heatmap-layer.md}
#'
#' @export
add_heatmap_layer <- function(rdeck,
                              data = NULL,
                              visible = TRUE,
                              pickable = FALSE,
                              opacity = 1,
                              position_format = "XYZ",
                              color_format = "RGBA",
                              auto_highlight = FALSE,
                              highlight_color = c(0, 0, 128, 128),
                              get_position = NULL,
                              get_weight = NULL,
                              intensity = 1,
                              radius_pixels = 50,
                              color_range = list(
                                c(255, 255, 178),
                                c(254, 217, 118),
                                c(254, 178, 76),
                                c(253, 141, 60),
                                c(240, 59, 32),
                                c(189, 0, 38)
                              ),
                              threshold = 0.05,
                              color_domain = NULL,
                              ...) {
  stopifnot(inherits(rdeck, "rdeck"))

  if (inherits(data, "sf")) {
    get_position <- accessor(as.name(attr(data, "sf_column")), data, columnar = TRUE)
  }
  get_weight <- accessor(substitute(get_weight), data, columnar = TRUE)

  params <- c(
    list(
      type = "HeatmapLayer",
      data = data,
      visible = visible,
      pickable = pickable,
      opacity = opacity,
      position_format = position_format,
      color_format = color_format,
      auto_highlight = auto_highlight,
      highlight_color = highlight_color,
      get_position = get_position,
      get_weight = get_weight,
      intensity = intensity,
      radius_pixels = radius_pixels,
      color_range = color_range,
      threshold = threshold,
      color_domain = color_domain
    ),
    list(...)
  )

  do.call(layer, params) %>%
    add_layer(rdeck, .)
}

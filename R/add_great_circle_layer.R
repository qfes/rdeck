#' Add GreatCircleLayer to an rdeck map.
#'
#' @name add_great_circle_layer
#' @param rdeck \`{rdeck}\` an rdeck widget instance
#' @param data `{data.frame | sf}`
#' @param visible `{logical}`
#' @param pickable `{logical}`
#' @param opacity `{numeric}`
#' @param position_format `{"XY" | "XYZ"}`
#' @param color_format `{"RGB" | "RGBA"}`
#' @param auto_highlight `{logical}`
#' @param highlight_color `{integer}`
#' @param get_source_position `{accessor | JS}`
#' @param get_target_position `{accessor | JS}`
#' @param get_source_color `{accessor}`
#' @param get_target_color `{accessor}`
#' @param get_width `{accessor | numeric}`
#' @param get_height `{accessor | numeric}`
#' @param get_tilt `{accessor | numeric}`
#' @param width_units `{"pixels" | "meters"}`
#' @param width_scale `{numeric}`
#' @param width_min_pixels `{numeric}`
#' @param width_max_pixels `{numeric}`
#' @param ... additional layer parameters to pass to deck.gl
#' @returns \`{rdeck}\`
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/great-circle-layer.md}
#'
#' @export
add_great_circle_layer <- function(rdeck,
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
                                   get_source_color = NULL,
                                   get_target_color = NULL,
                                   get_width = NULL,
                                   get_height = NULL,
                                   get_tilt = NULL,
                                   width_units = "pixels",
                                   width_scale = 1,
                                   width_min_pixels = 0,
                                   width_max_pixels = 9007199254740991,
                                   ...) {
  stopifnot(inherits(rdeck, "rdeck"))

  get_source_position <- accessor(data, substitute(get_source_position))
  get_target_position <- accessor(data, substitute(get_target_position))
  get_source_color <- accessor(data, substitute(get_source_color))
  get_target_color <- accessor(data, substitute(get_target_color))
  get_width <- accessor(data, substitute(get_width))
  get_height <- accessor(data, substitute(get_height))
  get_tilt <- accessor(data, substitute(get_tilt))

  params <- c(
    list(
      type = "GreatCircleLayer",
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
      get_source_color = get_source_color,
      get_target_color = get_target_color,
      get_width = get_width,
      get_height = get_height,
      get_tilt = get_tilt,
      width_units = width_units,
      width_scale = width_scale,
      width_min_pixels = width_min_pixels,
      width_max_pixels = width_max_pixels
    ),
    list(...)
  )

  do.call(layer, params) %>%
    add_layer(rdeck, .)
}

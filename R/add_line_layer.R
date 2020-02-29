#' Add LineLayer to an rdeck map.
#'
#' @name add_line_layer
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
#' @param get_color `{accessor}`
#' @param get_width `{accessor | numeric}`
#' @param width_units `{"pixels" | "meters"}`
#' @param width_scale `{numeric}`
#' @param width_min_pixels `{numeric}`
#' @param width_max_pixels `{numeric}`
#' @param ... additional layer parameters to pass to deck.gl
#' @returns \`{rdeck}\`
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/line-layer.md}
#'
#' @export
add_line_layer <- function(rdeck,
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
  stopifnot(inherits(rdeck, "rdeck"))

  get_source_position <- accessor(substitute(get_source_position), data, columnar = TRUE)
  get_target_position <- accessor(substitute(get_target_position), data, columnar = TRUE)
  get_color <- accessor(substitute(get_color), data, columnar = TRUE)
  get_width <- accessor(substitute(get_width), data, columnar = TRUE)

  params <- c(
    list(
      type = "LineLayer",
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

  do.call(layer, params) %>%
    add_layer(rdeck, .)
}

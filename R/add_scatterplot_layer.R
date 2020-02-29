#' Add ScatterplotLayer to an rdeck map.
#'
#' @name add_scatterplot_layer
#' @param rdeck \`{rdeck}\` an rdeck widget instance
#' @param data `{data.frame | sf}`
#' @param visible `{logical}`
#' @param pickable `{logical}`
#' @param opacity `{numeric}`
#' @param position_format `{"XY" | "XYZ"}`
#' @param color_format `{"RGB" | "RGBA"}`
#' @param auto_highlight `{logical}`
#' @param highlight_color `{integer}`
#' @param radius_scale `{numeric}`
#' @param radius_min_pixels `{numeric}`
#' @param radius_max_pixels `{numeric}`
#' @param line_width_units `{"pixels" | "meters"}`
#' @param line_width_scale `{numeric}`
#' @param line_width_min_pixels `{numeric}`
#' @param line_width_max_pixels `{numeric}`
#' @param stroked `{logical}`
#' @param filled `{logical}`
#' @param get_position `{accessor | JS}`
#' @param get_radius `{accessor | numeric}`
#' @param get_fill_color `{accessor}`
#' @param get_line_color `{accessor}`
#' @param get_line_width `{accessor | numeric}`
#' @param ... additional layer parameters to pass to deck.gl
#' @returns \`{rdeck}\`
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/scatterplot-layer.md}
#'
#' @export
add_scatterplot_layer <- function(rdeck,
                                  data = NULL,
                                  visible = TRUE,
                                  pickable = FALSE,
                                  opacity = 1,
                                  position_format = "XYZ",
                                  color_format = "RGBA",
                                  auto_highlight = FALSE,
                                  highlight_color = c(0, 0, 128, 128),
                                  radius_scale = 1,
                                  radius_min_pixels = 0,
                                  radius_max_pixels = 9007199254740991,
                                  line_width_units = "meters",
                                  line_width_scale = 1,
                                  line_width_min_pixels = 0,
                                  line_width_max_pixels = 9007199254740991,
                                  stroked = FALSE,
                                  filled = TRUE,
                                  get_position = NULL,
                                  get_radius = NULL,
                                  get_fill_color = NULL,
                                  get_line_color = NULL,
                                  get_line_width = NULL,
                                  ...) {
  stopifnot(inherits(rdeck, "rdeck"))

  if (inherits(data, "sf")) {
    get_position <- accessor(data, as.name(attr(data, "sf_column")))
  }
  get_radius <- accessor(data, substitute(get_radius))
  get_fill_color <- accessor(data, substitute(get_fill_color))
  get_line_color <- accessor(data, substitute(get_line_color))
  get_line_width <- accessor(data, substitute(get_line_width))

  params <- c(
    list(
      type = "ScatterplotLayer",
      data = data,
      visible = visible,
      pickable = pickable,
      opacity = opacity,
      position_format = position_format,
      color_format = color_format,
      auto_highlight = auto_highlight,
      highlight_color = highlight_color,
      radius_scale = radius_scale,
      radius_min_pixels = radius_min_pixels,
      radius_max_pixels = radius_max_pixels,
      line_width_units = line_width_units,
      line_width_scale = line_width_scale,
      line_width_min_pixels = line_width_min_pixels,
      line_width_max_pixels = line_width_max_pixels,
      stroked = stroked,
      filled = filled,
      get_position = get_position,
      get_radius = get_radius,
      get_fill_color = get_fill_color,
      get_line_color = get_line_color,
      get_line_width = get_line_width
    ),
    list(...)
  )

  do.call(layer, params) %>%
    add_layer(rdeck, .)
}

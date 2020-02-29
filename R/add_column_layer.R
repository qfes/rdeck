#' Add ColumnLayer to an rdeck map.
#'
#' @name add_column_layer
#' @param rdeck \`{rdeck}\` an rdeck widget instance
#' @param data `{data.frame | sf}`
#' @param visible `{logical}`
#' @param pickable `{logical}`
#' @param opacity `{numeric}`
#' @param position_format `{"XY" | "XYZ"}`
#' @param color_format `{"RGB" | "RGBA"}`
#' @param auto_highlight `{logical}`
#' @param highlight_color `{integer}`
#' @param disk_resolution `{numeric}`
#' @param vertices `{list}`
#' @param radius `{numeric}`
#' @param angle `{numeric}`
#' @param offset `{numeric}`
#' @param coverage `{numeric}`
#' @param elevation_scale `{numeric}`
#' @param line_width_units `{"pixels" | "meters"}`
#' @param line_width_scale `{numeric}`
#' @param line_width_min_pixels `{numeric}`
#' @param line_width_max_pixels `{numeric}`
#' @param extruded `{logical}`
#' @param wireframe `{logical}`
#' @param filled `{logical}`
#' @param stroked `{logical}`
#' @param get_position `{accessor | JS}`
#' @param get_fill_color `{accessor}`
#' @param get_line_color `{accessor}`
#' @param get_line_width `{accessor | numeric}`
#' @param get_elevation `{accessor | numeric}`
#' @param material `{logical}`
#' @param ... additional layer parameters to pass to deck.gl
#' @returns \`{rdeck}\`
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/column-layer.md}
#'
#' @export
add_column_layer <- function(rdeck,
                             data = NULL,
                             visible = TRUE,
                             pickable = FALSE,
                             opacity = 1,
                             position_format = "XYZ",
                             color_format = "RGBA",
                             auto_highlight = FALSE,
                             highlight_color = c(0, 0, 128, 128),
                             disk_resolution = 20,
                             vertices = NULL,
                             radius = 1000,
                             angle = 0,
                             offset = c(0, 0),
                             coverage = 1,
                             elevation_scale = 1,
                             line_width_units = "meters",
                             line_width_scale = 1,
                             line_width_min_pixels = 0,
                             line_width_max_pixels = 9007199254740991,
                             extruded = TRUE,
                             wireframe = FALSE,
                             filled = TRUE,
                             stroked = FALSE,
                             get_position = NULL,
                             get_fill_color = NULL,
                             get_line_color = NULL,
                             get_line_width = NULL,
                             get_elevation = NULL,
                             material = TRUE,
                             ...) {
  stopifnot(inherits(rdeck, "rdeck"))

  if (inherits(data, "sf")) {
    get_position <- accessor(data, as.name(attr(data, "sf_column")))
  }
  get_fill_color <- accessor(data, substitute(get_fill_color))
  get_line_color <- accessor(data, substitute(get_line_color))
  get_line_width <- accessor(data, substitute(get_line_width))
  get_elevation <- accessor(data, substitute(get_elevation))

  params <- c(
    list(
      type = "ColumnLayer",
      data = data,
      visible = visible,
      pickable = pickable,
      opacity = opacity,
      position_format = position_format,
      color_format = color_format,
      auto_highlight = auto_highlight,
      highlight_color = highlight_color,
      disk_resolution = disk_resolution,
      vertices = vertices,
      radius = radius,
      angle = angle,
      offset = offset,
      coverage = coverage,
      elevation_scale = elevation_scale,
      line_width_units = line_width_units,
      line_width_scale = line_width_scale,
      line_width_min_pixels = line_width_min_pixels,
      line_width_max_pixels = line_width_max_pixels,
      extruded = extruded,
      wireframe = wireframe,
      filled = filled,
      stroked = stroked,
      get_position = get_position,
      get_fill_color = get_fill_color,
      get_line_color = get_line_color,
      get_line_width = get_line_width,
      get_elevation = get_elevation,
      material = material
    ),
    list(...)
  )

  do.call(layer, params) %>%
    add_layer(rdeck, .)
}

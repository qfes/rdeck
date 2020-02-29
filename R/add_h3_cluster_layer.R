#' Add H3ClusterLayer to an rdeck map.
#'
#' @name add_h3_cluster_layer
#' @param rdeck \`{rdeck}\` an rdeck widget instance
#' @param data `{data.frame | sf}`
#' @param visible `{logical}`
#' @param pickable `{logical}`
#' @param opacity `{numeric}`
#' @param position_format `{"XY" | "XYZ"}`
#' @param color_format `{"RGB" | "RGBA"}`
#' @param auto_highlight `{logical}`
#' @param highlight_color `{integer}`
#' @param get_hexagons `{accessor | JS}`
#' @param stroked `{logical}`
#' @param filled `{logical}`
#' @param extruded `{logical}`
#' @param elevation_scale `{numeric}`
#' @param wireframe `{logical}`
#' @param line_width_units `{"pixels" | "meters"}`
#' @param line_width_scale `{numeric}`
#' @param line_width_min_pixels `{numeric}`
#' @param line_width_max_pixels `{numeric}`
#' @param line_joint_rounded `{logical}`
#' @param line_miter_limit `{numeric}`
#' @param get_polygon `{accessor | JS}`
#' @param get_fill_color `{accessor}`
#' @param get_line_color `{accessor}`
#' @param get_line_width `{accessor | numeric}`
#' @param get_elevation `{accessor | numeric}`
#' @param material `{logical}`
#' @param ... additional layer parameters to pass to deck.gl
#' @returns \`{rdeck}\`
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/h3-cluster-layer.md}
#'
#' @export
add_h3_cluster_layer <- function(rdeck,
                                 data = NULL,
                                 visible = TRUE,
                                 pickable = FALSE,
                                 opacity = 1,
                                 position_format = "XYZ",
                                 color_format = "RGBA",
                                 auto_highlight = FALSE,
                                 highlight_color = c(0, 0, 128, 128),
                                 get_hexagons = NULL,
                                 stroked = TRUE,
                                 filled = TRUE,
                                 extruded = FALSE,
                                 elevation_scale = 1,
                                 wireframe = FALSE,
                                 line_width_units = "meters",
                                 line_width_scale = 1,
                                 line_width_min_pixels = 0,
                                 line_width_max_pixels = 9007199254740991,
                                 line_joint_rounded = FALSE,
                                 line_miter_limit = 4,
                                 get_polygon = NULL,
                                 get_fill_color = NULL,
                                 get_line_color = NULL,
                                 get_line_width = NULL,
                                 get_elevation = NULL,
                                 material = TRUE,
                                 ...) {
  stopifnot(inherits(rdeck, "rdeck"))

  get_hexagons <- accessor(substitute(get_hexagons), data, columnar = TRUE)
  if (inherits(data, "sf")) {
    get_polygon <- accessor(as.name(attr(data, "sf_column")), data, columnar = TRUE)
  }
  get_fill_color <- accessor(substitute(get_fill_color), data, columnar = TRUE)
  get_line_color <- accessor(substitute(get_line_color), data, columnar = TRUE)
  get_line_width <- accessor(substitute(get_line_width), data, columnar = TRUE)
  get_elevation <- accessor(substitute(get_elevation), data, columnar = TRUE)

  params <- c(
    list(
      type = "H3ClusterLayer",
      data = data,
      visible = visible,
      pickable = pickable,
      opacity = opacity,
      position_format = position_format,
      color_format = color_format,
      auto_highlight = auto_highlight,
      highlight_color = highlight_color,
      get_hexagons = get_hexagons,
      stroked = stroked,
      filled = filled,
      extruded = extruded,
      elevation_scale = elevation_scale,
      wireframe = wireframe,
      line_width_units = line_width_units,
      line_width_scale = line_width_scale,
      line_width_min_pixels = line_width_min_pixels,
      line_width_max_pixels = line_width_max_pixels,
      line_joint_rounded = line_joint_rounded,
      line_miter_limit = line_miter_limit,
      get_polygon = get_polygon,
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

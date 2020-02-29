#' Add SolidPolygonLayer to an rdeck map.
#'
#' @name add_solid_polygon_layer
#' @param rdeck \`{rdeck}\` an rdeck widget instance
#' @param data `{data.frame | sf}`
#' @param visible `{logical}`
#' @param pickable `{logical}`
#' @param opacity `{numeric}`
#' @param position_format `{"XY" | "XYZ"}`
#' @param color_format `{"RGB" | "RGBA"}`
#' @param auto_highlight `{logical}`
#' @param highlight_color `{integer}`
#' @param filled `{logical}`
#' @param extruded `{logical}`
#' @param wireframe `{logical}`
#' @param elevation_scale `{numeric}`
#' @param get_polygon `{accessor | JS}`
#' @param get_elevation `{accessor | numeric}`
#' @param get_fill_color `{accessor}`
#' @param get_line_color `{accessor}`
#' @param material `{logical}`
#' @param ... additional layer parameters to pass to deck.gl
#' @returns \`{rdeck}\`
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/solid-polygon-layer.md}
#'
#' @export
add_solid_polygon_layer <- function(rdeck,
                                    data = NULL,
                                    visible = TRUE,
                                    pickable = FALSE,
                                    opacity = 1,
                                    position_format = "XYZ",
                                    color_format = "RGBA",
                                    auto_highlight = FALSE,
                                    highlight_color = c(0, 0, 128, 128),
                                    filled = TRUE,
                                    extruded = FALSE,
                                    wireframe = FALSE,
                                    elevation_scale = 1,
                                    get_polygon = NULL,
                                    get_elevation = NULL,
                                    get_fill_color = NULL,
                                    get_line_color = NULL,
                                    material = TRUE,
                                    ...) {
  stopifnot(inherits(rdeck, "rdeck"))

  if (inherits(data, "sf")) {
    get_polygon <- accessor(as.name(attr(data, "sf_column")), data, columnar = TRUE)
  }
  get_elevation <- accessor(substitute(get_elevation), data, columnar = TRUE)
  get_fill_color <- accessor(substitute(get_fill_color), data, columnar = TRUE)
  get_line_color <- accessor(substitute(get_line_color), data, columnar = TRUE)

  params <- c(
    list(
      type = "SolidPolygonLayer",
      data = data,
      visible = visible,
      pickable = pickable,
      opacity = opacity,
      position_format = position_format,
      color_format = color_format,
      auto_highlight = auto_highlight,
      highlight_color = highlight_color,
      filled = filled,
      extruded = extruded,
      wireframe = wireframe,
      elevation_scale = elevation_scale,
      get_polygon = get_polygon,
      get_elevation = get_elevation,
      get_fill_color = get_fill_color,
      get_line_color = get_line_color,
      material = material
    ),
    list(...)
  )

  do.call(layer, params) %>%
    add_layer(rdeck, .)
}

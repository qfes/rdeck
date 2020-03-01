#' [GeoJsonLayer](https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/geojson-layer.md) deck.gl layer.
#'
#' @name geojson_layer
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
#' @param stroked [`logical`]
#'
#' @param filled [`logical`]
#'
#' @param extruded [`logical`]
#'
#' @param wireframe [`logical`]
#'
#' @param line_width_units `pixels` | `meters`
#'
#' @param line_width_scale [`numeric`]
#'
#' @param line_width_min_pixels [`numeric`]
#'
#' @param line_width_max_pixels [`numeric`]
#'
#' @param line_joint_rounded [`logical`]
#'
#' @param line_miter_limit [`numeric`]
#'
#' @param elevation_scale [`numeric`]
#'
#' @param point_radius_scale [`numeric`]
#'
#' @param point_radius_min_pixels [`numeric`]
#'
#' @param point_radius_max_pixels [`numeric`]
#'
#' @param get_line_color accessor
#'
#' @param get_fill_color accessor
#'
#' @param get_radius accessor | [`numeric`]
#'
#' @param get_line_width accessor | [`numeric`]
#'
#' @param get_elevation accessor | [`numeric`]
#'
#' @param material [`logical`]
#'
#' @param ... additional layer parameters to pass to deck.gl.
#'  `snake_case` parameters will be converted to `camelCase`.
#'
#' @returns `GeoJsonLayer` & [`layer`]
#'  A [GeoJsonLayer](https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/geojson-layer.md) layer.
#'  Add to an [rdeck] map via [`add_layer`] or [`rdeck`].
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/geojson-layer.md}
#'
#' @export
geojson_layer <- function(id = NULL,
                          data = NULL,
                          visible = TRUE,
                          pickable = FALSE,
                          opacity = 1,
                          position_format = "XYZ",
                          color_format = "RGBA",
                          auto_highlight = FALSE,
                          highlight_color = c(0, 0, 128, 128),
                          stroked = TRUE,
                          filled = TRUE,
                          extruded = FALSE,
                          wireframe = FALSE,
                          line_width_units = "meters",
                          line_width_scale = 1,
                          line_width_min_pixels = 0,
                          line_width_max_pixels = 9007199254740991,
                          line_joint_rounded = FALSE,
                          line_miter_limit = 4,
                          elevation_scale = 1,
                          point_radius_scale = 1,
                          point_radius_min_pixels = 0,
                          point_radius_max_pixels = 9007199254740991,
                          get_line_color = NULL,
                          get_fill_color = NULL,
                          get_radius = NULL,
                          get_line_width = NULL,
                          get_elevation = NULL,
                          material = TRUE,
                          ...) {
  get_line_color <- substitute(get_line_color) %>%
    accessor(data = data, columnar = FALSE)

  get_fill_color <- substitute(get_fill_color) %>%
    accessor(data = data, columnar = FALSE)

  get_radius <- substitute(get_radius) %>%
    accessor(data = data, columnar = FALSE)

  get_line_width <- substitute(get_line_width) %>%
    accessor(data = data, columnar = FALSE)

  get_elevation <- substitute(get_elevation) %>%
    accessor(data = data, columnar = FALSE)

  params <- c(
    list(
      type = "GeoJsonLayer",
      id = id,
      data = data,
      visible = visible,
      pickable = pickable,
      opacity = opacity,
      position_format = position_format,
      color_format = color_format,
      auto_highlight = auto_highlight,
      highlight_color = highlight_color,
      stroked = stroked,
      filled = filled,
      extruded = extruded,
      wireframe = wireframe,
      line_width_units = line_width_units,
      line_width_scale = line_width_scale,
      line_width_min_pixels = line_width_min_pixels,
      line_width_max_pixels = line_width_max_pixels,
      line_joint_rounded = line_joint_rounded,
      line_miter_limit = line_miter_limit,
      elevation_scale = elevation_scale,
      point_radius_scale = point_radius_scale,
      point_radius_min_pixels = point_radius_min_pixels,
      point_radius_max_pixels = point_radius_max_pixels,
      get_line_color = get_line_color,
      get_fill_color = get_fill_color,
      get_radius = get_radius,
      get_line_width = get_line_width,
      get_elevation = get_elevation,
      material = material
    ),
    list(...)
  )

  do.call(layer, params)
}

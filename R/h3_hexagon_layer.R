#' [H3HexagonLayer](https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/h3-hexagon-layer.md) deck.gl layer.
#'
#' @name h3_hexagon_layer
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
#' @param elevation_scale [`numeric`]
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
#' @param get_polygon accessor | [`htmlwidgets::JS`]
#'
#' @param get_fill_color accessor
#'
#' @param get_line_color accessor
#'
#' @param get_line_width accessor | [`numeric`]
#'
#' @param get_elevation accessor | [`numeric`]
#'
#' @param material [`logical`]
#'
#' @param high_precision [`logical`]
#'
#' @param coverage [`numeric`]
#'
#' @param get_hexagon accessor | [`htmlwidgets::JS`]
#'
#' @param ... additional layer parameters to pass to deck.gl.
#'  `snake_case` parameters will be converted to `snakeCase`.
#'
#' @returns `H3HexagonLayer` & [`layer`]
#'  A [H3HexagonLayer](https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/h3-hexagon-layer.md) layer.
#'  Add to an [rdeck] map via [`add_layer`] or [`rdeck`].
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/h3-hexagon-layer.md}
#'
#' @export
h3_hexagon_layer <- function(id = NULL,
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
                             extruded = TRUE,
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
                             high_precision = FALSE,
                             coverage = 1,
                             get_hexagon = NULL,
                             ...) {
  # auto-resolve geometry column
  if (inherits(data, "sf")) {
    get_polygon <- as.name(attr(data, "sf_column")) %>%
      accessor(data = data, columnar = TRUE)
  }

  get_fill_color <- substitute(get_fill_color) %>%
    accessor(data = data, columnar = TRUE)

  get_line_color <- substitute(get_line_color) %>%
    accessor(data = data, columnar = TRUE)

  get_line_width <- substitute(get_line_width) %>%
    accessor(data = data, columnar = TRUE)

  get_elevation <- substitute(get_elevation) %>%
    accessor(data = data, columnar = TRUE)

  get_hexagon <- substitute(get_hexagon) %>%
    accessor(data = data, columnar = TRUE)

  params <- c(
    list(
      type = "H3HexagonLayer",
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
      material = material,
      high_precision = high_precision,
      coverage = coverage,
      get_hexagon = get_hexagon
    ),
    list(...)
  )

  do.call(layer, params)
}

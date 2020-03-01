#' [SolidPolygonLayer](https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/solid-polygon-layer.md) deck.gl layer.
#'
#' @name solid_polygon_layer
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
#' @param filled [`logical`]
#'
#' @param extruded [`logical`]
#'
#' @param wireframe [`logical`]
#'
#' @param elevation_scale [`numeric`]
#'
#' @param get_polygon accessor | [`htmlwidgets::JS`]
#'
#' @param get_elevation accessor | [`numeric`]
#'
#' @param get_fill_color accessor
#'
#' @param get_line_color accessor
#'
#' @param material [`logical`]
#'
#' @param ... additional layer parameters to pass to deck.gl.
#'  `snake_case` parameters will be converted to `camelCase`.
#'
#' @returns `SolidPolygonLayer` & [`layer`]
#'  A [SolidPolygonLayer](https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/solid-polygon-layer.md) layer.
#'  Add to an [rdeck] map via [`add_layer`] or [`rdeck`].
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/solid-polygon-layer.md}
#'
#' @export
solid_polygon_layer <- function(id = NULL,
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
  # auto-resolve geometry column
  if (inherits(data, "sf")) {
    get_polygon <- as.name(attr(data, "sf_column")) %>%
      accessor(data = data, columnar = TRUE)
  }

  get_elevation <- substitute(get_elevation) %>%
    accessor(data = data, columnar = TRUE)

  get_fill_color <- substitute(get_fill_color) %>%
    accessor(data = data, columnar = TRUE)

  get_line_color <- substitute(get_line_color) %>%
    accessor(data = data, columnar = TRUE)

  params <- c(
    list(
      type = "SolidPolygonLayer",
      id = id,
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

  do.call(layer, params)
}

#' Add a [SolidPolygonLayer](https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/solid-polygon-layer.md) deck.gl layer to an [rdeck] map.
#'
#' @name add_solid_polygon_layer
#'
#' @param rdeck [`rdeck`]
#'  An [rdeck] map.
#'
#' @inheritParams solid_polygon_layer
#' @inheritDotParams solid_polygon_layer
#'
#' @returns [`rdeck`]
#'  The [rdeck] map.
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/solid-polygon-layer.md}
#'
#' @export
add_solid_polygon_layer <- function(rdeck,
                                    id = NULL,
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
  params <- as.list(match.call())[-(1:2)]
  layer <- do.call(solid_polygon_layer, params)

  add_layer(rdeck, layer)
}

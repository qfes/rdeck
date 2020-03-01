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

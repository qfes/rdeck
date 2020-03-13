#' @name solid_polygon_layer
#' @template solid_polygon_layer
#' @family layers
#' @export
solid_polygon_layer <- function(id = "SolidPolygonLayer",
                                data = data.frame(),
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
                                get_polygon = polygon,
                                get_elevation = 1000,
                                get_fill_color = c(0, 0, 0, 255),
                                get_line_color = c(0, 0, 0, 255),
                                material = TRUE,
                                ...) {
  arguments <- get_arguments()
  parameters <- c(
    list(type = "SolidPolygonLayer"),
    get_arguments()
  )
  # auto-resolve geometry
  if (inherits(data, "sf")) {
    parameters$get_polygon <- as.name(attr(data, "sf_column"))
  }

  do.call(layer, parameters)
}

#' @name add_solid_polygon_layer
#' @template solid_polygon_layer
#' @param rdeck `rdeck`
#' @family add_layers
#' @export
add_solid_polygon_layer <- function(rdeck,
                                    id = "SolidPolygonLayer",
                                    data = data.frame(),
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
                                    get_polygon = polygon,
                                    get_elevation = 1000,
                                    get_fill_color = c(0, 0, 0, 255),
                                    get_line_color = c(0, 0, 0, 255),
                                    material = TRUE,
                                    ...) {
  parameters <- get_arguments()[-1]
  layer <- do.call(solid_polygon_layer, parameters)

  add_layer(rdeck, layer)
}

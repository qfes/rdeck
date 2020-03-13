#' @name grid_cell_layer
#' @template grid_cell_layer
#' @family layers
#' @export
grid_cell_layer <- function(id = "GridCellLayer",
                            data = data.frame(),
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
                            offset = c(1, 1),
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
                            get_position = position,
                            get_fill_color = c(0, 0, 0, 255),
                            get_line_color = c(0, 0, 0, 255),
                            get_line_width = 1,
                            get_elevation = 1000,
                            material = TRUE,
                            cell_size = 1000,
                            ...) {
  arguments <- get_arguments()
  parameters <- c(
    list(type = "GridCellLayer"),
    get_arguments()
  )
  # auto-resolve geometry
  if (inherits(data, "sf")) {
    parameters$get_position <- as.name(attr(data, "sf_column"))
  }

  do.call(layer, parameters)
}

#' @name add_grid_cell_layer
#' @template grid_cell_layer
#' @param rdeck `rdeck`
#' @family add_layers
#' @export
add_grid_cell_layer <- function(rdeck,
                                id = "GridCellLayer",
                                data = data.frame(),
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
                                offset = c(1, 1),
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
                                get_position = position,
                                get_fill_color = c(0, 0, 0, 255),
                                get_line_color = c(0, 0, 0, 255),
                                get_line_width = 1,
                                get_elevation = 1000,
                                material = TRUE,
                                cell_size = 1000,
                                ...) {
  parameters <- get_arguments()[-1]
  layer <- do.call(grid_cell_layer, parameters)

  add_layer(rdeck, layer)
}

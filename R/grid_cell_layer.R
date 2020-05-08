# generated code: this code was generated from deck.gl v8.1.1


#' @rdname grid_cell_layer
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
                            highlight_color = "#00008080",
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
                            get_fill_color = "#000000ff",
                            get_line_color = "#000000ff",
                            get_line_width = 1,
                            get_elevation = 1000,
                            material = TRUE,
                            cell_size = 1000,
                            ...) {
  arguments <- get_layer_arguments()
  parameters <- c(
    list(type = "GridCellLayer"),
    get_layer_arguments()
  )
  # auto-resolve geometry
  if (inherits(data, "sf")) {
    parameters$get_position <- as.name(attr(data, "sf_column"))
  }

  do.call(layer, parameters)
}

#' @describeIn grid_cell_layer
#' Add GridCellLayer to an rdeck map
#' @inheritParams add_layer
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
                                highlight_color = "#00008080",
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
                                get_fill_color = "#000000ff",
                                get_line_color = "#000000ff",
                                get_line_width = 1,
                                get_elevation = 1000,
                                material = TRUE,
                                cell_size = 1000,
                                ...) {
  parameters <- get_layer_arguments()[-1]
  layer <- do.call(grid_cell_layer, parameters)

  add_layer(rdeck, layer)
}

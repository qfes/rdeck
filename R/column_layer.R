#' @name column_layer
#' @template column_layer
#' @family layers
#' @export
column_layer <- function(id = "ColumnLayer",
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
                         get_position = position,
                         get_fill_color = "#000000ff",
                         get_line_color = "#000000ff",
                         get_line_width = 1,
                         get_elevation = 1000,
                         material = TRUE,
                         ...) {
  arguments <- get_arguments()
  parameters <- c(
    list(type = "ColumnLayer"),
    get_arguments()
  )
  # auto-resolve geometry
  if (inherits(data, "sf")) {
    parameters$get_position <- as.name(attr(data, "sf_column"))
  }

  do.call(layer, parameters)
}

#' @name add_column_layer
#' @template column_layer
#' @param rdeck `rdeck`
#' @family add_layers
#' @export
add_column_layer <- function(rdeck,
                             id = "ColumnLayer",
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
                             get_position = position,
                             get_fill_color = "#000000ff",
                             get_line_color = "#000000ff",
                             get_line_width = 1,
                             get_elevation = 1000,
                             material = TRUE,
                             ...) {
  parameters <- get_arguments()[-1]
  layer <- do.call(column_layer, parameters)

  add_layer(rdeck, layer)
}

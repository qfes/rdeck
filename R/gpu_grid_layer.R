# generated code: this code was generated from deck.gl v8.1.1


#' @rdname gpu_grid_layer
#' @template gpu_grid_layer
#' @family layers
#' @export
gpu_grid_layer <- function(id = "GPUGridLayer",
                           data = data.frame(),
                           visible = TRUE,
                           pickable = FALSE,
                           opacity = 1,
                           position_format = "XYZ",
                           color_format = "RGBA",
                           auto_highlight = FALSE,
                           highlight_color = "#00008080",
                           color_domain = NULL,
                           color_range = c(
                             "#ffffb2",
                             "#fed976",
                             "#feb24c",
                             "#fd8d3c",
                             "#f03b20",
                             "#bd0026"
                           ),
                           get_color_weight = 1,
                           color_aggregation = "SUM",
                           elevation_domain = NULL,
                           elevation_range = c(0, 1000),
                           get_elevation_weight = 1,
                           elevation_aggregation = "SUM",
                           elevation_scale = 1,
                           cell_size = 1000,
                           coverage = 1,
                           get_position = position,
                           extruded = FALSE,
                           material = TRUE,
                           ...) {
  arguments <- get_arguments()
  parameters <- c(
    list(type = "GPUGridLayer"),
    get_arguments()
  )
  # auto-resolve geometry
  if (inherits(data, "sf")) {
    parameters$get_position <- as.name(attr(data, "sf_column"))
  }

  do.call(layer, parameters)
}

#' @describeIn gpu_grid_layer
#' Add GPUGridLayer to an rdeck map
#' @inheritParams add_layer
#' @export
add_gpu_grid_layer <- function(rdeck,
                               id = "GPUGridLayer",
                               data = data.frame(),
                               visible = TRUE,
                               pickable = FALSE,
                               opacity = 1,
                               position_format = "XYZ",
                               color_format = "RGBA",
                               auto_highlight = FALSE,
                               highlight_color = "#00008080",
                               color_domain = NULL,
                               color_range = c(
                                 "#ffffb2",
                                 "#fed976",
                                 "#feb24c",
                                 "#fd8d3c",
                                 "#f03b20",
                                 "#bd0026"
                               ),
                               get_color_weight = 1,
                               color_aggregation = "SUM",
                               elevation_domain = NULL,
                               elevation_range = c(0, 1000),
                               get_elevation_weight = 1,
                               elevation_aggregation = "SUM",
                               elevation_scale = 1,
                               cell_size = 1000,
                               coverage = 1,
                               get_position = position,
                               extruded = FALSE,
                               material = TRUE,
                               ...) {
  parameters <- get_arguments()[-1]
  layer <- do.call(gpu_grid_layer, parameters)

  add_layer(rdeck, layer)
}

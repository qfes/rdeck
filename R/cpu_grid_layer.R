#' @name cpu_grid_layer
#' @template cpu_grid_layer
#' @family layers
#' @export
cpu_grid_layer <- function(id = "CPUGridLayer",
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
                           get_color_value = NULL,
                           get_color_weight = 1,
                           color_aggregation = "SUM",
                           lower_percentile = 0,
                           upper_percentile = 100,
                           color_scale_type = "quantize",
                           elevation_domain = NULL,
                           elevation_range = c(0, 1000),
                           get_elevation_value = NULL,
                           get_elevation_weight = 1,
                           elevation_aggregation = "SUM",
                           elevation_lower_percentile = 0,
                           elevation_upper_percentile = 100,
                           elevation_scale = 1,
                           elevation_scale_type = "linear",
                           grid_aggregator = NULL,
                           cell_size = 1000,
                           coverage = 1,
                           get_position = position,
                           extruded = FALSE,
                           material = TRUE,
                           ...) {
  arguments <- get_arguments()
  parameters <- c(
    list(type = "CPUGridLayer"),
    get_arguments()
  )
  # auto-resolve geometry
  if (inherits(data, "sf")) {
    parameters$get_position <- as.name(attr(data, "sf_column"))
  }

  do.call(layer, parameters)
}

#' @name add_cpu_grid_layer
#' @template cpu_grid_layer
#' @param rdeck `rdeck`
#' @family add_layers
#' @export
add_cpu_grid_layer <- function(rdeck,
                               id = "CPUGridLayer",
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
                               get_color_value = NULL,
                               get_color_weight = 1,
                               color_aggregation = "SUM",
                               lower_percentile = 0,
                               upper_percentile = 100,
                               color_scale_type = "quantize",
                               elevation_domain = NULL,
                               elevation_range = c(0, 1000),
                               get_elevation_value = NULL,
                               get_elevation_weight = 1,
                               elevation_aggregation = "SUM",
                               elevation_lower_percentile = 0,
                               elevation_upper_percentile = 100,
                               elevation_scale = 1,
                               elevation_scale_type = "linear",
                               grid_aggregator = NULL,
                               cell_size = 1000,
                               coverage = 1,
                               get_position = position,
                               extruded = FALSE,
                               material = TRUE,
                               ...) {
  parameters <- get_arguments()[-1]
  layer <- do.call(cpu_grid_layer, parameters)

  add_layer(rdeck, layer)
}

# generated code: this code was generated from deck.gl v8.1.1


#' @rdname grid_layer
#' @template grid_layer
#' @family layers
#' @export
grid_layer <- function(id = "GridLayer",
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
                       get_color_value = NULL,
                       lower_percentile = 0,
                       upper_percentile = 100,
                       color_scale_type = "quantize",
                       get_elevation_value = NULL,
                       elevation_lower_percentile = 0,
                       elevation_upper_percentile = 100,
                       elevation_scale_type = "linear",
                       grid_aggregator = NULL,
                       gpu_aggregation = FALSE,
                       ...) {
  arguments <- get_arguments()
  parameters <- c(
    list(type = "GridLayer"),
    get_arguments()
  )
  # auto-resolve geometry
  if (inherits(data, "sf")) {
    parameters$get_position <- as.name(attr(data, "sf_column"))
  }

  do.call(layer, parameters)
}

#' @describeIn grid_layer
#' Add GridLayer to an rdeck map
#' @inheritParams add_layer
#' @export
add_grid_layer <- function(rdeck,
                           id = "GridLayer",
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
                           get_color_value = NULL,
                           lower_percentile = 0,
                           upper_percentile = 100,
                           color_scale_type = "quantize",
                           get_elevation_value = NULL,
                           elevation_lower_percentile = 0,
                           elevation_upper_percentile = 100,
                           elevation_scale_type = "linear",
                           grid_aggregator = NULL,
                           gpu_aggregation = FALSE,
                           ...) {
  parameters <- get_arguments()[-1]
  layer <- do.call(grid_layer, parameters)

  add_layer(rdeck, layer)
}

# generated code: this code was generated from deck.gl v8.1.1

#' @rdname grid_layer
#' @template grid_layer
#' @family layers
#' @export
add_grid_layer <- function(rdeck,
                           ...,
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
                           tooltip = FALSE) {
  arg_names <- rlang::call_args_names(sys.call())[-1]
  # auto-resolve geometry
  if (inherits(data, "sf")) {
    get_position <- as.name(attr(data, "sf_column"))
    arg_names <- c(arg_names, "get_position") %>% unique()
  }
  props <- c(
    list(
      type = "GridLayer",
      id = id,
      data = data,
      visible = visible,
      pickable = pickable,
      opacity = opacity,
      position_format = position_format,
      color_format = color_format,
      auto_highlight = auto_highlight,
      highlight_color = highlight_color,
      color_domain = color_domain,
      color_range = color_range,
      get_color_weight = make_scalable_accessor(rlang::enquo(get_color_weight), data, TRUE),
      color_aggregation = color_aggregation,
      elevation_domain = elevation_domain,
      elevation_range = elevation_range,
      get_elevation_weight = make_scalable_accessor(rlang::enquo(get_elevation_weight), data, TRUE),
      elevation_aggregation = elevation_aggregation,
      elevation_scale = elevation_scale,
      cell_size = cell_size,
      coverage = coverage,
      get_position = make_accessor(rlang::enquo(get_position), data, TRUE),
      extruded = extruded,
      material = material,
      get_color_value = make_accessor(rlang::enquo(get_color_value), data, TRUE),
      lower_percentile = lower_percentile,
      upper_percentile = upper_percentile,
      color_scale_type = color_scale_type,
      get_elevation_value = make_accessor(rlang::enquo(get_elevation_value), data, TRUE),
      elevation_lower_percentile = elevation_lower_percentile,
      elevation_upper_percentile = elevation_upper_percentile,
      elevation_scale_type = elevation_scale_type,
      grid_aggregator = grid_aggregator,
      gpu_aggregation = gpu_aggregation,
      tooltip = make_tooltip(rlang::enquo(tooltip), data)
    ),
    list(...)
  )[c("type", arg_names)]
  grid_layer <- do.call(layer, props)
  add_layer(rdeck, grid_layer)
}

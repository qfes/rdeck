#' Add GridLayer to an rdeck map.
#'
#' @name add_grid_layer
#' @param rdeck \`{rdeck}\` an rdeck widget instance
#' @param data `{data.frame | sf}`
#' @param visible `{logical}`
#' @param pickable `{logical}`
#' @param opacity `{numeric}`
#' @param position_format `{"XY" | "XYZ"}`
#' @param color_format `{"RGB" | "RGBA"}`
#' @param auto_highlight `{logical}`
#' @param highlight_color `{integer}`
#' @param color_domain `{numeric}`
#' @param color_range `{list}`
#' @param get_color_weight `{accessor | JS}`
#' @param color_aggregation `{"SUM" | "MEAN" | "MIN" | "MAX"}`
#' @param elevation_domain `{numeric}`
#' @param elevation_range `{numeric}`
#' @param get_elevation_weight `{accessor | JS}`
#' @param elevation_aggregation `{"SUM" | "MEAN" | "MIN" | "MAX"}`
#' @param elevation_scale `{numeric}`
#' @param cell_size `{numeric}`
#' @param coverage `{numeric}`
#' @param get_position `{accessor | JS}`
#' @param extruded `{logical}`
#' @param material `{logical}`
#' @param get_color_value `{accessor}`
#' @param lower_percentile `{numeric}`
#' @param upper_percentile `{numeric}`
#' @param color_scale_type `{"quantize" | "linear" | "quantile" | "ordinal"}`
#' @param get_elevation_value `{accessor}`
#' @param elevation_lower_percentile `{numeric}`
#' @param elevation_upper_percentile `{numeric}`
#' @param elevation_scale_type `{"quantize" | "linear" | "quantile" | "ordinal"}`
#' @param grid_aggregator `{JS}`
#' @param gpu_aggregation `{logical}`
#' @param ... additional layer parameters to pass to deck.gl
#' @returns \`{rdeck}\`
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/grid-layer.md}
#'
#' @export
add_grid_layer <- function(rdeck,
                           data = NULL,
                           visible = TRUE,
                           pickable = FALSE,
                           opacity = 1,
                           position_format = "XYZ",
                           color_format = "RGBA",
                           auto_highlight = FALSE,
                           highlight_color = c(0, 0, 128, 128),
                           color_domain = NULL,
                           color_range = list(
                             c(255, 255, 178),
                             c(254, 217, 118),
                             c(254, 178, 76),
                             c(253, 141, 60),
                             c(240, 59, 32),
                             c(189, 0, 38)
                           ),
                           get_color_weight = NULL,
                           color_aggregation = "SUM",
                           elevation_domain = NULL,
                           elevation_range = c(0, 1000),
                           get_elevation_weight = NULL,
                           elevation_aggregation = "SUM",
                           elevation_scale = 1,
                           cell_size = 1000,
                           coverage = 1,
                           get_position = NULL,
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
  stopifnot(inherits(rdeck, "rdeck"))

  get_color_weight <- accessor(data, substitute(get_color_weight))
  get_elevation_weight <- accessor(data, substitute(get_elevation_weight))
  if (inherits(data, "sf")) {
    get_position <- accessor(data, as.name(attr(data, "sf_column")))
  }
  get_color_value <- accessor(data, substitute(get_color_value))
  get_elevation_value <- accessor(data, substitute(get_elevation_value))

  params <- c(
    list(
      type = "GridLayer",
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
      get_color_weight = get_color_weight,
      color_aggregation = color_aggregation,
      elevation_domain = elevation_domain,
      elevation_range = elevation_range,
      get_elevation_weight = get_elevation_weight,
      elevation_aggregation = elevation_aggregation,
      elevation_scale = elevation_scale,
      cell_size = cell_size,
      coverage = coverage,
      get_position = get_position,
      extruded = extruded,
      material = material,
      get_color_value = get_color_value,
      lower_percentile = lower_percentile,
      upper_percentile = upper_percentile,
      color_scale_type = color_scale_type,
      get_elevation_value = get_elevation_value,
      elevation_lower_percentile = elevation_lower_percentile,
      elevation_upper_percentile = elevation_upper_percentile,
      elevation_scale_type = elevation_scale_type,
      grid_aggregator = grid_aggregator,
      gpu_aggregation = gpu_aggregation
    ),
    list(...)
  )

  do.call(layer, params) %>%
    add_layer(rdeck, .)
}

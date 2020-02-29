#' Add HexagonLayer to an rdeck map.
#'
#' @name add_hexagon_layer
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
#' @param get_color_value `{accessor}`
#' @param get_color_weight `{accessor | JS}`
#' @param color_aggregation `{"SUM" | "MEAN" | "MIN" | "MAX"}`
#' @param lower_percentile `{numeric}`
#' @param upper_percentile `{numeric}`
#' @param color_scale_type `{"quantize" | "linear" | "quantile" | "ordinal"}`
#' @param elevation_domain `{numeric}`
#' @param elevation_range `{numeric}`
#' @param get_elevation_value `{accessor}`
#' @param get_elevation_weight `{accessor | JS}`
#' @param elevation_aggregation `{"SUM" | "MEAN" | "MIN" | "MAX"}`
#' @param elevation_lower_percentile `{numeric}`
#' @param elevation_upper_percentile `{numeric}`
#' @param elevation_scale `{numeric}`
#' @param elevation_scale_type `{"quantize" | "linear" | "quantile" | "ordinal"}`
#' @param radius `{numeric}`
#' @param coverage `{numeric}`
#' @param extruded `{logical}`
#' @param hexagon_aggregator `{JS}`
#' @param get_position `{accessor | JS}`
#' @param material `{logical}`
#' @param ... additional layer parameters to pass to deck.gl
#' @returns \`{rdeck}\`
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/hexagon-layer.md}
#'
#' @export
add_hexagon_layer <- function(rdeck,
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
                              get_color_value = NULL,
                              get_color_weight = NULL,
                              color_aggregation = "SUM",
                              lower_percentile = 0,
                              upper_percentile = 100,
                              color_scale_type = "quantize",
                              elevation_domain = NULL,
                              elevation_range = c(0, 1000),
                              get_elevation_value = NULL,
                              get_elevation_weight = NULL,
                              elevation_aggregation = "SUM",
                              elevation_lower_percentile = 0,
                              elevation_upper_percentile = 100,
                              elevation_scale = 1,
                              elevation_scale_type = "linear",
                              radius = 1000,
                              coverage = 1,
                              extruded = FALSE,
                              hexagon_aggregator = NULL,
                              get_position = NULL,
                              material = TRUE,
                              ...) {
  stopifnot(inherits(rdeck, "rdeck"))

  get_color_value <- accessor(data, substitute(get_color_value))
  get_color_weight <- accessor(data, substitute(get_color_weight))
  get_elevation_value <- accessor(data, substitute(get_elevation_value))
  get_elevation_weight <- accessor(data, substitute(get_elevation_weight))
  if (inherits(data, "sf")) {
    get_position <- accessor(data, as.name(attr(data, "sf_column")))
  }

  params <- c(
    list(
      type = "HexagonLayer",
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
      get_color_value = get_color_value,
      get_color_weight = get_color_weight,
      color_aggregation = color_aggregation,
      lower_percentile = lower_percentile,
      upper_percentile = upper_percentile,
      color_scale_type = color_scale_type,
      elevation_domain = elevation_domain,
      elevation_range = elevation_range,
      get_elevation_value = get_elevation_value,
      get_elevation_weight = get_elevation_weight,
      elevation_aggregation = elevation_aggregation,
      elevation_lower_percentile = elevation_lower_percentile,
      elevation_upper_percentile = elevation_upper_percentile,
      elevation_scale = elevation_scale,
      elevation_scale_type = elevation_scale_type,
      radius = radius,
      coverage = coverage,
      extruded = extruded,
      hexagon_aggregator = hexagon_aggregator,
      get_position = get_position,
      material = material
    ),
    list(...)
  )

  do.call(layer, params) %>%
    add_layer(rdeck, .)
}

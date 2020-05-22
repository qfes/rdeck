# generated code: this code was generated from deck.gl v8.1.1

#' @rdname hexagon_layer
#' @template hexagon_layer
#' @family layers
#' @export
add_hexagon_layer <- function(rdeck,
                              ...,
                              id = "HexagonLayer",
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
                              radius = 1000,
                              coverage = 1,
                              extruded = FALSE,
                              hexagon_aggregator = NULL,
                              get_position = position,
                              material = TRUE,
                              tooltip = FALSE) {
  arg_names <- rlang::call_args_names(sys.call())[-1]
  # auto-resolve geometry
  if (inherits(data, "sf")) {
    get_position <- as.name(attr(data, "sf_column"))
    arg_names <- c(arg_names, "get_position") %>% unique()
  }
  props <- c(
    list(
      type = "HexagonLayer",
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
      get_color_value = make_accessor(rlang::enquo(get_color_value), data, TRUE),
      get_color_weight = make_scalable_accessor(rlang::enquo(get_color_weight), data, TRUE),
      color_aggregation = color_aggregation,
      lower_percentile = lower_percentile,
      upper_percentile = upper_percentile,
      color_scale_type = color_scale_type,
      elevation_domain = elevation_domain,
      elevation_range = elevation_range,
      get_elevation_value = make_accessor(rlang::enquo(get_elevation_value), data, TRUE),
      get_elevation_weight = make_scalable_accessor(rlang::enquo(get_elevation_weight), data, TRUE),
      elevation_aggregation = elevation_aggregation,
      elevation_lower_percentile = elevation_lower_percentile,
      elevation_upper_percentile = elevation_upper_percentile,
      elevation_scale = elevation_scale,
      elevation_scale_type = elevation_scale_type,
      radius = radius,
      coverage = coverage,
      extruded = extruded,
      hexagon_aggregator = hexagon_aggregator,
      get_position = make_accessor(rlang::enquo(get_position), data, TRUE),
      material = material,
      tooltip = make_tooltip(rlang::enquo(tooltip), data)
    ),
    list(...)
  )[c("type", arg_names)]
  hexagon_layer <- do.call(layer, props)
  add_layer(rdeck, hexagon_layer)
}

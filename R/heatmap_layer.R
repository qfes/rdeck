# generated code: this code was generated from deck.gl v8.1.1

#' @rdname heatmap_layer
#' @template heatmap_layer
#' @family layers
#' @export
add_heatmap_layer <- function(rdeck,
                              ...,
                              id = "HeatmapLayer",
                              data = data.frame(),
                              visible = TRUE,
                              pickable = FALSE,
                              opacity = 1,
                              position_format = "XYZ",
                              color_format = "RGBA",
                              auto_highlight = FALSE,
                              highlight_color = "#00008080",
                              get_position = position,
                              get_weight = 1,
                              intensity = 1,
                              radius_pixels = 50,
                              color_range = c(
                                "#ffffb2",
                                "#fed976",
                                "#feb24c",
                                "#fd8d3c",
                                "#f03b20",
                                "#bd0026"
                              ),
                              threshold = 0.05,
                              color_domain = NULL,
                              tooltip = FALSE) {
  arg_names <- rlang::call_args_names(sys.call())[-1]
  # auto-resolve geometry
  if (inherits(data, "sf")) {
    get_position <- as.name(attr(data, "sf_column"))
    arg_names <- c(arg_names, "get_position") %>% unique()
  }
  props <- c(
    list(
      type = "HeatmapLayer",
      id = id,
      data = data,
      visible = visible,
      pickable = pickable,
      opacity = opacity,
      position_format = position_format,
      color_format = color_format,
      auto_highlight = auto_highlight,
      highlight_color = highlight_color,
      get_position = make_accessor(rlang::enquo(get_position), data, TRUE),
      get_weight = make_scalable_accessor(rlang::enquo(get_weight), data, TRUE),
      intensity = intensity,
      radius_pixels = radius_pixels,
      color_range = color_range,
      threshold = threshold,
      color_domain = color_domain,
      tooltip = make_tooltip(rlang::enquo(tooltip), data)
    ),
    list(...)
  )[c("type", arg_names)]
  heatmap_layer <- do.call(layer, props)
  add_layer(rdeck, heatmap_layer)
}

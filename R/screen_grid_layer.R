# generated code: this code was generated from deck.gl v8.1.1

#' @rdname screen_grid_layer
#' @template screen_grid_layer
#' @family layers
#' @export
add_screen_grid_layer <- function(rdeck,
                                  ...,
                                  id = "ScreenGridLayer",
                                  data = data.frame(),
                                  visible = TRUE,
                                  pickable = FALSE,
                                  opacity = 1,
                                  position_format = "XYZ",
                                  color_format = "RGBA",
                                  auto_highlight = FALSE,
                                  highlight_color = "#00008080",
                                  cell_size_pixels = 100,
                                  cell_margin_pixels = 2,
                                  color_domain = NULL,
                                  color_range = c(
                                    "#ffffb2",
                                    "#fed976",
                                    "#feb24c",
                                    "#fd8d3c",
                                    "#f03b20",
                                    "#bd0026"
                                  ),
                                  get_position = position,
                                  get_weight = 1,
                                  gpu_aggregation = TRUE,
                                  aggregation = "SUM",
                                  tooltip = FALSE) {
  arg_names <- rlang::call_args_names(sys.call())[-1]
  # auto-resolve geometry
  if (inherits(data, "sf")) {
    get_position <- as.name(attr(data, "sf_column"))
    arg_names <- c(arg_names, "get_position") %>% unique()
  }
  props <- c(
    list(
      type = "ScreenGridLayer",
      id = id,
      data = data,
      visible = visible,
      pickable = pickable,
      opacity = opacity,
      position_format = position_format,
      color_format = color_format,
      auto_highlight = auto_highlight,
      highlight_color = highlight_color,
      cell_size_pixels = cell_size_pixels,
      cell_margin_pixels = cell_margin_pixels,
      color_domain = color_domain,
      color_range = color_range,
      get_position = make_accessor(rlang::enquo(get_position), data, TRUE),
      get_weight = make_scalable_accessor(rlang::enquo(get_weight), data, TRUE),
      gpu_aggregation = gpu_aggregation,
      aggregation = aggregation,
      tooltip = make_tooltip(rlang::enquo(tooltip), data)
    ),
    list(...)
  )[c("type", arg_names)]
  screen_grid_layer <- do.call(layer, props)
  add_layer(rdeck, screen_grid_layer)
}

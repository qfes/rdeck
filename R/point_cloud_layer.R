# generated code: this code was generated from deck.gl v8.1.1

#' @rdname point_cloud_layer
#' @template point_cloud_layer
#' @family layers
#' @export
add_point_cloud_layer <- function(rdeck,
                                  ...,
                                  id = "PointCloudLayer",
                                  data = data.frame(),
                                  visible = TRUE,
                                  pickable = FALSE,
                                  opacity = 1,
                                  position_format = "XYZ",
                                  color_format = "RGBA",
                                  auto_highlight = FALSE,
                                  highlight_color = "#00008080",
                                  size_units = "pixels",
                                  point_size = 10,
                                  get_position = position,
                                  get_normal = c(0, 0, 1),
                                  get_color = "#000000ff",
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
      type = "PointCloudLayer",
      id = id,
      data = data,
      visible = visible,
      pickable = pickable,
      opacity = opacity,
      position_format = position_format,
      color_format = color_format,
      auto_highlight = auto_highlight,
      highlight_color = highlight_color,
      size_units = size_units,
      point_size = point_size,
      get_position = make_accessor(rlang::enquo(get_position), data, TRUE),
      get_normal = make_accessor(rlang::enquo(get_normal), data, TRUE),
      get_color = make_scalable_accessor(rlang::enquo(get_color), data, TRUE),
      material = material,
      tooltip = make_tooltip(rlang::enquo(tooltip), data)
    ),
    list(...)
  )[c("type", arg_names)]
  point_cloud_layer <- do.call(layer, props)
  add_layer(rdeck, point_cloud_layer)
}

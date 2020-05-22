# generated code: this code was generated from deck.gl v8.1.1

#' @rdname contour_layer
#' @template contour_layer
#' @family layers
#' @export
add_contour_layer <- function(rdeck,
                              ...,
                              id = "ContourLayer",
                              data = data.frame(),
                              visible = TRUE,
                              pickable = FALSE,
                              opacity = 1,
                              position_format = "XYZ",
                              color_format = "RGBA",
                              auto_highlight = FALSE,
                              highlight_color = "#00008080",
                              cell_size = 1000,
                              get_position = position,
                              get_weight = 1,
                              gpu_aggregation = TRUE,
                              aggregation = "SUM",
                              contours = c(NULL),
                              z_offset = 0.005,
                              tooltip = FALSE) {
  arg_names <- rlang::call_args_names(sys.call())[-1]
  # auto-resolve geometry
  if (inherits(data, "sf")) {
    get_position <- as.name(attr(data, "sf_column"))
    arg_names <- c(arg_names, "get_position") %>% unique()
  }
  props <- c(
    list(
      type = "ContourLayer",
      id = id,
      data = data,
      visible = visible,
      pickable = pickable,
      opacity = opacity,
      position_format = position_format,
      color_format = color_format,
      auto_highlight = auto_highlight,
      highlight_color = highlight_color,
      cell_size = cell_size,
      get_position = make_accessor(rlang::enquo(get_position), data, TRUE),
      get_weight = make_scalable_accessor(rlang::enquo(get_weight), data, TRUE),
      gpu_aggregation = gpu_aggregation,
      aggregation = aggregation,
      contours = contours,
      z_offset = z_offset,
      tooltip = make_tooltip(rlang::enquo(tooltip), data)
    ),
    list(...)
  )[c("type", arg_names)]
  contour_layer <- do.call(layer, props)
  add_layer(rdeck, contour_layer)
}

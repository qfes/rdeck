# generated code: this code was generated from deck.gl v8.1.1

#' @rdname tile3d_layer
#' @template tile3d_layer
#' @family layers
#' @export
add_tile3d_layer <- function(rdeck,
                             ...,
                             id = "Tile3DLayer",
                             data = data.frame(),
                             visible = TRUE,
                             pickable = FALSE,
                             opacity = 1,
                             position_format = "XYZ",
                             color_format = "RGBA",
                             auto_highlight = FALSE,
                             highlight_color = "#00008080",
                             get_point_color = "#000000",
                             point_size = 1,
                             load_options = NULL,
                             loader = NULL,
                             tooltip = FALSE) {
  arg_names <- rlang::call_args_names(sys.call())[-1]

  props <- c(
    list(
      type = "Tile3DLayer",
      id = id,
      data = data,
      visible = visible,
      pickable = pickable,
      opacity = opacity,
      position_format = position_format,
      color_format = color_format,
      auto_highlight = auto_highlight,
      highlight_color = highlight_color,
      get_point_color = get_point_color,
      point_size = point_size,
      load_options = load_options,
      loader = loader,
      tooltip = make_tooltip(rlang::enquo(tooltip), data)
    ),
    list(...)
  )[c("type", arg_names)]
  tile3d_layer <- do.call(layer, props)
  add_layer(rdeck, tile3d_layer)
}

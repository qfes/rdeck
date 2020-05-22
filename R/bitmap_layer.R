# generated code: this code was generated from deck.gl v8.1.1

#' @rdname bitmap_layer
#' @template bitmap_layer
#' @family layers
#' @export
add_bitmap_layer <- function(rdeck,
                             ...,
                             id = "BitmapLayer",
                             data = data.frame(),
                             visible = TRUE,
                             pickable = FALSE,
                             opacity = 1,
                             position_format = "XYZ",
                             color_format = "RGBA",
                             auto_highlight = FALSE,
                             highlight_color = "#00008080",
                             image = NULL,
                             bounds = c(1, 0, 0, 1),
                             desaturate = 0,
                             transparent_color = "#00000000",
                             tint_color = "#ffffff",
                             tooltip = FALSE) {
  arg_names <- rlang::call_args_names(sys.call())[-1]

  props <- c(
    list(
      type = "BitmapLayer",
      id = id,
      data = data,
      visible = visible,
      pickable = pickable,
      opacity = opacity,
      position_format = position_format,
      color_format = color_format,
      auto_highlight = auto_highlight,
      highlight_color = highlight_color,
      image = image,
      bounds = bounds,
      desaturate = desaturate,
      transparent_color = transparent_color,
      tint_color = tint_color,
      tooltip = make_tooltip(rlang::enquo(tooltip), data)
    ),
    list(...)
  )[c("type", arg_names)]
  bitmap_layer <- do.call(layer, props)
  add_layer(rdeck, bitmap_layer)
}

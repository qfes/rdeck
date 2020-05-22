# generated code: this code was generated from deck.gl v8.1.1

#' @rdname tile_layer
#' @template tile_layer
#' @family layers
#' @export
add_tile_layer <- function(rdeck,
                           ...,
                           id = "TileLayer",
                           data = data.frame(),
                           visible = TRUE,
                           pickable = FALSE,
                           opacity = 1,
                           position_format = "XYZ",
                           color_format = "RGBA",
                           auto_highlight = FALSE,
                           highlight_color = "#00008080",
                           get_tile_data = NULL,
                           tile_size = 512,
                           max_zoom = NULL,
                           min_zoom = 0,
                           max_cache_size = NULL,
                           max_cache_byte_size = NULL,
                           refinement_strategy = "best-available",
                           tooltip = FALSE) {
  arg_names <- rlang::call_args_names(sys.call())[-1]

  props <- c(
    list(
      type = "TileLayer",
      id = id,
      data = data,
      visible = visible,
      pickable = pickable,
      opacity = opacity,
      position_format = position_format,
      color_format = color_format,
      auto_highlight = auto_highlight,
      highlight_color = highlight_color,
      get_tile_data = get_tile_data,
      tile_size = tile_size,
      max_zoom = max_zoom,
      min_zoom = min_zoom,
      max_cache_size = max_cache_size,
      max_cache_byte_size = max_cache_byte_size,
      refinement_strategy = refinement_strategy,
      tooltip = make_tooltip(rlang::enquo(tooltip), data)
    ),
    list(...)
  )[c("type", arg_names)]
  tile_layer <- do.call(layer, props)
  add_layer(rdeck, tile_layer)
}

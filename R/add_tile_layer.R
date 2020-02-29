#' Add TileLayer to an rdeck map.
#'
#' @name add_tile_layer
#' @param rdeck \`{rdeck}\` an rdeck widget instance
#' @param data `{data.frame | sf}`
#' @param visible `{logical}`
#' @param pickable `{logical}`
#' @param opacity `{numeric}`
#' @param position_format `{"XY" | "XYZ"}`
#' @param color_format `{"RGB" | "RGBA"}`
#' @param auto_highlight `{logical}`
#' @param highlight_color `{integer}`
#' @param get_tile_data `{JS}`
#' @param max_zoom `{numeric}`
#' @param min_zoom `{numeric}`
#' @param max_cache_size `{numeric}`
#' @param ... additional layer parameters to pass to deck.gl
#' @returns \`{rdeck}\`
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/tile-layer.md}
#'
#' @export
add_tile_layer <- function(rdeck,
                           data = NULL,
                           visible = TRUE,
                           pickable = FALSE,
                           opacity = 1,
                           position_format = "XYZ",
                           color_format = "RGBA",
                           auto_highlight = FALSE,
                           highlight_color = c(0, 0, 128, 128),
                           get_tile_data = NULL,
                           max_zoom = NULL,
                           min_zoom = 0,
                           max_cache_size = NULL,
                           ...) {
  stopifnot(inherits(rdeck, "rdeck"))



  params <- c(
    list(
      type = "TileLayer",
      data = data,
      visible = visible,
      pickable = pickable,
      opacity = opacity,
      position_format = position_format,
      color_format = color_format,
      auto_highlight = auto_highlight,
      highlight_color = highlight_color,
      get_tile_data = get_tile_data,
      max_zoom = max_zoom,
      min_zoom = min_zoom,
      max_cache_size = max_cache_size
    ),
    list(...)
  )

  do.call(layer, params) %>%
    add_layer(rdeck, .)
}

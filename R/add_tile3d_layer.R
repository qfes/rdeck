#' Add Tile3DLayer to an rdeck map.
#'
#' @name add_tile3d_layer
#' @param rdeck \`{rdeck}\` an rdeck widget instance
#' @param data `{data.frame | sf}`
#' @param visible `{logical}`
#' @param pickable `{logical}`
#' @param opacity `{numeric}`
#' @param position_format `{"XY" | "XYZ"}`
#' @param color_format `{"RGB" | "RGBA"}`
#' @param auto_highlight `{logical}`
#' @param highlight_color `{integer}`
#' @param get_point_color `{numeric}`
#' @param point_size `{numeric}`
#' @param load_options `{list}`
#' @param ... additional layer parameters to pass to deck.gl
#' @returns \`{rdeck}\`
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/tile-3d-layer.md}
#'
#' @export
add_tile3d_layer <- function(rdeck,
                             data = NULL,
                             visible = TRUE,
                             pickable = FALSE,
                             opacity = 1,
                             position_format = "XYZ",
                             color_format = "RGBA",
                             auto_highlight = FALSE,
                             highlight_color = c(0, 0, 128, 128),
                             get_point_color = c(0, 0, 0),
                             point_size = 1,
                             load_options = NULL,
                             ...) {
  stopifnot(inherits(rdeck, "rdeck"))



  params <- c(
    list(
      type = "Tile3DLayer",
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
      load_options = load_options
    ),
    list(...)
  )

  do.call(layer, params) %>%
    add_layer(rdeck, .)
}

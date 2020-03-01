#' [BitmapLayer](https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/bitmap-layer.md) deck.gl layer.
#'
#' @name bitmap_layer
#'
#' @param id [`character`]
#'  The id of the layer. Layer ids must be unique per layer `type` for deck.gl
#'  to properly distinguish between them.
#'
#' @param data [`data.frame`] | [`sf::sf`]
#'
#' @param visible [`logical`]
#'
#' @param pickable [`logical`]
#'
#' @param opacity [`numeric`]
#'
#' @param position_format `XY` | `XYZ`
#'
#' @param color_format `RGB` | `RGBA`
#'
#' @param auto_highlight [`logical`]
#'
#' @param highlight_color [`integer`]
#'
#' @param image [`image`] | [`character`]
#'
#' @param bounds [`numeric`]
#'
#' @param desaturate [`numeric`]
#'
#' @param transparent_color [`integer`]
#'
#' @param tint_color [`integer`]
#'
#' @param ... additional layer parameters to pass to deck.gl.
#'  `snake_case` parameters will be converted to `snakeCase`.
#'
#' @returns `BitmapLayer` & [`layer`]
#'  A [BitmapLayer](https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/bitmap-layer.md) layer.
#'  Add to an [rdeck] map via [`add_layer`] or [`rdeck`].
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/bitmap-layer.md}
#'
#' @export
bitmap_layer <- function(id = NULL,
                         data = NULL,
                         visible = TRUE,
                         pickable = FALSE,
                         opacity = 1,
                         position_format = "XYZ",
                         color_format = "RGBA",
                         auto_highlight = FALSE,
                         highlight_color = c(0, 0, 128, 128),
                         image = NULL,
                         bounds = c(1, 0, 0, 1),
                         desaturate = 0,
                         transparent_color = c(0, 0, 0, 0),
                         tint_color = c(255, 255, 255),
                         ...) {
  params <- c(
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
      tint_color = tint_color
    ),
    list(...)
  )

  do.call(layer, params)
}

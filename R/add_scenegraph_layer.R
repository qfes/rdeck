#' Add a [ScenegraphLayer](https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/scenegraph-layer.md) deck.gl layer to an [rdeck] map.
#'
#' @name add_scenegraph_layer
#'
#' @param rdeck [`rdeck`]
#'  An [rdeck] map.
#'
#' @inheritParams scenegraph_layer
#' @inheritDotParams scenegraph_layer
#'
#' @returns [`rdeck`]
#'  The [rdeck] map.
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/scenegraph-layer.md}
#'
#' @export
add_scenegraph_layer <- function(rdeck,
                                 id = NULL,
                                 data = NULL,
                                 visible = TRUE,
                                 pickable = FALSE,
                                 opacity = 1,
                                 position_format = "XYZ",
                                 color_format = "RGBA",
                                 auto_highlight = FALSE,
                                 highlight_color = c(0, 0, 128, 128),
                                 scenegraph = NULL,
                                 get_scene = NULL,
                                 get_animator = NULL,
                                 size_scale = 1,
                                 size_min_pixels = 0,
                                 size_max_pixels = 9007199254740991,
                                 get_position = NULL,
                                 get_color = NULL,
                                 get_orientation = NULL,
                                 get_scale = NULL,
                                 get_translation = NULL,
                                 get_transform_matrix = NULL,
                                 ...) {
  params <- as.list(match.call())[-(1:2)]
  layer <- do.call(scenegraph_layer, params)

  add_layer(rdeck, layer)
}

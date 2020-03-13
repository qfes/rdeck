#' @name tile_layer
#' @template tile_layer
#' @family layers
#' @export
tile_layer <- function(id = "TileLayer",
                       data = data.frame(),
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
  arguments <- get_arguments()
  parameters <- c(
    list(type = "TileLayer"),
    get_arguments()
  )

  do.call(layer, parameters)
}

#' @name add_tile_layer
#' @template tile_layer
#' @param rdeck `rdeck`
#' @family add_layers
#' @export
add_tile_layer <- function(rdeck,
                           id = "TileLayer",
                           data = data.frame(),
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
  parameters <- get_arguments()[-1]
  layer <- do.call(tile_layer, parameters)

  add_layer(rdeck, layer)
}

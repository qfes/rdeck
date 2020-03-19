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
                       highlight_color = "#00008080",
                       get_tile_data = NULL,
                       tile_size = 512,
                       max_zoom = NULL,
                       min_zoom = 0,
                       max_cache_size = NULL,
                       max_cache_byte_size = NULL,
                       refinement_strategy = "best-available",
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
                           highlight_color = "#00008080",
                           get_tile_data = NULL,
                           tile_size = 512,
                           max_zoom = NULL,
                           min_zoom = 0,
                           max_cache_size = NULL,
                           max_cache_byte_size = NULL,
                           refinement_strategy = "best-available",
                           ...) {
  parameters <- get_arguments()[-1]
  layer <- do.call(tile_layer, parameters)

  add_layer(rdeck, layer)
}

# generated code: this code was generated from deck.gl v8.1.0


#' @rdname terrain_layer
#' @template terrain_layer
#' @family layers
#' @export
terrain_layer <- function(id = "TerrainLayer",
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
                          elevation_data = "",
                          texture = "",
                          mesh_max_error = 4,
                          bounds = NULL,
                          color = c(255, 255, 255),
                          elevation_decoder = NULL,
                          worker_url = NULL,
                          wireframe = FALSE,
                          material = TRUE,
                          ...) {
  arguments <- get_arguments()
  parameters <- c(
    list(type = "TerrainLayer"),
    get_arguments()
  )

  do.call(layer, parameters)
}

#' @describeIn terrain_layer
#' Add TerrainLayer to an rdeck map
#' @inheritParams add_layer
#' @export
add_terrain_layer <- function(rdeck,
                              id = "TerrainLayer",
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
                              elevation_data = "",
                              texture = "",
                              mesh_max_error = 4,
                              bounds = NULL,
                              color = c(255, 255, 255),
                              elevation_decoder = NULL,
                              worker_url = NULL,
                              wireframe = FALSE,
                              material = TRUE,
                              ...) {
  parameters <- get_arguments()[-1]
  layer <- do.call(terrain_layer, parameters)

  add_layer(rdeck, layer)
}

# generated code: this code was generated from deck.gl v8.1.1

#' @rdname terrain_layer
#' @template terrain_layer
#' @family layers
#' @export
add_terrain_layer <- function(rdeck,
                              ...,
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
                              tooltip = FALSE) {
  arg_names <- rlang::call_args_names(sys.call())[-1]

  props <- c(
    list(
      type = "TerrainLayer",
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
      elevation_data = elevation_data,
      texture = texture,
      mesh_max_error = mesh_max_error,
      bounds = bounds,
      color = color,
      elevation_decoder = elevation_decoder,
      worker_url = worker_url,
      wireframe = wireframe,
      material = material,
      tooltip = make_tooltip(rlang::enquo(tooltip), data)
    ),
    list(...)
  )[c("type", arg_names)]
  terrain_layer <- do.call(layer, props)
  add_layer(rdeck, terrain_layer)
}

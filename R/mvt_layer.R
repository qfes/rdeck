#' @name mvt_layer
#' @template mvt_layer
#' @family layers
#' @export
mvt_layer <- function(id = "MVTLayer",
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
    list(type = "MVTLayer"),
    get_arguments()
  )

  do.call(layer, parameters)
}

#' @describeIn mvt_layer
#'  Add MVTLayer to an rdeck map
#' @inheritParams add_layer
#' @export
add_mvt_layer <- function(rdeck,
                          id = "MVTLayer",
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
  layer <- do.call(mvt_layer, parameters)

  add_layer(rdeck, layer)
}

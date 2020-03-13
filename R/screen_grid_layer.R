#' @name screen_grid_layer
#' @template screen_grid_layer
#' @family layers
#' @export
screen_grid_layer <- function(id = "ScreenGridLayer",
                              data = data.frame(),
                              visible = TRUE,
                              pickable = FALSE,
                              opacity = 1,
                              position_format = "XYZ",
                              color_format = "RGBA",
                              auto_highlight = FALSE,
                              highlight_color = c(0, 0, 128, 128),
                              cell_size_pixels = 100,
                              cell_margin_pixels = 2,
                              color_domain = NULL,
                              color_range = list(
                                c(255, 255, 178),
                                c(254, 217, 118),
                                c(254, 178, 76),
                                c(253, 141, 60),
                                c(240, 59, 32),
                                c(189, 0, 38)
                              ),
                              get_position = position,
                              get_weight = 1,
                              gpu_aggregation = TRUE,
                              aggregation = "SUM",
                              ...) {
  arguments <- get_arguments()
  parameters <- c(
    list(type = "ScreenGridLayer"),
    get_arguments()
  )
  # auto-resolve geometry
  if (inherits(data, "sf")) {
    parameters$get_position <- as.name(attr(data, "sf_column"))
  }

  do.call(layer, parameters)
}

#' @name add_screen_grid_layer
#' @template screen_grid_layer
#' @param rdeck `rdeck`
#' @family add_layers
#' @export
add_screen_grid_layer <- function(rdeck,
                                  id = "ScreenGridLayer",
                                  data = data.frame(),
                                  visible = TRUE,
                                  pickable = FALSE,
                                  opacity = 1,
                                  position_format = "XYZ",
                                  color_format = "RGBA",
                                  auto_highlight = FALSE,
                                  highlight_color = c(0, 0, 128, 128),
                                  cell_size_pixels = 100,
                                  cell_margin_pixels = 2,
                                  color_domain = NULL,
                                  color_range = list(
                                    c(255, 255, 178),
                                    c(254, 217, 118),
                                    c(254, 178, 76),
                                    c(253, 141, 60),
                                    c(240, 59, 32),
                                    c(189, 0, 38)
                                  ),
                                  get_position = position,
                                  get_weight = 1,
                                  gpu_aggregation = TRUE,
                                  aggregation = "SUM",
                                  ...) {
  parameters <- get_arguments()[-1]
  layer <- do.call(screen_grid_layer, parameters)

  add_layer(rdeck, layer)
}

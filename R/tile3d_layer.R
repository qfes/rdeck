#' @name tile3d_layer
#' @template tile3d_layer
#' @family layers
#' @export
tile3d_layer <- function(id = "Tile3DLayer",
                         data = data.frame(),
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
  arguments <- get_arguments()
  parameters <- c(
    list(type = "Tile3DLayer"),
    get_arguments()
  )

  do.call(layer, parameters)
}

#' @name add_tile3d_layer
#' @template tile3d_layer
#' @param rdeck `rdeck`
#' @family add_layers
#' @export
add_tile3d_layer <- function(rdeck,
                             id = "Tile3DLayer",
                             data = data.frame(),
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
  parameters <- get_arguments()[-1]
  layer <- do.call(tile3d_layer, parameters)

  add_layer(rdeck, layer)
}

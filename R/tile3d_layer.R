# generated code: this code was generated from deck.gl v8.1.1


#' @rdname tile3d_layer
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
                         highlight_color = "#00008080",
                         get_point_color = "#000000",
                         point_size = 1,
                         load_options = NULL,
                         loader = NULL,
                         ...) {
  arguments <- get_layer_arguments()
  parameters <- c(
    list(type = "Tile3DLayer"),
    get_layer_arguments()
  )

  do.call(layer, parameters)
}

#' @describeIn tile3d_layer
#' Add Tile3DLayer to an rdeck map
#' @inheritParams add_layer
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
                             highlight_color = "#00008080",
                             get_point_color = "#000000",
                             point_size = 1,
                             load_options = NULL,
                             loader = NULL,
                             ...) {
  parameters <- get_layer_arguments()[-1]
  layer <- do.call(tile3d_layer, parameters)

  add_layer(rdeck, layer)
}

#' @name bitmap_layer
#' @template bitmap_layer
#' @family layers
#' @export
bitmap_layer <- function(id = "BitmapLayer",
                         data = data.frame(),
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
  arguments <- get_arguments()
  parameters <- c(
    list(type = "BitmapLayer"),
    get_arguments()
  )

  do.call(layer, parameters)
}

#' @name add_bitmap_layer
#' @template bitmap_layer
#' @param rdeck `rdeck`
#' @family add_layers
#' @export
add_bitmap_layer <- function(rdeck,
                             id = "BitmapLayer",
                             data = data.frame(),
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
  parameters <- get_arguments()[-1]
  layer <- do.call(bitmap_layer, parameters)

  add_layer(rdeck, layer)
}

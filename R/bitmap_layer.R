# generated code: this code was generated from deck.gl v8.1.0


#' @rdname bitmap_layer
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
                         highlight_color = "#00008080",
                         image = NULL,
                         bounds = c(1, 0, 0, 1),
                         desaturate = 0,
                         transparent_color = "#00000000",
                         tint_color = "#ffffff",
                         ...) {
  arguments <- get_arguments()
  parameters <- c(
    list(type = "BitmapLayer"),
    get_arguments()
  )

  do.call(layer, parameters)
}

#' @describeIn bitmap_layer
#' Add BitmapLayer to an rdeck map
#' @inheritParams add_layer
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
                             highlight_color = "#00008080",
                             image = NULL,
                             bounds = c(1, 0, 0, 1),
                             desaturate = 0,
                             transparent_color = "#00000000",
                             tint_color = "#ffffff",
                             ...) {
  parameters <- get_arguments()[-1]
  layer <- do.call(bitmap_layer, parameters)

  add_layer(rdeck, layer)
}

#' @name contour_layer
#' @template contour_layer
#' @family layers
#' @export
contour_layer <- function(id = "ContourLayer",
                          data = data.frame(),
                          visible = TRUE,
                          pickable = FALSE,
                          opacity = 1,
                          position_format = "XYZ",
                          color_format = "RGBA",
                          auto_highlight = FALSE,
                          highlight_color = "#00008080",
                          cell_size = 1000,
                          get_position = position,
                          get_weight = 1,
                          gpu_aggregation = TRUE,
                          aggregation = "SUM",
                          contours = c(NULL),
                          z_offset = 0.005,
                          ...) {
  arguments <- get_arguments()
  parameters <- c(
    list(type = "ContourLayer"),
    get_arguments()
  )
  # auto-resolve geometry
  if (inherits(data, "sf")) {
    parameters$get_position <- as.name(attr(data, "sf_column"))
  }

  do.call(layer, parameters)
}

#' @name add_contour_layer
#' @template contour_layer
#' @param rdeck `rdeck`
#' @family add_layers
#' @export
add_contour_layer <- function(rdeck,
                              id = "ContourLayer",
                              data = data.frame(),
                              visible = TRUE,
                              pickable = FALSE,
                              opacity = 1,
                              position_format = "XYZ",
                              color_format = "RGBA",
                              auto_highlight = FALSE,
                              highlight_color = "#00008080",
                              cell_size = 1000,
                              get_position = position,
                              get_weight = 1,
                              gpu_aggregation = TRUE,
                              aggregation = "SUM",
                              contours = c(NULL),
                              z_offset = 0.005,
                              ...) {
  parameters <- get_arguments()[-1]
  layer <- do.call(contour_layer, parameters)

  add_layer(rdeck, layer)
}

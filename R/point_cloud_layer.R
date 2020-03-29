#' @name point_cloud_layer
#' @template point_cloud_layer
#' @family layers
#' @export
point_cloud_layer <- function(id = "PointCloudLayer",
                              data = data.frame(),
                              visible = TRUE,
                              pickable = FALSE,
                              opacity = 1,
                              position_format = "XYZ",
                              color_format = "RGBA",
                              auto_highlight = FALSE,
                              highlight_color = "#00008080",
                              size_units = "pixels",
                              point_size = 10,
                              get_position = position,
                              get_normal = c(0, 0, 1),
                              get_color = "#000000ff",
                              material = TRUE,
                              ...) {
  arguments <- get_arguments()
  parameters <- c(
    list(type = "PointCloudLayer"),
    get_arguments()
  )
  # auto-resolve geometry
  if (inherits(data, "sf")) {
    parameters$get_position <- as.name(attr(data, "sf_column"))
  }

  do.call(layer, parameters)
}

#' @describeIn point_cloud_layer
#'  Add PointCloudLayer to an rdeck map
#' @inheritParams add_layer
#' @export
add_point_cloud_layer <- function(rdeck,
                                  id = "PointCloudLayer",
                                  data = data.frame(),
                                  visible = TRUE,
                                  pickable = FALSE,
                                  opacity = 1,
                                  position_format = "XYZ",
                                  color_format = "RGBA",
                                  auto_highlight = FALSE,
                                  highlight_color = "#00008080",
                                  size_units = "pixels",
                                  point_size = 10,
                                  get_position = position,
                                  get_normal = c(0, 0, 1),
                                  get_color = "#000000ff",
                                  material = TRUE,
                                  ...) {
  parameters <- get_arguments()[-1]
  layer <- do.call(point_cloud_layer, parameters)

  add_layer(rdeck, layer)
}

# generated code: this code was generated from deck.gl v8.1.1


#' @rdname heatmap_layer
#' @template heatmap_layer
#' @family layers
#' @export
heatmap_layer <- function(id = "HeatmapLayer",
                          data = data.frame(),
                          visible = TRUE,
                          pickable = FALSE,
                          opacity = 1,
                          position_format = "XYZ",
                          color_format = "RGBA",
                          auto_highlight = FALSE,
                          highlight_color = "#00008080",
                          get_position = position,
                          get_weight = 1,
                          intensity = 1,
                          radius_pixels = 50,
                          color_range = c(
                            "#ffffb2",
                            "#fed976",
                            "#feb24c",
                            "#fd8d3c",
                            "#f03b20",
                            "#bd0026"
                          ),
                          threshold = 0.05,
                          color_domain = NULL,
                          ...) {
  arguments <- get_layer_arguments()
  parameters <- c(
    list(type = "HeatmapLayer"),
    get_layer_arguments()
  )
  # auto-resolve geometry
  if (inherits(data, "sf")) {
    parameters$get_position <- as.name(attr(data, "sf_column"))
  }

  do.call(layer, parameters)
}

#' @describeIn heatmap_layer
#' Add HeatmapLayer to an rdeck map
#' @inheritParams add_layer
#' @export
add_heatmap_layer <- function(rdeck,
                              id = "HeatmapLayer",
                              data = data.frame(),
                              visible = TRUE,
                              pickable = FALSE,
                              opacity = 1,
                              position_format = "XYZ",
                              color_format = "RGBA",
                              auto_highlight = FALSE,
                              highlight_color = "#00008080",
                              get_position = position,
                              get_weight = 1,
                              intensity = 1,
                              radius_pixels = 50,
                              color_range = c(
                                "#ffffb2",
                                "#fed976",
                                "#feb24c",
                                "#fd8d3c",
                                "#f03b20",
                                "#bd0026"
                              ),
                              threshold = 0.05,
                              color_domain = NULL,
                              ...) {
  parameters <- get_layer_arguments()[-1]
  layer <- do.call(heatmap_layer, parameters)

  add_layer(rdeck, layer)
}

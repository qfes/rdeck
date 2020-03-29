# generated code: this code was generated from deck.gl v8.1.0


#' @rdname scatterplot_layer
#' @template scatterplot_layer
#' @family layers
#' @export
scatterplot_layer <- function(id = "ScatterplotLayer",
                              data = data.frame(),
                              visible = TRUE,
                              pickable = FALSE,
                              opacity = 1,
                              position_format = "XYZ",
                              color_format = "RGBA",
                              auto_highlight = FALSE,
                              highlight_color = "#00008080",
                              radius_scale = 1,
                              radius_min_pixels = 0,
                              radius_max_pixels = 9007199254740991,
                              line_width_units = "meters",
                              line_width_scale = 1,
                              line_width_min_pixels = 0,
                              line_width_max_pixels = 9007199254740991,
                              stroked = FALSE,
                              filled = TRUE,
                              get_position = position,
                              get_radius = 1,
                              get_fill_color = "#000000ff",
                              get_line_color = "#000000ff",
                              get_line_width = 1,
                              ...) {
  arguments <- get_arguments()
  parameters <- c(
    list(type = "ScatterplotLayer"),
    get_arguments()
  )
  # auto-resolve geometry
  if (inherits(data, "sf")) {
    parameters$get_position <- as.name(attr(data, "sf_column"))
  }

  do.call(layer, parameters)
}

#' @describeIn scatterplot_layer
#' Add ScatterplotLayer to an rdeck map
#' @inheritParams add_layer
#' @export
add_scatterplot_layer <- function(rdeck,
                                  id = "ScatterplotLayer",
                                  data = data.frame(),
                                  visible = TRUE,
                                  pickable = FALSE,
                                  opacity = 1,
                                  position_format = "XYZ",
                                  color_format = "RGBA",
                                  auto_highlight = FALSE,
                                  highlight_color = "#00008080",
                                  radius_scale = 1,
                                  radius_min_pixels = 0,
                                  radius_max_pixels = 9007199254740991,
                                  line_width_units = "meters",
                                  line_width_scale = 1,
                                  line_width_min_pixels = 0,
                                  line_width_max_pixels = 9007199254740991,
                                  stroked = FALSE,
                                  filled = TRUE,
                                  get_position = position,
                                  get_radius = 1,
                                  get_fill_color = "#000000ff",
                                  get_line_color = "#000000ff",
                                  get_line_width = 1,
                                  ...) {
  parameters <- get_arguments()[-1]
  layer <- do.call(scatterplot_layer, parameters)

  add_layer(rdeck, layer)
}

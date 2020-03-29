#' @name trips_layer
#' @template trips_layer
#' @family layers
#' @export
trips_layer <- function(id = "TripsLayer",
                        data = data.frame(),
                        visible = TRUE,
                        pickable = FALSE,
                        opacity = 1,
                        position_format = "XYZ",
                        color_format = "RGBA",
                        auto_highlight = FALSE,
                        highlight_color = "#00008080",
                        width_units = "meters",
                        width_scale = 1,
                        width_min_pixels = 0,
                        width_max_pixels = 9007199254740991,
                        rounded = FALSE,
                        miter_limit = 4,
                        billboard = FALSE,
                        get_path = path,
                        get_color = "#000000ff",
                        get_width = 1,
                        trail_length = 120,
                        current_time = 0,
                        get_timestamps = NULL,
                        ...) {
  arguments <- get_arguments()
  parameters <- c(
    list(type = "TripsLayer"),
    get_arguments()
  )
  # auto-resolve geometry
  if (inherits(data, "sf")) {
    parameters$get_path <- as.name(attr(data, "sf_column"))
  }

  do.call(layer, parameters)
}

#' @describeIn trips_layer
#'  Add TripsLayer to an rdeck map
#' @inheritParams add_layer
#' @export
add_trips_layer <- function(rdeck,
                            id = "TripsLayer",
                            data = data.frame(),
                            visible = TRUE,
                            pickable = FALSE,
                            opacity = 1,
                            position_format = "XYZ",
                            color_format = "RGBA",
                            auto_highlight = FALSE,
                            highlight_color = "#00008080",
                            width_units = "meters",
                            width_scale = 1,
                            width_min_pixels = 0,
                            width_max_pixels = 9007199254740991,
                            rounded = FALSE,
                            miter_limit = 4,
                            billboard = FALSE,
                            get_path = path,
                            get_color = "#000000ff",
                            get_width = 1,
                            trail_length = 120,
                            current_time = 0,
                            get_timestamps = NULL,
                            ...) {
  parameters <- get_arguments()[-1]
  layer <- do.call(trips_layer, parameters)

  add_layer(rdeck, layer)
}

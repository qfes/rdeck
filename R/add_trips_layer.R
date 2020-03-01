#' Add a [TripsLayer](https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/trips-layer.md) deck.gl layer to an [rdeck] map.
#'
#' @name add_trips_layer
#'
#' @param rdeck [`rdeck`]
#'  An [rdeck] map.
#'
#' @inheritParams trips_layer
#' @inheritDotParams trips_layer
#'
#' @returns [`rdeck`]
#'  The [rdeck] map.
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/trips-layer.md}
#'
#' @export
add_trips_layer <- function(rdeck,
                            id = NULL,
                            data = NULL,
                            visible = TRUE,
                            pickable = FALSE,
                            opacity = 1,
                            position_format = "XYZ",
                            color_format = "RGBA",
                            auto_highlight = FALSE,
                            highlight_color = c(0, 0, 128, 128),
                            width_units = "meters",
                            width_scale = 1,
                            width_min_pixels = 0,
                            width_max_pixels = 9007199254740991,
                            rounded = FALSE,
                            miter_limit = 4,
                            billboard = FALSE,
                            get_path = NULL,
                            get_color = NULL,
                            get_width = NULL,
                            trail_length = 120,
                            current_time = 0,
                            get_timestamps = NULL,
                            ...) {
  params <- as.list(match.call())[-(1:2)]
  layer <- do.call(trips_layer, params)

  add_layer(rdeck, layer)
}

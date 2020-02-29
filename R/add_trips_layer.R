#' Add TripsLayer to an rdeck map.
#'
#' @name add_trips_layer
#' @param rdeck \`{rdeck}\` an rdeck widget instance
#' @param data `{data.frame | sf}`
#' @param visible `{logical}`
#' @param pickable `{logical}`
#' @param opacity `{numeric}`
#' @param position_format `{"XY" | "XYZ"}`
#' @param color_format `{"RGB" | "RGBA"}`
#' @param auto_highlight `{logical}`
#' @param highlight_color `{integer}`
#' @param width_units `{"pixels" | "meters"}`
#' @param width_scale `{numeric}`
#' @param width_min_pixels `{numeric}`
#' @param width_max_pixels `{numeric}`
#' @param rounded `{logical}`
#' @param miter_limit `{numeric}`
#' @param billboard `{logical}`
#' @param get_path `{accessor | JS}`
#' @param get_color `{accessor}`
#' @param get_width `{accessor | numeric}`
#' @param trail_length `{numeric}`
#' @param current_time `{numeric}`
#' @param get_timestamps `{accessor}`
#' @param ... additional layer parameters to pass to deck.gl
#' @returns \`{rdeck}\`
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/trips-layer.md}
#'
#' @export
add_trips_layer <- function(rdeck,
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
  stopifnot(inherits(rdeck, "rdeck"))

  if (inherits(data, "sf")) {
    get_path <- accessor(as.name(attr(data, "sf_column")), data, columnar = TRUE)
  }
  get_color <- accessor(substitute(get_color), data, columnar = TRUE)
  get_width <- accessor(substitute(get_width), data, columnar = TRUE)
  get_timestamps <- accessor(substitute(get_timestamps), data, columnar = TRUE)

  params <- c(
    list(
      type = "TripsLayer",
      data = data,
      visible = visible,
      pickable = pickable,
      opacity = opacity,
      position_format = position_format,
      color_format = color_format,
      auto_highlight = auto_highlight,
      highlight_color = highlight_color,
      width_units = width_units,
      width_scale = width_scale,
      width_min_pixels = width_min_pixels,
      width_max_pixels = width_max_pixels,
      rounded = rounded,
      miter_limit = miter_limit,
      billboard = billboard,
      get_path = get_path,
      get_color = get_color,
      get_width = get_width,
      trail_length = trail_length,
      current_time = current_time,
      get_timestamps = get_timestamps
    ),
    list(...)
  )

  do.call(layer, params) %>%
    add_layer(rdeck, .)
}

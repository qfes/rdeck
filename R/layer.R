#' Create layer
#'
#' @name layer
#' @param type `{character}` deck.gl layer type
#' @param data `{data.frame | sf}`
#' @param visible `{logical}`
#' @param pickable `{logical}`
#' @param opacity `{numeric}`
#' @param position_format `{"XY" | "XYZ"}`
#' @param color_format `{"RGB" | "RGBA"}`
#' @param auto_highlight `{logical}`
#' @param highlight_color `{integer}`
#' @param ... additional layer parameters
#' @returns \`{rdeck}\`
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/master/docs/api-reference/layer.md}
#'
#' @md
layer <- function(type = NULL,
                  data = NULL,
                  visible = TRUE,
                  pickable = FALSE,
                  opacity = 1,
                  position_format = "XYZ",
                  color_format = "RGBA",
                  auto_highlight = FALSE,
                  highlight_color = c(0, 0, 128, 128),
                  ...) {
  if (inherits(data, "sf") && type == "GeoJsonLayer") {
    data <- geojsonsf::sf_geojson(data)
  } else {
    data <- layer_data(data)
  }

  if (inherits(data, "sf")) {
    position_format <- get_position_format(data)
  }

  properties <- c(
    list(
      data = data,
      visible = visible,
      pickable = pickable,
      opacity = opacity,
      position_format = position_format,
      color_format = color_format,
      auto_highlight = auto_highlight,
      highlight_color = highlight_color
    ),
    list(...)
  ) %>%
    Filter(x = ., function(x) !is.null(x))

  names(properties) <- snakecase::to_lower_camel_case(names(properties))

  structure(
    properties,
    class = c(type, "layer")
  )
}

#' Get layer data
#'
#' @name layer_data
#' @param data `{sf | data.frame}`
#' @return `{list | json}`
#'
#' @keywords internal
layer_data <- function(data) {
  if (is.null(data)) {
    return(NULL)
  }

  UseMethod("layer_data")
}

layer_data.sf <- function(data) {
  data <- data %>%
    split_geometry()

  NextMethod()
}

layer_data.data.frame <- function(data) {
  list(
    length = nrow(data),
    frame = lapply(data, function(column) {
      if (!inherits(column, "sfc")) {
        return(column)
      }

      sfc <- column %>%
        sf::st_transform(4326)

      # performance optimisation for points
      if (inherits(sfc, "sfc_POINT")) do.call(rbind, sfc) else sfc
    })
  )
}

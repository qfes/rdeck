#' Create a deck.gl [layer](https://github.com/uber/deck.gl/blob/master/docs/api-reference/layer.md)
#'
#' @name layer
#' @param type [`character`]
#'  deck.gl layer type, one of [layer_types]
#'
#' @param id [`character`]
#'  The id of the layer. Layer ids must be unique per layer `type` for deck.gl
#'  to properly distinguish between them.
#'
#' @param data [`data.frame`] | [`sf::sf`]
#'  Deck.gl layer data, either a [data.frame] or [sf::sf].
#'
#' @param visible [`logical`]
#'  Whether the layer is visible.
#'
#' @param pickable [`logical`]
#'  Whether the layer responds to mouse pointer picking events.
#'
#' @param opacity [`numeric`]
#'  The opacity of the layer.
#'
#' @param position_format `XY` | `XYZ`
#'  Determines whether each coordinate has two (XY) or three (XYZ) numbers.
#'
#' @param color_format `RGB` | `RGBA`
#'  RGB will make the layer ignore the alpha channel of colours returned by
#'  accessors. Opacity controlled by `opacity` is still applied.
#'
#' @param auto_highlight [`logical`]
#'  When `TRUE`, current object pointed by mouse pointer (when hovered over) is
#'  highlighted with highlight_color. Requires `pickable` to be `TRUE`.
#'
#' @param highlight_color `RGB` | `RGBA`
#'  RGBA color to be used to render highlighted object. When 3 component (RGB)
#'  array is specified, a default value of 255 is used for alpha.
#'
#' @param ... additional deck.gl layer parameters
#' @returns [`layer`]
#'  A deck.gl layer of `type`
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/master/docs/api-reference/layer.md}
#'
#' @export
layer <- function(type = NULL,
                  id = NULL,
                  data = NULL,
                  visible = TRUE,
                  pickable = FALSE,
                  opacity = 1,
                  position_format = "XYZ",
                  color_format = "RGBA",
                  auto_highlight = FALSE,
                  highlight_color = c(0, 0, 128, 128),
                  ...) {
  match.arg(type, layer_types)

  if (inherits(data, "sf")) {
    position_format <- get_position_format(data)
  }

  match.arg(position_format, c("XY", "XYZ"))
  match.arg(color_format, c("RGB", "RGBA"))

  properties <- c(
    list(
      data = layer_data(data, type),
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
#' @param data [`data.frame`] | [`sf::sf`]
#' @return [`list`] | `json`
#'
#' @keywords internal
layer_data <- function(data, layer_type) {
  if (is.null(data)) {
    return(NULL)
  }

  if (layer_type == "GeoJsonLayer") {
    return(geojsonsf::sf_geojson(data))
  }

  UseMethod("layer_data")
}

layer_data.sf <- function(data, layer_type) {
  data <- data %>%
    split_geometry()

  NextMethod()
}

layer_data.data.frame <- function(data, layer_type) {
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

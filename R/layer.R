#' Create a deck.gl [layer](https://github.com/uber/deck.gl/blob/master/docs/api-reference/layer.md)
#'
#' @name layer
#' @param type `character`
#'  deck.gl layer type, one of [layer_types]
#'
#' @param id `character`
#'  The id of the layer. Layer ids must be unique per layer `type` for deck.gl
#'  to properly distinguish between them.
#'
#' @param data `data.frame` | `sf::sf`
#'  Deck.gl layer data, either a [data.frame] or [sf::sf].
#'
#' @param visible `logical`
#'  Whether the layer is visible.
#'
#' @param pickable `logical`
#'  Whether the layer responds to mouse pointer picking events.
#'
#' @param opacity `numeric`
#'  The opacity of the layer.
#'
#' @param position_format `"XY"` | `"XYZ"`
#'  Determines whether each coordinate has two (XY) or three (XYZ) numbers.
#'
#' @param color_format `"RGB"` | `"RGBA"`
#'  RGB will make the layer ignore the alpha channel of colours returned by
#'  accessors. Opacity controlled by `opacity` is still applied.
#'
#' @param auto_highlight `logical`
#'  When `TRUE`, current object pointed by mouse pointer (when hovered over) is
#'  highlighted with highlight_color. Requires `pickable` to be `TRUE`.
#'
#' @param highlight_color `integer` vector of (R,G,B) or (R,G,B,A)
#'  RGBA color to be used to render highlighted object. When 3 component (RGB)
#'  array is specified, a default value of 255 is used for alpha.
#'
#' @param ... additional deck.gl layer parameters
#'
#' @returns `layer`
#'  A deck.gl layer of `type`
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/master/docs/api-reference/layer.md}
#' @family layers
#'
#' @export
layer <- function(type,
                  id = type,
                  data = data.frame(),
                  visible = TRUE,
                  pickable = FALSE,
                  opacity = 1,
                  position_format = "XYZ",
                  color_format = "RGBA",
                  auto_highlight = FALSE,
                  highlight_color = c(0, 0, 128, 128),
                  ...) {
  stopifnot(
    type %in% layer_types,
    position_format %in% c("XYZ", "XY"),
    color_format %in% c("RGBA", "RGB")
  )

  properties <- get_arguments()
  properties$data <- layer_data(data, type)
  if (inherits(data, "sf")) {
    properties$position_format <- get_position_format(data)
  }

  # create accessor expressions for each accessor
  is_accessor <- names(properties) %in% accessor_names
  accessors <- lapply(properties[is_accessor], function(arg) {
    accessor(arg, data, type != "GeoJsonLayer")
  })

  # overwrite accessors
  properties <- utils::modifyList(properties, accessors, keep.null = TRUE) %>%
    camel_case_names()

  structure(
    properties %>% lapply(eval),
    class = "layer"
  )
}

#' Add a deck.gl layer to an rdeck map.
#'
#' @name add_layer
#'
#' @param rdeck [`rdeck`]
#'  An `rdeck` map.
#'
#' @param layer [`layer`]
#'
#' @returns [`rdeck`]
#'  The `rdeck` map.
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/master/docs/api-reference/layer.md}
#'
#' @export
add_layer <- function(rdeck, layer) {
  stopifnot(
    inherits(rdeck, "rdeck"),
    inherits(layer, "layer")
  )

  rdeck$x$layers <- c(
    rdeck$x$layers,
    list(layer)
  )

  rdeck
}

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

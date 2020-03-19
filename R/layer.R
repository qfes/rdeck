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
#' @param tooltip `character` | `name`
#' Tooltip columns; either an expression returning a character vector, or an
#' expression to deparse. Example: `c(date, count, "a_literal")`
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
  property_names <- names(properties)

  # data
  properties$data <- layer_data(data, type)
  if (inherits(data, "sf")) {
    properties$position_format <- get_position_format(data)
  }

  # tooltip
  if (!is.null(properties$tooltip)) {
    properties$tooltip <- tooltip(properties$tooltip)
  }

  # color_range
  if ("color_range" %in% property_names) {
    properties$color_range <- get_color_range(properties$color_range)
  }

  # create accessor expressions for each accessor
  is_accessor <- property_names %in% accessor_names
  accessors <- lapply(
    properties[is_accessor],
    function(expr) accessor(expr, data, type != "GeoJson")
  )

  is_color_accessor <- tolower(names(accessors)) %>% endsWith("color")
  color_accessors <- lapply(
    accessors[is_color_accessor],
    function(color) {
      # constant color
      if (is.character(color)) {
        return(hex_to_rgba(color)[, 1])
      }

      # color object ? validate value name
      if (inherits(color, "color") && !is.null(data)) {
        stopifnot(color$value %in% colnames(data))
      }

      color
    }
  )

  # convert constant color expressions
  is_color_property <- tolower(property_names) %>% endsWith("color")
  color_properties <- lapply(
    properties[is_color_property & !is_accessor],
    function(color) if (!is.character(color)) color else hex_to_rgba(color)[, 1]
  )

  # overwrite accessors & colors
  properties <- properties %>%
    merge_list(color_properties) %>%
    merge_list(accessors, color_accessors)

  structure(
    lapply(properties, eval) %>%
      camel_case_names(),
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
#' @seealso <https://github.com/uber/deck.gl/blob/master/docs/api-reference/layer.md>
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

      # performance optimisation for serialising points
      if (inherits(sfc, "sfc_POINT")) do.call(rbind, sfc) else sfc
    })
  )
}

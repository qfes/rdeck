#' Layer
#'
#' Create a deck.gl [layer](https://github.com/uber/deck.gl/blob/master/docs/api-reference/layer.md)
#'
#' @name layer
#' @param rdeck `rdeck`
#' An rdeck map
#'
#' @param type `character`
#' deck.gl layer type.
#'
#' @param id `character`
#' The id of the layer. Layer ids must be unique per layer `type` for deck.gl
#' to properly distinguish between them.
#'
#' @param data `data.frame` | `sf::sf`
#' Deck.gl layer data, either a [data.frame] or [sf::sf].
#'
#' @param visible `logical`
#' Whether the layer is visible.
#'
#' @param pickable `logical`
#' Whether the layer responds to mouse pointer picking events.
#'
#' @param opacity `numeric`
#' The opacity of the layer.
#'
#' @param position_format `"XY"` | `"XYZ"`
#' Determines whether each coordinate has two (XY) or three (XYZ) numbers.
#'
#' @param color_format `"RGB"` | `"RGBA"`
#' RGB will make the layer ignore the alpha channel of colours returned by
#' accessors. Opacity controlled by `opacity` is still applied.
#'
#' @param auto_highlight `logical`
#' When `TRUE`, current object pointed by mouse pointer (when hovered over) is
#' highlighted with highlight_color. Requires `pickable` to be `TRUE`.
#'
#' @param highlight_color `integer` vector of (R,G,B) or (R,G,B,A)
#' RGBA color to be used to render highlighted object. When 3 component (RGB)
#' array is specified, a default value of 255 is used for alpha.
#'
#' @param tooltip `character` | `name`
#' Tooltip columns; either an expression returning a character vector, or an
#' expression to deparse. Example: `c(date, count, "a_literal")`
#'
#' @param ... additional deck.gl layer parameters
#'
#' @seealso <https://github.com/uber/deck.gl/blob/master/docs/api-reference/layer.md>
#' @keywords internal
layer <- function(...,
                  type,
                  id = type,
                  data = data.frame(),
                  visible = TRUE,
                  pickable = FALSE,
                  opacity = 1,
                  position_format = "XYZ",
                  color_format = "RGBA",
                  auto_highlight = FALSE,
                  highlight_color = "#00008080") {
  stopifnot(
    type %in% layers,
    is.character(id) && length(id) == 1,
    inherits(data, "data.frame"),
    position_format %in% c("XYZ", "XY"),
    color_format %in% c("RGBA", "RGB")
  )

  arg_names <- rlang::call_args_names(sys.call())
  props <- c(
    as.list(environment()),
    list(...)
  )[arg_names]

  # data
  props$data <- layer_data(data, type)
  if (inherits(data, "sf")) {
    props$position_format <- get_position_format(data)
  }

  structure(
    camel_case_names(props),
    class = "layer"
  )
}

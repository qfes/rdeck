#' Add a deck.gl [layer](https://github.com/uber/deck.gl/blob/master/docs/api-reference/layer.md) to an rdeck map.
#'
#' @name add_layer
#'
#' @param rdeck [`rdeck`]
#'  An [rdeck] map.
#'
#' @param layer [`layer`]
#'
#' @returns [`rdeck`]
#'  The [rdeck] map.
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
    list(
      list(
        type = class(layer)[1],
        props = layer
      )
    )
  )

  rdeck
}

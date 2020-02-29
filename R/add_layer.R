#' Add layer to deck
#'
#' @title add_layer
#' @param rdeck `{rdeck}`
#' @param layer `{layer}`
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/master/docs/api-reference/layer.md}
#' @md
add_layer <- function(rdeck, layer) {
  # FIXME: BitmapLayer
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

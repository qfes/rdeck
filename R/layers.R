# construct a layer object
new_layer <- function(type, ...) {
  rlang::check_required(type)
  props <- c(
    list(type = type),
    rlang::dots_list(..., .ignore_empty = "all")
  )

  structure(
    props,
    class = c(type, "Layer", "layer")
  )
}

# add a new layer
add_layer <- function(rdeck, layer) {
  UseMethod("add_layer")
}

#' update an existing layer
update_layer <- function(rdeck, layer) {
  UseMethod("update_layer")
}

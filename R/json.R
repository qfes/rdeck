
#' To JSON
#'
#' Modify `obj` for JSON serialisation.
#'
#' @keywords internal
#' @noRd
to_json <- function(obj) {
  UseMethod("to_json")
}

to_json.default <- function(obj) obj

to_json.rdeck <- function(obj) {
  to_json.list(obj)
}

to_json.list <- function(obj) {
  obj_json <- structure(
    lapply(obj, function(p) to_json(p)),
    class = class(obj)
  )

  mostattributes(obj_json) <- attributes(obj)
  obj_json
}

to_json.layer <- function(obj) {
  names(obj) <- snakecase::to_lower_camel_case(names(obj))
  if (!is.null(obj$data)) {
    obj$data <- layer_data(obj)
  }

  to_json.list(obj)
}

to_json.accessor <- function(obj) {
  names(obj) <- snakecase::to_lower_camel_case(names(obj))
  to_json.list(obj)
}

to_json.rdeck_props <- function(obj) {
  names(obj) <- snakecase::to_lower_camel_case(names(obj))
  to_json.list(obj)
}

to_json.view_state <- function(obj) {
  names(obj) <- snakecase::to_lower_camel_case(names(obj))
  to_json.list(obj)
}

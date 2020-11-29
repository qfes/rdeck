
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

to_json.list <- function(obj) {
  obj_json <- structure(
    lapply(obj, function(p) to_json(p)),
    class = class(obj)
  )

  mostattributes(obj_json) <- attributes(obj)
  obj_json
}

to_json.rdeck <- to_json.list

camel_case <- function(obj) {
  names(obj) <- snakecase::to_lower_camel_case(names(obj))
  to_json.list(obj)
}

to_json.layer <- function(obj) {
  if (!is.null(obj$data)) {
    obj$data <- layer_data(obj)
  }

  camel_case(obj)
}

to_json.accessor <- camel_case
to_json.rdeck_props <- camel_case
to_json.view_state <- camel_case

to_json.tooltip <- function(obj) {
  camel_case(obj)
  obj$cols <- list(obj$cols)
  obj
}

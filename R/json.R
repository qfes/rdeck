
#' To JSON
#'
#' Modify `x` for JSON serialisation.
#'
#' @keywords internal
#' @noRd
to_json <- function(x) {
  UseMethod("to_json")
}

to_json.default <- function(x) x

to_json.rdeck <- function(x) {
  to_json.list(x)
}

to_json.list <- function(x) {
  structure(
    lapply(x, function(p) to_json(p)),
    class = class(x)
  )
}

to_json.layer <- function(x) {
  names(x) <- snakecase::to_lower_camel_case(names(x))
  if (!is.null(x$data)) {
    x$data <- layer_data(x)
  }

  to_json.list(x)
}

to_json.accessor <- function(x) {
  names(x) <- snakecase::to_lower_camel_case(names(x))
  to_json.list(x)
}

to_json.rdeck_props <- function(x) {
  names(x) <- snakecase::to_lower_camel_case(names(x))
  to_json.list(x)
}

to_json.view_state <- function(x) {
  names(x) <- snakecase::to_lower_camel_case(names(x))
  to_json.list(x)
}

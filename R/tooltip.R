#' Make Tooltip
#'
#' Create a character vector representing names to be included in a tooltip
#'
#' @name make_tooltip
#' @param quosure
#' The quosure to evaluate.
#'
#' - Literals and calls other than `c()` are evaluated
#' - Names are deparsed
#' - Arguments to `c()` are modified using the logic of the above.
#' @param data
#'
#' @keywords internal
#' @noRd
make_tooltip <- function(quosure, data = NULL) {
  stopifnot(rlang::is_quosure(quosure))
  expr <- rlang::get_expr(quosure)

  if (rlang::is_false(expr) || rlang::is_null(expr) || rlang::is_na(expr)) {
    return(FALSE)
  }

  if (rlang::is_true(expr)) {
    return(TRUE)
  }

  # character expr
  if (rlang::is_character(expr)) {
    name <- rlang::eval_tidy(expr)
    stopifnot(rlang::is_empty(data) || rlang::has_name(data, name))

    return(name)
  }

  # name expr
  if (rlang::is_symbol(expr)) {
    name <- deparse(expr, backtick = FALSE)
    stopifnot(rlang::is_empty(data) || rlang::has_name(data, name))

    return(name)
  }

  # call expr
  if (rlang::is_call(quosure)) {
    if (rlang::call_name(quosure) == "c") {
      return(
        rlang::call_args(quosure) %>%
          lapply(function(arg) make_tooltip(rlang::enquo(arg), data)) %>%
          unlist()
      )
    }

    value <- rlang::eval_tidy(expr)
    stopifnot(rlang::is_character(value))

    return(value)
  }

  # todo: helpful message
  stop("Not supported")
}

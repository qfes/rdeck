#' Tooltip
#'
#' Create a character vector representing names to be included in a tooltip
#'
#' @name tooltip
#' @param expr
#' The expr to evaluate / deparse.
#'
#' - Literals and calls other than `c()` are evaluated
#' - Names are deparsed
#' - Arguments to `c()` are modified using the logic of the above.
#'
#' @return evaluated expression.
#'
#' @noRd
tooltip <- function(expr) {
  UseMethod("tooltip")
}

tooltip.default <- function(expr) {
  eval(expr)
}

tooltip.name <- function(expr) {
  deparse(expr, backtick = FALSE)
}

tooltip.call <- function(expr) {
  if (expr[[1]] != "c") {
    return(eval(expr))
  }

  arguments <- as.list(expr)[-1]
  # deparse names, evaluate others
  lapply(arguments, function(arg) tooltip(arg)) %>%
    unlist()
}

#' Create accessors for deck.gl layers.
#'
#' @name accessor
#' @param data `{data.frame}`
#'  used as expr environment
#' @param expr `{name | call | atomic}`
#'  an expression typically created with [base::substitute()]
#'
#' @return `{JS | expr}`
accessor <- function(data, expr) {
  # no data, or expr is constant
  if (is.null(data) || !inherits(expr, c("name", "call"))) {
    return(eval(expr))
  }

  columns <- names(data)

  # expr is name, but not a column
  if (is.name(expr) && !(deparse(expr) %in% columns)) {
    return(eval(expr))
  }

  # expr is call, but not formula
  if (is.call(expr) && expr[[1]] != "~") {
    return(eval(expr))
  }

  # visit name
  visit_name <- function(expr) {
    if (deparse(expr) %in% columns) {
      name <- paste0(
        "data.frame[\"", deparse(expr, backtick = FALSE), "\"][index]"
      ) %>%
        as.name()
      return(name)
    }

    expr
  }

  # visit call
  visit_call <- function(expr) {
    call_name <- expr[[1]]
    call_args <- as.list(expr)[-1] %>%
      lapply(function(x) {
        if (is.call(x)) {
          visit_call(x)
        } else if (is.name(x)) {
          visit_name(x)
        } else {
          x
        }
      })

    new_call <- as.call(c(call_name, call_args))

    if (new_call[1] == "c()") {
      name <- deparse(new_call, backtick = FALSE) %>%
        substr(3, nchar(.) - 1) %>%
        paste0("[", ., "]") %>%
        as.name()

      return(name)
    }

    new_call
  }

  lambda <- paste0("(object, {index, data}) => ")

  if (is.name(expr)) {
    return(
      htmlwidgets::JS(
        paste0(lambda, deparse(visit_name(expr), backtick = FALSE))
      )
    )
  }

  # get rhs of formula
  formula <- expr[[length(expr)]]
  htmlwidgets::JS(
    paste0(lambda, deparse(visit_call(formula), backtick = FALSE))
  )
}

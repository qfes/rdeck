#' Evaluate Tooltip
#'
#' Create a character vector representing names to be included in a tooltip.
#' @name eval_tooltip
#' @param quo The quosure to evaluate.
#'
#' - Logicals are interpreted as tooltip on / off. NULL & NA are falsey
#' - If `data` is a `data.frame`, quo is a tidyselect::eval_select() clause
#' - Otherwise:
#'   - Names are deparsed
#'   - Literals and calls other than `c()` are evaluated
#'   - `c()` arguments are evaluated recursively with `eval_tooltip`
#' @param data The data to evaluate names on
#'
#' @keywords internal
#' @noRd
eval_tooltip <- function(quo, data = NULL) {
  expr <- rlang::get_expr(quo)

  # tooltip disabled
  if (rlang::is_false(expr) || rlang::is_null(expr) || rlang::is_na(expr)) {
    return(FALSE)
  }

  # tooltip enabled, all names used
  if (rlang::is_true(expr)) {
    return(TRUE)
  }

  # tidyselect
  if (inherits(data, "data.frame")) {
    return(
      tidyselect::eval_select(quo, data) %>%
        names()
    )
  }

  # name
  if (rlang::is_symbol(expr)) {
    return(rlang::as_name(expr))
  }

  # c()
  if (rlang::is_call(expr) && rlang::call_name(expr) == "c") {
    return(
      rlang::call_args(expr) %>%
        lapply(function(arg) eval_tooltip(rlang::expr(!!arg), data)) %>%
        unlist()
    )
  }

  rlang::eval_tidy(expr)
}

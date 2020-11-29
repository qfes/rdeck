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
#' @inheritParams accessor
#'
#' @keywords internal
#' @noRd
eval_tooltip <- function(quo, data = NULL, data_type = NULL) {
  assert_type(quo, "quosure")
  if (!is.null(data_type)) {
    assert_in(data_type, c("table", "object", "geojson"))
  }
  expr <- rlang::get_expr(quo)

  # tooltip disabled
  if (rlang::is_false(expr) || rlang::is_null(expr) || rlang::is_na(expr)) {
    return(NULL)
  }

  # tooltip enabled, all names used
  if (rlang::is_true(expr)) {
    return(tooltip(TRUE, data, data_type))
  }

  # tidyselect
  if (inherits(data, "data.frame")) {
    cols <- tidyselect::eval_select(quo, data) %>%
      names()

    return(tooltip(cols, data, data_type))
  }

  # name
  if (rlang::is_symbol(expr)) {
    return(tooltip(rlang::as_name(expr), data, data_type))
  }

  # c()
  if (rlang::is_call(expr) && rlang::call_name(expr) == "c") {
    cols <- rlang::call_args(expr) %>%
      lapply(function(arg) rlang::as_name(arg)) %>%
      unlist()

    return(tooltip(cols, data, data_type))
  }

  # a character vector
  cols <- rlang::eval_tidy(expr)
  assert_type(cols, "character", "tooltip")

  tooltip(cols, data)
}

tooltip <- function(cols, data = NULL, data_type = NULL) {
  structure(
    list(
      cols = cols,
      data_type = data_type %||% ifelse(inherits(data, "data.frame"), "table", "object")
    ),
    class = "tooltip"
  )
}

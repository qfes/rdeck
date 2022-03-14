#' Tooltip
#'
#' Create a character vector representing names to be included in a tooltip.
#'
#' @details
#' - logicals are interpreted as tooltip on / off. NULL & NA are falsey
#' - if `data` is a `data.frame`, expr is a tidyselect::eval_select() clause
#' - otherwise:
#'   - character vectors are used as is
#'   - names are deparsed with rlang::as_name()
#'   - calls other than `c()` are evaluated, tooltip() called with result
#'   - `c()` arguments are deparsed
#'
#' @name tooltip
#' @inheritParams accessor
#'
#' @keywords internal
#' @noRd
#'
tooltip <- function(expr, data = NULL, data_type = NULL) {
  if (rlang::is_na(expr)) return(NULL)

  UseMethod("tooltip")
}

tooltip.quosure <- function(expr, data, data_type) {
  tooltip(rlang::get_expr(expr), data, data_type)
}

tooltip.NULL <- function(expr, data, data_type) {
  NULL
}

tooltip.logical <- function(expr, data, data_type) {
  tidyassert::assert(length(expr) == 1, "Tooltip boolean expression must be a scalar")

  if (rlang::is_false(expr) || rlang::is_na(expr)) return(NULL)
  if (is_dataframe(data)) return(new_tooltip(TRUE, data, data_type))

  tooltip_tidyselect(tidyselect::everything(), data, data_type)
}

tooltip.name <- function(expr, data, data_type) {
  tooltip.character(rlang::as_name(expr), data, data_type)
}

tooltip.character <- function(expr, data, data_type) {
  tidyassert::assert(!is.na(expr), "Tooltip columns must not contain missing values")

  if (!is_dataframe(data)) {
    cols <- unname(expr)[!is.na(expr)]
    return(new_tooltip(cols, data, data_type))
  }

  tooltip_tidyselect(expr, data, data_type)
}

tooltip.call <- function(expr, data, data_type) {
  if (!is_dataframe(data)) {
    # emulate tidy-select of a quoted c() call
    if (rlang::call_name(expr) == "c") {
      cols <- vcapply(rlang::call_args(expr), rlang::as_name, named = FALSE)
      return(new_tooltip(cols, data, data_type))
    }

    # recursive: invoke tooltip() on call result
    return(tooltip(rlang::eval_tidy(expr), data, data_type))
  }

  tooltip_tidyselect(expr, data, data_type)
}

tooltip_tidyselect <- function(expr, data, data_type) {
  tidyassert::assert(is_dataframe(data))

  pos <- tidyselect::eval_select(expr, data)
  sfc_pos <- tidyselect::eval_select(rlang::expr(where(is_sfc)), data)
  cols <- names(data)[setdiff(pos, sfc_pos)]

  new_tooltip(cols, data, data_type)
}

new_tooltip <- function(cols, data = NULL, data_type = NULL) {
  structure(
    list(
      cols = cols,
      data_type = data_type %||% resolve_data_type(data)
    ),
    class = "tooltip"
  )
}

is_tooltip <- function(object) inherits(object, "tooltip")

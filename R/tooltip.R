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
tooltip <- function(expr, data = NULL) {
  if (rlang::is_na(expr)) return(NULL)

  UseMethod("tooltip")
}

tooltip.quosure <- function(expr, data) {
  tooltip(rlang::get_expr(expr), data)
}

tooltip.NULL <- function(expr, data) {
  NULL
}

tooltip.logical <- function(expr, data) {
  tidyassert::assert(length(expr) == 1, "Tooltip boolean expression must be a scalar")

  if (rlang::is_false(expr) || rlang::is_na(expr)) return(NULL)
  if (!is_dataframe(data) && !is_tile_json(data)) return(new_tooltip(TRUE))

  tooltip_tidyselect(tidyselect::everything(), data)
}

tooltip.name <- function(expr, data) {
  tooltip.character(rlang::as_name(expr), data)
}

tooltip.character <- function(expr, data) {
  tidyassert::assert(!is.na(expr), "Tooltip columns must not contain missing values")

  if (!is_dataframe(data) && !is_tile_json(data)) {
    cols <- unname(expr)[!is.na(expr)]
    return(new_tooltip(cols))
  }

  tooltip_tidyselect(expr, data)
}

tooltip.call <- function(expr, data) {
  if (!is_dataframe(data) && !is_tile_json(data)) {
    # emulate tidy-select of a quoted c() call
    if (rlang::call_name(expr) == "c") {
      cols <- vcapply(rlang::call_args(expr), rlang::as_name, named = FALSE)
      return(new_tooltip(cols))
    }

    # tidyselect everything
    if (rlang::call_name(expr) == "everything") {
      return(new_tooltip(TRUE))
    }

    # recursive: invoke tooltip() on call result
    return(tooltip(rlang::eval_tidy(expr), data))
  }

  if (rlang::call_name(expr) == "cur_value") {
    return(tooltip.cur_value(rlang::eval_tidy(expr), data))
  }

  tooltip_tidyselect(expr, data)
}

tooltip.cur_value <- function(expr, data) expr

tooltip_tidyselect <- function(expr, data) {
  tidyassert::assert(is_dataframe(data) || is_tile_json(data))

  if (is_tile_json(data)) {
    field_names <- unique(data$fields$field)
    fields <- rlang::set_names(seq_along(field_names), field_names)
    pos <- tidyselect::eval_select(expr, fields)

    return(new_tooltip(names(fields)[pos]))
  }

  pos <- tidyselect::eval_select(expr, data)
  sfc_pos <- tidyselect::eval_select(rlang::expr(where(is_sfc)), data)
  cols <- names(data)[setdiff(pos, sfc_pos)]

  return(new_tooltip(cols))
}

new_tooltip <- function(cols) {
  structure(
    list(cols = cols),
    class = "tooltip"
  )
}

is_tooltip <- function(object) inherits(object, "tooltip")

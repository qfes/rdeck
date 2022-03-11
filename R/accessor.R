#' Accessor
#'
#' @name accessor
#' @param quo a quosure
#' @param data anything. If data.frame, names evaluated from `quo` are validated against data
#' @param data_type determine the structure of the serialised data. One of:
#' - table
#' - object
#' - geojson
#'
#' @keywords internal
#' @noRd
accessor <- function(quo, data = NULL, data_type = NULL) {
  # dispatch off the quosure expression
  expr <- if (!rlang::quo_is_symbol(quo)) rlang::eval_tidy(quo) else rlang::quo_get_expr(quo)
  UseMethod("accessor", expr)
}

accessor.default <- function(quo, data = NULL, data_type = NULL) {
  rlang::eval_tidy(quo)
}

accessor.name <- function(quo, data = NULL, data_type = NULL) {
  col <- rlang::as_name(quo)

  if (!is.null(data_type)) {
    tidyassert::assert(data_type %in% c("table", "object", "geojson"))
  }

  structure(
    list(
      col = col,
      data_type = data_type %||% resolve_data_type(data)
    ),
    class = "accessor"
  )
}

accessor.sf_column <- function(quo, data = NULL, data_type = NULL) {
  # sf_column only applicable to sf objects
  tidyassert::assert(
    inherits(data, "sf"),
    "{.fn sf_column} requires {.cls sf} datatset",
    print_expr = substitute(inherits(data, "sf") || !inherits(quo, "sf_column"))
  )

  new_quo <- rlang::as_quosure(attr(data, "sf_column"), rlang::quo_get_env(quo))
  accessor.name(new_quo, data, data_type)
}

accessor.scale <- function(quo, data = NULL, data_type = NULL) {
  scale <- rlang::eval_tidy(quo)

  # does column exist?
  tidyassert::assert(
    !inherits(data, "data.frame") || rlang::has_name(data, scale$col),
    "Scale column {.col {col}} doesn't exist",
    print_expr = substitute(!inherits(data, "data.frame") || rlang::has_name(data, quo$col)),
    col = substitute(scale$col)
  )

  # train scale limits / levels / data
  scale_limits <- scale$limits %||% scale$levels %||% scale$data
  if (inherits(data, "data.frame") && !is.null(scale_limits)) {
    scale_limits$train(data[[scale$col]])
  }

  purrr::list_modify(
    scale,
    data_type = data_type %||% resolve_data_type(data)
  )
}

is_accessor <- function(object) inherits(object, "accessor")

resolve_data_type <- function(data = NULL) {
  ifelse(is.null(data) | inherits(data, "data.frame"), "table", "object")
}

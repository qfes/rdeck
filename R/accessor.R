#' Accessor
#'
#' @name accessor
#' @param quo a quosure
#' @param data anything. If data.frame, names evaluated from `quo` are validated against data
#' @param is_columnar determine if data is serialised as a data.frame or a list of object
#'
#' @keywords internal
#' @noRd
accessor <- function(quo, data = NULL, is_columnar = NULL) {
  assert_type(quo, "quosure")

  if (!rlang::quo_is_symbol(quo)) {
    value <- rlang::eval_tidy(quo)
    assert_scalar(value)
    return(value)
  }

  name <- rlang::as_name(quo)
  if (inherits(data, "data.frame")) {
    assert_col_exists(name, data)
  }

  structure(
    list(
      value = name,
      is_columnar = is_columnar %||% inherits(data, "data.frame")
    ),
    class = "accessor"
  )
}

#' Accessor Scale
#'
#' @name accessor_scale
#' @inheritParams accessor
#'
#' @keywords internal
#' @noRd
accessor_scale <- function(quo, data = NULL, is_columnar = NULL) {
  assert_type(quo, "quosure")
  expr <- rlang::get_expr(quo)

  # is quo a scale object or scale call
  is_scale <- inherits(expr, "scale") ||
    rlang::is_call(expr) &&
      grepl("scale_\\w+", rlang::call_name(expr), perl = TRUE)

  if (!is_scale) {
    return(accessor(quo, data, is_columnar))
  }

  scale_expr <- rlang::eval_tidy(expr)
  col_name <- as.name(scale_expr$value)

  # create accessor
  scale <- structure(
    utils::modifyList(
      scale_expr,
      accessor(rlang::new_quosure(col_name), data, is_columnar),
      keep.null = TRUE
    ),
    class = c("accessor_scale", "accessor")
  )

  # compute scale domain
  if (is.null(scale$domain) && scale$type != "quantile" && !rlang::is_empty(data)) {
    scale$domain <- scale_domain(scale, data[[as.character(scale$value)]])
  }

  scale
}

#' Make accessor
#'
#' @name make_accessor
#' @param quosure
#' A quosure expression
#' @param data
#' A data frame from which to obtain names
#' @param columnar
#' Determine if the generated accessor js function is column or row structure
#'
#' @keywords internal
#' @noRd
make_accessor <- function(quosure, data = NULL, columnar = TRUE) {
  stopifnot(rlang::is_quosure(quosure))
  expr <- rlang::get_expr(quosure)

  if (rlang::is_symbol(expr)) {
    name <- deparse(expr, backtick = FALSE)
    stopifnot(rlang::is_empty(data) || rlang::has_name(data, name))

    lambda <- ifelse(
      columnar,
      paste0("(object, {index, data}) => data.frame[\"", name, "\"][index]"),
      paste0("data => data[\"", name, "\"]")
    )

    return(htmlwidgets::JS(lambda))
  }

  rlang::eval_tidy(quosure)
}

#' Make scalable accessor
#'
#' @name make_scalable_accessor
#' @param quosure
#' A quosure expression
#' @param data
#' A data frame from which to obtain names
#' @param columnar
#' Determine if the generated accessor js function is column or row structure
#'
#' @keywords internal
#' @noRd
make_scalable_accessor <- function(quosure, data = NULL, columnar = TRUE) {
  stopifnot(rlang::is_quosure(quosure))
  expr <- rlang::get_expr(quosure)

  if (rlang::is_call(expr) && grepl("scale_\\w+", rlang::call_name(expr), perl = TRUE)) {
    scale <- rlang::eval_tidy(quosure)
    stopifnot(rlang::is_empty(data) || rlang::has_name(data, scale$value))

    if (is.null(scale$domain) && scale$type != "quantile" && !rlang::is_empty(data)) {
      data <- as.data.frame(data)
      scale$domain <- scale_domain(scale, data[scale$value])
    }

    return(scale)
  }

  make_accessor(quosure, data, columnar)
}

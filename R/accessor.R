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
  expr <- rlang::get_expr(quo)

  if (!rlang::is_symbol(expr)) {
    return(rlang::eval_tidy(expr))
  }

  name <- rlang::as_name(expr)
  if (inherits(data, "data.frame") && !rlang::has_name(data, name)) {
    rlang::abort(paste0("Column `", name, "` doesn't exist"))
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
  expr <- rlang::get_expr(quo)
  is_scale <- inherits(expr, "scale") ||
    rlang::is_call(expr) &&
      grepl("scale_\\w+", rlang::call_name(expr), perl = TRUE)

  if (!is_scale) {
    return(accessor(quo, data))
  }

  scale_expr <- rlang::eval_tidy(expr)
  scale <- structure(
    utils::modifyList(
      scale_expr,
      accessor(rlang::expr(!!scale_expr$value), data, is_columnar)
    ),
    class = c("accessor_scale", "accessor")
  )

  if (is.null(scale$domain) && scale$type != "quantile" && nrow(data) > 0) {
    data <- as.data.frame(data)
    scale$domain <- scale_domain(scale, data[as.character(scale$value)])
  }

  scale
}

setOldClass("accessor")
#' @importMethodsFrom jsonlite asJSON
#' @export
setMethod("asJSON", "accessor", function(x, force = FALSE, ...) {
  camel_case_names(x) %>%
    unclass() %>%
    asJSON(force, ...)
})

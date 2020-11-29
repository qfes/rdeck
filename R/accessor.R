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
  assert_type(quo, "quosure")
  if (!is.null(data_type)) {
    assert_in(data_type, c("table", "object", "geojson"))
  }

  if (!rlang::quo_is_symbol(quo)) {
    return(rlang::eval_tidy(quo))
  }

  name <- rlang::as_name(quo)
  if (inherits(data, "data.frame")) {
    assert_col_exists(name, data)
  }

  structure(
    list(
      type = "accessor",
      col = name,
      data_type = data_type %||% ifelse(inherits(data, "data.frame"), "table", "object")
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
accessor_scale <- function(quo, data = NULL, data_type = NULL) {
  assert_type(quo, "quosure")
  if (!is.null(data_type)) {
    assert_in(data_type, c("table", "object", "geojson"))
  }
  expr <- rlang::get_expr(quo)

  # is quo a scale object or scale call
  is_scale <- inherits(expr, "scale") ||
    rlang::is_call(expr) && grepl("scale_\\w+", rlang::call_name(expr))

  if (!is_scale) {
    return(accessor(quo, data, data_type))
  }

  scale_expr <- rlang::eval_tidy(expr)
  col_name <- as.name(scale_expr$value)

  # create accessor
  scale <- structure(
    utils::modifyList(
      c(scale_expr, list(scale = scale_expr$type)),
      accessor(rlang::new_quosure(col_name), data, data_type),
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

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

  col <- rlang::as_name(quo)
  if (inherits(data, "data.frame")) {
    assert_col_exists(col, data)
  }

  structure(
    list(
      col = col,
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
  col_name <- as.name(scale_expr$col)

  accessor_ <- accessor(rlang::new_quosure(col_name), data, data_type)

  # create accessor
  scale <- structure(
    utils::modifyList(
      accessor_,
      scale_expr,
      keep.null = TRUE
    ),
    class = c(class(scale_expr), "accessor_scale", class(accessor_))
  )

  # scale col references a vector of the correct type
  validate_col(scale, data)

  # scale limits
  if (rlang::has_name(scale, "limits")) {
    if (!inherits(data, "data.frame")) {
      assert_not_null(scale$limits)
    }

    scale$limits <- scale$limits %||% range(data[[scale$col]])
  }

  # scale domain
  scale$domain <- scale_domain(scale, data)

  scale
}


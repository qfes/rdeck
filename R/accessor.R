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
  tidyassert::assert(rlang::is_quosure(quo))
  tidyassert::assert(is.null(data_type) || data_type %in% c("table", "object", "geojson"))

  expr <- if (!rlang::quo_is_symbol(quo)) rlang::eval_tidy(quo)

  # simple expression? return it
  if (!rlang::quo_is_symbol(quo) && !inherits(expr, "sf_column")) {
    return(expr)
  }

  tidyassert::assert(
    inherits(data, "sf") || !inherits(expr, "sf_column"),
    "{.fn sf_column} requires {.cls sf} datatset",
    print_expr = substitute(inherits(data, "sf") || !inherits(quo, "sf_column"))
  )

  # sf_column() ? pull col from sf object
  col <- if (inherits(expr, "sf_column")) attr(data, "sf_column") else rlang::as_name(quo)
  if (inherits(data, "data.frame")) assert_col_exists(col, data)

  structure(
    list(
      col = col,
      data_type = data_type %||% resolve_data_type(data)
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

  # is quo a scale object or scale call
  expr <- if (rlang::quo_is_call(quo)) rlang::eval_tidy(quo) else rlang::get_expr(quo)
  if (!inherits(expr, "scale")) {
    return(accessor(quo, data, data_type))
  }

  scale_expr <- rlang::eval_tidy(quo)
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
  if (rlang::has_name(scale, "limits") && !inherits(data, "data.frame")) {
    assert_not_null(scale$limits)
  }

  if (!inherits(scale, "scale_category") && is.null(scale$limits)) {
    scale$limits <- scale$limits %||% range(data[[scale$col]], na.rm = TRUE)
  }

  # scale domain & ticks
  scale$domain <- scale_domain(scale, data)
  if (rlang::has_name(scale, "palette")) {
    scale$ticks <- scale_ticks(scale)
  }
  scale
}

resolve_data_type <- function(data = NULL) {
  ifelse(is.null(data) | inherits(data, "data.frame"), "table", "object")
}

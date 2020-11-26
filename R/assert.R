assert_type <- function(obj, type, name = NULL) {
  quo <- rlang::enquo(obj)

  if (!inherits(rlang::eval_tidy(quo), type)) {
    types <- paste0(type, collapse = " | ")
    name <- name %||% rlang::as_name(quo)
    rlang::abort(
      paste0(name, " must be of type: <", types, ">"),
      "rdeck_type_error"
    )
  }
}

assert_col_exists <- function(name, data) {
  if (!rlang::has_name(data, name)) {
    rlang::abort(
      paste0("Column ", name, " doesn't exist"),
      "rdeck_column_oob_error"
    )
  }
}

assert_scalar <- function(obj, name = NULL) {
  quo <- rlang::enquo(obj)
  value <- rlang::eval_tidy(quo)

  if (!rlang::is_scalar_vector(value)) {
    name <- name %||% rlang::as_name(quo)
    rlang::abort(
      paste0(name, " must be a scalar"),
      "rdeck_scalar_error"
    )
  }
}

assert_not_null <- function(obj, name = NULL) {
  quo <- rlang::enquo(obj)

  if (is.null(rlang::eval_tidy(quo))) {
    name <- name %||% rlang::as_name(quo)
    rlang::abort(
      paste0(name, " must not be NULL"),
      "rdeck_not_null_error"
    )
  }
}

assert_finite <- function(obj, name = NULL) {
  quo <- rlang::enquo(obj)

  if (!is.finite(rlang::eval_tidy(quo))) {
    name <- name %||% rlang::as_name(quo)
    rlang::abort(
      paste0(name, " must be finite"),
      "rdeck_finite_error"
    )
  }
}

assert_range <- function(obj, min = NULL, max = NULL, name = NULL) {
  quo <- rlang::enquo(obj)
  value <- rlang::eval_tidy(quo)

  if (!is.null(min) && value < min || !is.null(max) && value > max) {
    name <- name %||% rlang::as_name(quo)
    range <- paste(min %||% "NULL", max %||% "NULL", sep = ", ")
    rlang::abort(
      paste0(name, " must be in range [", range, "]"),
      "rdeck_range_error"
    )
  }
}

assert_rgba <- function(obj, name = NULL) {
  quo <- rlang::enquo(obj)
  value <- rlang::eval_tidy(quo)

  if (!grepl("^#[0-9A-F]{6,8}$", value, ignore.case = TRUE)) {
    name <- name %||% rlang::as_name(quo)
    rlang::abort(
      paste0(name, " must be a valid rgb[a] hex string"),
      "rdeck_rgba_error"
    )
  }
}

assert_in <- function(obj, values, name = NULL) {
  quo <- rlang::enquo(obj)
  value <- rlang::eval_tidy(quo)

  if (!value %in% values) {
    name <- name %||% rlang::as_name(quo)
    vals <- paste0(values, collapse = ", ")
    rlang::abort(
      paste0(name, " must be one of [", vals, "]")
    )
  }
}

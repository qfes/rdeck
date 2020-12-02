assert_type <- function(obj, type, name = NULL) {
  quo <- rlang::enquo(obj)

  if (!inherits(rlang::eval_tidy(quo), type)) {
    types <- paste0(type, collapse = " | ")
    name <- name %||% rlang::quo_text(quo)
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
    name <- name %||% rlang::quo_text(quo)
    rlang::abort(
      paste0(name, " must be a scalar"),
      "rdeck_scalar_error"
    )
  }
}

assert_length <- function(obj, len, name = NULL) {
  quo <- rlang::enquo(obj)
  value <- rlang::eval_tidy(quo)

  if (length(value) != len) {
    name <- name %||% rlang::quo_text(quo)
    rlang::abort(
      paste0(name, " must be length: ", len),
      "rdeck_len_error"
    )
  }
}

assert_not_null <- function(obj, name = NULL) {
  quo <- rlang::enquo(obj)

  if (is.null(rlang::eval_tidy(quo))) {
    name <- name %||% rlang::quo_text(quo)
    rlang::abort(
      paste0(name, " must not be NULL"),
      "rdeck_not_null_error"
    )
  }
}

assert_finite <- function(obj, name = NULL) {
  quo <- rlang::enquo(obj)

  if (!is.finite(rlang::eval_tidy(quo))) {
    name <- name %||% rlang::quo_text(quo)
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
    name <- name %||% rlang::quo_text(quo)
    range <- paste(min %||% "NULL", max %||% "NULL", sep = ", ")
    rlang::abort(
      paste0(name, " must be in range: [", range, "]"),
      "rdeck_range_error"
    )
  }
}

assert_rgba <- function(obj, name = NULL) {
  quo <- rlang::enquo(obj)
  value <- rlang::eval_tidy(quo)

  is_color <- grepl("^#([0-9A-F]{6}|[0-9A-F]{8})$", value, ignore.case = TRUE)
  if (sum(is_color) != length(value)) {
    name <- name %||% rlang::quo_text(quo)
    rlang::abort(
      paste(
        name, "must be a valid rgb[a] hex",
        ifelse(length(value) > 1, "character vector", "string")
      ),
      "rdeck_rgba_error"
    )
  }
}

assert_in <- function(obj, values, name = NULL) {
  quo <- rlang::enquo(obj)
  value <- rlang::eval_tidy(quo)

  if (!value %in% values) {
    name <- name %||% rlang::quo_text(quo)
    vals <- paste0(values, collapse = ", ")
    rlang::abort(
      paste0(name, " must be one of: [", vals, "]"),
      "rdeck_in_error"
    )
  }
}

assert_quo_is_sym <- function(obj, name = NULL) {
  assert_type(obj, "quosure")
  expr <- rlang::quo_get_expr(obj)

  if (!rlang::is_symbol(expr) && !rlang::is_string(rlang::eval_tidy(expr))) {
    name <- name %||% rlang::quo_text(obj)
    rlang::abort(
      paste0(name, " must be a symbol or a string"),
      "rdeck_sym_error"
    )
  }
}

assert_is_string <- function(obj, name = NULL) {
  quo <- rlang::enquo(obj)
  value <- rlang::eval_tidy(quo)

  if (!rlang::is_string(value)) {
    name <- name %||% rlang::quo_text(quo)
    rlang::abort(
      paste0(name, " must be a string"),
      "rdeck_type_error"
    )
  }
}

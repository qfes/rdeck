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

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

assert_length <- function(obj, len, cmp = `==`, name = NULL) {
  quo <- rlang::enquo(obj)
  value <- rlang::eval_tidy(quo)

  if (!cmp(length(value), len)) {
    name <- name %||% rlang::quo_text(quo)
    cmp_name <- deparse(substitute(cmp))
    rlang::abort(
      paste(name, "must be length", cmp_name, len),
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
  is_infinite <- is.infinite(rlang::eval_tidy(quo))

  if (any(is_infinite, na.rm = TRUE)) {
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

  if (!is.null(min) && any(value < min) || !is.null(max) && any(value > max)) {
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

assert_is_rgba <- function(obj) {
  is_color <- function(obj) grepl("^#([0-9A-F]{6}|[0-9A-F]{8})$", obj, ignore.case = TRUE)

  tidyassert::assert(
    is_color(obj),
    error_message = paste0("`", substitute(obj), "`", " must be an rgb[a] vector")
  )
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

  if (rlang::quo_is_missing(obj) ||
    !rlang::is_symbol(expr) && !rlang::is_string(rlang::eval_tidy(expr))) {
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

assert_scalable_is_color <- function(obj, name = NULL) {
  quo <- rlang::enquo(obj)
  value <- rlang::eval_tidy(quo)

  if (!rlang::has_name(value, "palette")) {
    name <- name %||% rlang::quo_text(quo)
    rlang::abort(
      paste0(name, " must be a color scale"),
      "rdeck_type_error"
    )
  }
}

assert_crs <- function(obj, crs = sf::st_crs(4326), name = NULL) {
  quo <- rlang::enquo(obj)
  value <- rlang::eval_tidy(quo)

  if (sf::st_crs(value) != crs) {
    name <- name %||% rlang::quo_text(quo)
    rlang::abort(
      paste0(name, " crs must equal ", crs$input),
      "rdeck_error"
    )
  }
}

assert_scalable_is_numeric <- function(obj, name = NULL) {
  quo <- rlang::enquo(obj)
  value <- rlang::eval_tidy(quo)

  if (!rlang::has_name(value, "range")) {
    name <- name %||% rlang::quo_text(quo)
    rlang::abort(
      paste0(name, " must be a numeric scale"),
      "rdeck_type_error"
    )
  }
}

assert_is_sorted <- function(obj, name = NULL) {
  quo <- rlang::enquo(obj)
  value <- rlang::eval_tidy(quo)

  if (is.unsorted(value)) {
    name <- name %||% rlang::quo_text(quo)
    rlang::abort(
      paste0(name, " must be sorted"),
      "rdeck_error"
    )
  }
}

check_dots <- function(...) {
  dots <- rlang::dots_list(...)
  dots_names <- names(dots)

  if (!all(nzchar(dots_names))) {
    rlang::abort(
      paste0("All dots must be named."),
      class = "rdeck_dots_unnamed"
    )
  }

  if (length(dots) != 0) {
    rlang::warn(
      paste_line(
        "These dots are unrecognised arguments that will be forwarded to Deck.GL javascript:",
        paste0("  * `", dots_names, "` -> `", to_camel_case(dots_names), "`")
      ),
      class = "rdeck_dots_nonempty"
    )
  }
}

check_dots_access_token <- function(...) {
  dots <- rlang::dots_list(...)
  dots_names <- names(dots)

  if (any(dots_names == "mapbox_api_access_token")) {
    rlang::warn(
      paste_line(
        "mapbox_api_access_token should be supplied via one of:",
        "  * `options(rdeck.mapbox_access_token)",
        "  * `environment variable MAPBOX_ACCESS_TOKEN",
        "  * `environment variable MAPBOX_TOKEN",
        "",
        "see ?mapbox_access_token"
      ),
      class = "rdeck_dots_access_token"
    )
  }
}

# validate col
validate_col <- function(scale, data = NULL) {
  UseMethod("validate_col")
}

validate_col.default <- function(scale, data = NULL) {
  col <- scale$col
  assert_is_string(col)

  if (inherits(data, "data.frame")) {
    assert_col_exists(col, data)
    assert_type(data[[col]], c("integer", "numeric"), "col")
  }
}

validate_col.scale_category <- function(scale, data = NULL) {
  col <- scale$col
  assert_is_string(col)

  if (inherits(data, "data.frame")) {
    assert_col_exists(col, data)
  }
}

# validate palette
validate_palette <- function(scale) {
  UseMethod("validate_palette")
}

validate_palette.default <- function(scale) {
  assert_rgba(scale$palette, "palette")
  assert_length(scale$palette, 2, `>=`, "palette")
}

validate_palette.scale_category <- function(scale) {
  assert_rgba(scale$palette, "palette")
}

# validate range
validate_range <- function(scale) {
  UseMethod("validate_range")
}

validate_range.default <- function(scale) {
  assert_type(scale$range, c("integer", "numeric"), "range")
  assert_length(scale$range, 2, `>=`, "range")
}

validate_range.scale_category <- function(scale) {
  assert_type(scale$range, c("integer", "numeric"), "range")
}

# validate na_color
validate_na_color <- function(scale) {
  assert_not_null(scale$na_color, "na_color")
  assert_rgba(scale$na_color, "na_color")
  assert_scalar(scale$na_color, "na_color")
}

# validate na_value
validate_na_value <- function(scale) {
  assert_not_null(scale$na_value, "na_value")
  assert_type(scale$na_value, c("integer", "numeric"), "na_value")
  assert_scalar(scale$na_value, "na_value")
}

# validate unmapped_color
validate_unmapped_color <- function(scale) {
  assert_not_null(scale$unmapped_color, "unmapped_color")
  assert_rgba(scale$unmapped_color, "unmapped_color")
  assert_scalar(scale$unmapped_color, "unmapped_color")
}

# validate unmapped_value
validate_unmapped_value <- function(scale) {
  assert_not_null(scale$unmapped_value, "unmapped_value")
  assert_type(scale$unmapped_value, c("integer", "numeric"), "unmapped_value")
  assert_scalar(scale$unmapped_value, "unmapped_value")
}

# validate limits
validate_limits <- function(scale) {
  limits <- scale$limits
  if (!is.null(limits)) {
    assert_type(limits, c("integer", "numeric"))
    assert_length(limits, 2)
  }
}

# validate breaks
validate_breaks <- function(scale) {
  UseMethod("validate_breaks")
}

validate_breaks.scale <- function(scale) {
  breaks <- scale$breaks
  if (!is.null(breaks)) {
    assert_type(breaks, c("integer", "numeric"))

    # check length
    name <- if (rlang::has_name(scale, "palette")) "palette" else "range"
    if (length(breaks) != length(scale[[name]]) - 2) {
      rlang::abort(
        paste0("length(breaks) must be length(", name, ") - 2"),
        "rdeck_error"
      )
    }
  }
}

validate_breaks.scale_threshold <- function(scale) {
  breaks <- scale$breaks
  assert_type(breaks, c("integer", "numeric"))

  # check length
  name <- if (rlang::has_name(scale, "palette")) "palette" else "range"
  if (length(breaks) != length(scale[[name]]) - 1) {
    rlang::abort(
      paste0("length(breaks) must be length(", name, ") - 1"),
      "rdeck_error"
    )
  }
}

# validate legend
validate_legend <- function(scale) {
  assert_type(scale$legend, "logical", "legend")
}

# validate exponent
validate_exponent <- function(scale) {
  exponent <- scale$exponent
  assert_type(exponent, c("integer", "numeric"))
  assert_scalar(exponent)
}

# validate base
validate_base <- function(scale) {
  base <- scale$base
  assert_type(base, c("integer", "numeric"))
  assert_scalar(base)

  if (base <= 0 || base == 1) {
    rlang::abort(
      "base must be a strictly positive value != 1",
      "rdeck_error"
    )
  }
}

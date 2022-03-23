#' Accessor
#'
#' @name accessor
#' @param expr an expression
#' @param data anything. If data.frame, names evaluated from `quo` are validated against data
#' @param data_type determine the structure of the serialised data. One of:
#' - table
#' - object
#' - geojson
#'
#' @keywords internal
#' @noRd
accessor <- function(expr, data = NULL, data_type = NULL) {
  UseMethod("accessor", expr)
}

accessor.default <- function(expr, data = NULL, data_type = NULL) {
  rlang::eval_tidy(expr)
}

accessor.quosure <- function(expr, data = NULL, data_type = NULL) {
  # dispatch off the quosure expression
  if (rlang::quo_is_symbol(expr)) {
    return(accessor.name(rlang::get_expr(expr), data, data_type))
  }

  accessor(rlang::eval_tidy(expr), data, data_type)
}

accessor.name <- function(expr, data = NULL, data_type = NULL) {
  new_accessor(rlang::as_name(expr), data, data_type)
}

accessor.sf_column <- function(expr, data = NULL, data_type = NULL) {
  # sf_column only applicable to sf objects
  tidyassert::assert(
    inherits(data, "sf"),
    "{.fn sf_column} requires {.cls sf} datatset",
    print_expr = substitute(inherits(data, "sf") || !inherits(expr, "sf_column"))
  )

  accessor.name(attr(data, "sf_column"), data, data_type)
}

accessor.scale <- function(expr, data = NULL, data_type = NULL) {
  scale <- expr
  scale_limits <- scale$limits %||% scale$levels %||% scale$data

  if (is_dataframe(data)) {
    # does column exist?
    tidyassert::assert(
      rlang::has_name(data, scale$col),
      "Scale column {.col {col}} doesn't exist",
      print_expr = substitute(rlang::has_name(data, expr$col)),
      col = scale$col
    )

    # populate limits / levels / data if not given
    if (is.null(scale_limits$range)) {
      scale_limits$train(data[[scale$col]])
    }

    return(
      mutate(
        scale,
        data_type = data_type %||% resolve_data_type(.env$data)
      )
    )
  }

  # mvt specific - assert field exists, populate limits from metadata
  if (is_tile_json(data)) {
    tidyassert::assert(
      has_tilejson_field(data, scale$col),
      "Scale column {.col {col}} doesn't exist in tilejson",
      print_expr = substitute(has_tilejson_field(data, expr$col)),
      col = scale$col
    )

    field_info <- get_tilejson_field(data, scale$col)
    tidyassert::assert(
      n_unique(field_info$type[!is.na(field_info$type)]) <= 1,
      "Field {.col {col}} has mixed types",
      col = scale$col
    )

    tidyassert::assert(
      !is.null(scale_limits$range) || !is_quantile_scale(scale),
      "Cannot compute quantiles from tilejson",
      print_expr = substitute(!is.null(expr$data) || !is_quantile_scale(expr))
    )

    if (is.null(scale_limits$range)) {
      scale_limits$train(
        if (is_category_scale(scale)) unlist(field_info$values) else c(field_info$min, field_info$max)
      )
    }

    return(
      mutate(
        scale,
        data_type = "geojson"
      )
    )
  }

  mutate(
    scale,
    data_type = data_type %||% resolve_data_type(.env$data)
  )
}

new_accessor <- function(col, data, data_type) {
  if (!is.null(data_type)) {
    tidyassert::assert(data_type %in% c("table", "object", "geojson"))
  }

  structure(
    list(
      col = col,
      data_type = data_type %||% resolve_data_type(data)
    ),
    class = "accessor"
  )
}

# object an accessor instance
is_accessor <- function(object) inherits(object, "accessor")

# select helper: match names of possible accessor
maybe_accessor <- function() {
  setdiff(tidyselect::starts_with("get_"), tidyselect::ends_with("_value"))
}

resolve_data_type <- function(data = NULL) {
  ifelse(is.null(data) | inherits(data, "data.frame"), "table", "object")
}

compile.data.frame <- function(object, sfc_dim = 2L, ...) {
  # how many features per sfg?
  sfc <- purrr::detect(object, is_sfc)
  feature_lengths <- if (!is.null(sfc)) get_feature_lengths(sfc)

  list(
    # number of features
    length = max(sum(feature_lengths), nrow(object)),
    lengths = if (max(feature_lengths, 0L) > 1L) feature_lengths,
    columns = purrr::map_if(object, is_sfc, function(x) get_coordinates(x, sfc_dim))
  )
}

# get column names used in layer parameters
get_used_colnames <- function(layer) {
  # cannot *easily* know which cols are referenced in js() accessors
  js_props <- select(layer, where(is_js_eval))
  if (!rlang::is_empty(js_props)) {
    rlang::warn(
      c(
        "!" = "Some properties are javascript expressions, cannot safely omit columns",
        rlang::set_names(names(js_props), "*")
      )
    )

    return(tidyselect::everything())
  }

  # any accessors with cur_value() -> unsafe to subset layer
  missing_accessors <- select(layer, maybe_accessor() & where(is_cur_value))
  if (!rlang::is_empty(missing_accessors)) {
    rlang::warn(
      c(
        "!" = "Some accessors are `cur_value()`, cannot safely omit columns from output",
        rlang::set_names(names(missing_accessors), "*")
      )
    )

    return(tidyselect::everything())
  }

  tooltip <- layer$tooltip
  tooltip_cols <- if (isTRUE(layer$pickable) && is_tooltip(tooltip)) tooltip$cols

  accessors <- select(unclass(layer), where(is_accessor), where(is_scale))
  accessor_cols <- vcapply(accessors, purrr::pluck, "col")

  unique(c(accessor_cols, tooltip_cols))
}

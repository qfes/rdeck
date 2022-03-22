layer_data <- function(layer) {
  UseMethod("layer_data")
}

layer_data.default <- function(layer) {
  if (!inherits(layer$data, "data.frame")) {
    return(layer$data)
  }

  data <- select(
    # avoid sticky-sf column
    as.data.frame(layer$data),
    get_colnames(layer)
  )

  list(
    length = nrow(data),
    geometry = geometry_types(data),
    frame = layer_df(data)
  )
}

layer_data.GeoJsonLayer <- function(layer) {
  if (!inherits(layer$data, "data.frame")) {
    return(layer$data)
  }

  data <- select(
    layer$data,
    # can have surplus from unused accessors
    tidyselect::any_of(get_colnames(layer)),
    attr(layer$data, "sf_column")
  )

  geojsonsf::sf_geojson(data, digits = 6L, simplify = FALSE)
}


layer_df <- function(data) {
  cols <- lapply(data, function(col) {
    if (!inherits(col, "sfc")) {
      return(col)
    }

    # avoid serialising as geojson
    if (!inherits(col, "sfc_POINT")) {
      return(
        lapply(col, unclass) %>%
          round_sfc()
      )
    }

    # performance optimisation for points
    sf::st_coordinates(col) %>%
      round_sfc()
  })

  lapply(cols, function(col) unname(I(col)))
}

round_sfc <- function(sfc, digits = 6L) {
  if (is.atomic(sfc)) round(sfc, digits) else lapply(sfc, round_sfc, digits)
}

get_colnames <- function(layer) {
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

geometry_types <- function(data) {
  lapply(
    select(data, where(is_sfc)),
    sf::st_geometry_type,
    by_geometry = FALSE
  )
}

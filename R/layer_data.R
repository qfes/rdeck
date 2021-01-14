layer_data <- function(layer) {
  UseMethod("layer_data")
}

layer_data.default <- function(layer) {
  if (!inherits(layer$data, "data.frame")) {
    return(layer$data)
  }

  data <- subset_data(layer)

  list(
    length = nrow(data),
    geometry = geometry_types(data),
    frame = layer_df(data)
  )
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

layer_data.GeoJsonLayer <- function(layer) {
  if (!inherits(layer$data, "data.frame")) {
    return(layer$data)
  }

  data <- subset_data(layer)
  geojsonsf::sf_geojson(data, digits = 6L, simplify = FALSE)
}

subset_data <- function(layer) {
  colnames <- get_colnames(layer)
  layer$data[colnames]
}

get_colnames <- function(layer) {
  tooltip <- layer$tooltip
  tooltip_cols <- if (layer$pickable && inherits(tooltip, "tooltip")) tooltip$cols

  # tooltip$cols == TRUE -> all names
  if (is.logical(tooltip_cols) && tooltip_cols) {
    return(names(layer$data))
  }

  js_props <- layer %>%
    vapply(function(p) inherits(p, "JS_EVAL"), logical(1), USE.NAMES = FALSE)
  # if any js() accessors, we cannot know what columns are referenced
  if (sum(js_props) != 0) {
    return(names(layer$data))
  }

  accessors <- layer %>%
    vapply(function(prop) inherits(prop, "accessor"), logical(1))

  # all cols in accessor props
  accessor_cols <- layer[accessors] %>%
    vapply(function(accessor) accessor$col, character(1), USE.NAMES = FALSE)

  unique(c(accessor_cols, tooltip_cols))
}

geometry_types <- function(data) {
  sfc_cols <- Filter(function(col) inherits(col, "sfc"), data)
  lapply(sfc_cols, sf::st_geometry_type, by_geometry = FALSE)
}

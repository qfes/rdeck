layer_data <- function(layer) {
  UseMethod("layer_data")
}

layer_data.default <- function(layer) {
  if (!inherits(layer$data, "data.frame")) {
    return(layer$data)
  }

  data <- subset_data(layer)

  # FIXME: this is not the right place
  if (inherits(data, "sf")) {
    data <- split_geometry(data)
  }

  list(
    length = nrow(data),
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
      return(lapply(col, unclass))
    }

    # performance optimisation for points
    coords <- sf::st_coordinates(col)
    colnames(coords) <- NULL
    coords
  })

  # HACK: apply data.frame json serialisation
  structure(cols, class = "data.frame")
}

layer_data.GeoJsonLayer <- function(layer) {
  data <- subset_data(layer)
  geojsonsf::sf_geojson(data, digits = 6L, simplify = FALSE)
}

subset_data <- function(layer) {
  colnames <- get_colnames(layer)
  layer$data[colnames]
}

get_colnames <- function(layer) {
  tooltip <- if (layer$pickable) layer$tooltip
  # if tooltip = TRUE, all cols
  if (is.logical(tooltip) && tooltip) {
    return(names(layer$data))
  }

  js_props <- layer %>%
    vapply(function(p) inherits(p, "JS_EVAL"), logical(1))
  # if any js() accessors, we cannot know what columns are referenced
  if (sum(js_props) != 0) return(names(layer$data))

  accessors <- layer %>%
    vapply(function(p) inherits(p, "accessor"), logical(1))

  # all cols in accessor props
  accessor_cols <- layer[accessors] %>%
    vapply(function(a) a$value, character(1), USE.NAMES = FALSE)

  unique(c(accessor_cols, tooltip))
}

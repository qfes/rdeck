layer_data <- function(layer) {
  UseMethod(layer)
}

layer_data.default <- function(layer) {
  if (!inherits(layer$data, "data.frame")) {
    return(layer$data)
  }

  data <- if (inherits(data, "sf")) split_geometry(layer$data) else layer$data

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
  stopifnot(inherits(layer$data, "sf"))
  geojsonsf::sf_geojson(layer, digits = 6L)
}

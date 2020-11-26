validate_data.layer <- function(layer) {
  data <- layer$data
  if (!is.null(data)) {
    assert_type(data, c("data.frame", "character"))
  }
}

validate_data.GeoJsonLayer <- function(layer) {
  data <- layer$data
  if (!is.null(data)) {
    assert_type(data, "sf")
  }
}

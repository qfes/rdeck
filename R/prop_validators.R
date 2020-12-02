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

validate_position_format.layer <- function(layer) {
  position_format <- layer$position_format
  assert_in(position_format, c("XYZ", "XY"))
}

validate_color_format.layer <- function(layer) {
  color_format <- layer$color_format
  assert_in(color_format, c("RGBA", "RGB"))
}

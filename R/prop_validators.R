# validate data
validate_data.layer <- function(layer) {
  data <- layer$data
  if (!is.null(data)) {
    assert_type(data, c("data.frame", "character"))
  }
}

validate_data.GeoJsonLayer <- function(layer) {
  data <- layer$data
  if (!is.null(data)) {
    assert_type(data, c("sf", "character"))
  }
}

assert_geom <- function(layer, name, sfc_type) {
  prop <- layer[[name]]
  assert_not_null(prop, name)
  assert_type(prop, "accessor", name)

  data <- layer$data
  if (inherits(data, "data.frame")) {
    col_expr <- paste0("data[[", name, "$col]]")
    assert_col_exists(prop$col, data)
    assert_type(data[[prop$col]], sfc_type, col_expr)
    assert_crs(data[[prop$col]], name = col_expr)
  }
}

# validate get_path
validate_get_path.layer <- function(layer) {
  assert_geom(layer, "get_path", "sfc_LINESTRING")
}

# validate get_polygon
validate_get_polygon.layer <- function(layer) {
  assert_geom(layer, "get_polygon", "sfc_POLYGON")
}

# validate get_position
validate_get_position.layer <- function(layer) {
  assert_geom(layer, "get_position", "sfc_POINT")
}

# validate get_source_position
validate_get_source_position.layer <- function(layer) {
  assert_geom(layer, "get_source_position", "sfc_POINT")
}

# validate get_target_position
validate_get_target_position.layer <- function(layer) {
  assert_geom(layer, "get_target_position", "sfc_POINT")
}

# validate position_format
validate_position_format.layer <- function(layer) {
  position_format <- layer$position_format
  assert_in(position_format, c("XYZ", "XY"))
}

# validate color_format
validate_color_format.layer <- function(layer) {
  color_format <- layer$color_format
  assert_in(color_format, c("RGBA", "RGB"))
}

assert_units <- function(value, name) {
  assert_is_string(value, name)
  assert_in(value, c("pixels", "meters"), name)
}

# validate width_units
validate_width_units.layer <- function(layer) {
  assert_units(layer$width_units, "width_units")
}

# validate size_units
validate_size_units.layer <- function(layer) {
  assert_units(layer$size_units, "size_units")
}

# validate line_width_units
validate_line_width_units.layer <- function(layer) {
  assert_units(layer$line_width_units, "line_width_units")
}

# validate point_radius_units
validate_point_radius_units.layer <- function(layer) {
  assert_units(layer$point_radius_units, "point_radius_units")
}

# validate radius_units
validate_radius_units.layer <- function(layer) {
  assert_units(layer$radius_units, "radius_units")
}

assert_aggregation <- function(value, name) {
  assert_is_string(value, string)
  assert_in(value, c("SUM", "MEAN", "MIN", "MAX"))
}

# validate aggregation
validate_aggregation.layer <- function(layer) {
  assert_aggregation(layer$aggregation, "aggregation")
}

# validate color_aggregation
validate_color_aggregation.layer <- function(layer) {
  assert_aggregation(layer$color_aggregation, "color_aggregation")
}

# validate elevation_aggregation
validate_elevation_aggregation.layer <- function(layer) {
  assert_aggregation(layer$elevation_aggregation, "elevation_aggregation")
}

assert_scale_type <- function(value, name) {
  assert_is_string(value, name)
  assert_in(value, c("quantize", "linear", "quantile", "ordinal"), name)
}

# validate color_scale_type
validate_color_scale_type <- function(layer) {
  assert_scale_type(layer$color_scale_type, "color_scale_type")
}

# validate elevation_scale_type
validate_elevation_scale_type <- function(layer) {
  assert_scale_type(layer$elevation_scale_type, "elevation_scale_type")
}

# validate get_tilt
validate_get_tilt.layer <- function(layer) {
  get_tilt <- layer$get_tilt
  assert_not_null(get_tilt)

  if (!inherits(get_tilt, "accessor")) {
    assert_type(get_tilt, c("integer", "numeric"))
    assert_finite(get_tilt)
    assert_scalar(get_tilt)
    assert_range(get_tilt, -90, 90)
    return()
  }

  assert_type(get_tilt, "accessor")
  data <- layer$data
  if (inherits(data, "data.frame")) {
    assert_col_exists(get_tilt$col, data)
    assert_type(data[[get_tilt$col]], c("integer", "numeric"))
    assert_finite(data[[get_tilt$col]])
    assert_range(get_tilt, -90, 90)
  }
}

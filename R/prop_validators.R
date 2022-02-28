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
  if (inherits(data, "data.frame") && nrow(data) != 0) {
    col_expr <- paste0("data[[", name, "$col]]")
    assert_col_exists(prop$col, data)
    assert_type(data[[prop$col]], sfc_type, col_expr)
    assert_crs(data[[prop$col]], name = col_expr)
  }
}

# validate id
validate_id <- function(layer) {
  assert_is_string(layer$id, "id")
}

# validate name
validate_name <- function(layer) {
  name <- layer$name
  if (!is.null(name)) {
    assert_is_string(name)
  }
}

# validate group_name
validate_group_name <- function(layer) {
  group_name <- layer$group_name
  if (!is.null(group_name)) {
    assert_is_string(group_name)
  }
}

# validate get_path
validate_get_path.layer <- function(layer) {
  assert_geom(layer, "get_path", c("sfc_LINESTRING", "sfc_MULTILINESTRING"))
}

# validate get_polygon
validate_get_polygon.layer <- function(layer) {
  assert_geom(layer, "get_polygon", c("sfc_POLYGON", "sfc_MULTIPOLYGON"))
}

# validate get_position
validate_get_position.layer <- function(layer) {
  assert_geom(layer, "get_position", c("sfc_POINT", "sfc_MULTIPOINT"))
}

# validate get_source_position
validate_get_source_position.layer <- function(layer) {
  assert_geom(layer, "get_source_position", c("sfc_POINT", "sfc_MULTIPOINT"))
}

# validate get_target_position
validate_get_target_position.layer <- function(layer) {
  assert_geom(layer, "get_target_position", c("sfc_POINT", "sfc_MULTIPOINT"))
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
  assert_in(value, c("pixels", "common", "meters"), name)
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
  assert_is_string(value, name)
  assert_in(value, c("SUM", "MEAN", "MIN", "MAX"), name)
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

# validate image
validate_image.layer <- function(layer) {
  if (!is.null(layer$image)) {
    assert_type(layer$image, c("character", "array"))
  }
}

# validate get_normal
validate_get_normal.layer <- function(layer) {
  get_normal <- layer$get_normal
  assert_type(get_normal, c("integer", "numeric", "accessor"))

  if (inherits(get_normal, c("integer", "numeric"))) {
    assert_length(get_normal, 3)
    return()
  }

  data <- layer$data
  if (inherits(data, "data.frame")) {
    assert_col_exists(get_normal$col, data)
    assert_type(data[[get_normal$col]], "matrix")
    if (ncol(data[[get_normal$col]]) != 3) {
      rlang::abort(
        "get_normal must be a matrix of 3 columns",
        "rdeck_error"
      )
    }
  }
}

# validate font_weight
validate_font_weight.layer <- function(layer) {
  font_weight <- layer$font_weight
  assert_type(font_weight, c("character", "integer", "numeric"))
  assert_scalar(font_weight)
  assert_in(font_weight, c("normal",  "bold", seq(100, 900, length.out = 9)))
}

# validate word_break
validate_word_break.layer <- function(layer) {
  word_break <- layer$word_break
  assert_is_string(word_break)
  assert_in(word_break, c("break-word", "break-all"))
}

# validate get_text_anchor
validate_get_text_anchor.layer <- function(layer) {
  get_text_anchor <- layer$get_text_anchor
  assert_not_null(get_text_anchor)
  assert_type(get_text_anchor, c("character", "accessor"))

  if (!inherits(get_text_anchor, "accessor")) {
    assert_is_string(get_text_anchor)
    assert_in(get_text_anchor, c("start", "middle", "end"))
    return()
  }

  data <- layer$data
  if (inherits(data, "data.frame")) {
    assert_col_exists(get_text_anchor$col, data)
    assert_type(data[[get_text_anchor$col]], "character")
    assert_in(data[[get_text_anchor$col]], c("start", "middle", "end"))
  }
}

# validate get_alignment_baseline
validate_get_alignment_baseline.layer <- function(layer) {
  get_alignment_baseline <- layer$get_alignment_baseline
  assert_not_null(get_alignment_baseline)
  assert_type(get_alignment_baseline, c("character", "accessor"))

  if (!inherits(get_alignment_baseline, "accessor")) {
    assert_is_string(get_alignment_baseline)
    assert_in(get_alignment_baseline, c("top", "center", "bottom"))
    return()
  }

  data <- layer$data
  if (inherits(data, "data.frame")) {
    assert_col_exists(get_alignment_baseline$col, data)
    assert_type(data[[get_alignment_baseline$col]], "character")
    assert_in(data[[get_alignment_baseline$col]], c("top", "center", "bottom"))
  }
}

# validate refinement_strategy
validate_refinement_strategy.layer <- function(layer) {
  refinement_strategy <- layer$refinement_strategy
  assert_is_string(refinement_strategy)
  assert_in(refinement_strategy, c("best-available", "no-overlap", "never"))
}

# validate high_precision
validate_high_precision.layer <- function(layer) {
  high_precision <- layer$high_precision
  assert_in(high_precision, c(TRUE, FALSE, "auto"))
}

# validate point_type
validate_point_type.layer <- function(layer) {
  # build vector of all point type combinations
  types <- c("circle", "icon", "text")
  grid <- expand.grid(z = types, y = types, x = types) %>%
    subset(x != y & x != z & y != z) %>%
    transform(
      pair = paste(x, y, sep = "+"),
      triple = paste(x, y, z, sep = "+")
    )

  all_types <- c(types, unique(grid$pair), grid$triple)

  point_type <- layer$point_type
  assert_in(point_type, all_types)
}

# validate blending_mode
validate_blending_mode <- function(layer) {
  assert_is_string(layer$blending_mode, "blending_mode")
  assert_in(layer$blending_mode, c("normal", "additive", "subtractive"), "blending_mode")
}

# validate visibility_toggle
validate_visibility_toggle <- function(layer) {
  visibility_toggle <- layer$visibility_toggle
  assert_type(visibility_toggle, "logical")
  assert_scalar(visibility_toggle)
}

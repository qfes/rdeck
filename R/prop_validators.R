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

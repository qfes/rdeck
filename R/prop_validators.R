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

# validate high_precision
validate_high_precision.layer <- function(layer) {
  high_precision <- layer$high_precision
  tidyassert::assert(!is.null(high_precision))
  tidyassert::assert(
    (is.character(high_precision) && high_precision == "auto" ||
    is.logical(high_precision) && high_precision %in% c(TRUE, FALSE)) && length(high_precision) == 1,
    c("x" = "{.arg {name}} must be TRUE, FALSE, or \"auto\""),
    name = "high_precision"
  )
}

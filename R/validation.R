# validate data
validate_data.layer <- function(layer) {
  data <- layer$data
  if (!is.null(data)) {
    tidyassert::assert_inherits(data, c("data.frame", "character"))
  }
}

validate_data.GeoJsonLayer <- function(layer) {
  data <- layer$data
  if (!is.null(data)) {
    tidyassert::assert_inherits(data, c("sf", "character"))
  }
}

validate_geometry_accessor <- function(layer, name, sfc_type) {
  prop <- layer[[name]]
  tidyassert::assert(
    !is.null(prop) && inherits(prop, "accessor"),
    "{.arg {name}} must be a {.cls column accessor}",
    name = name
  )

  data <- layer$data
  if (inherits(data, "data.frame") && nrow(data) != 0) {
    accessor_data <- data[[tidyselect::eval_select(prop$col, data)]]
    tidyassert::assert(
      inherits(accessor_data, sfc_type) && sf::st_crs(accessor_data) == sf::st_crs(4326),
      c("x" = "Column {.col {col}} is invalid for accessor {.arg {name}}; it must be a {.cls {type}} vector, with crs 4326"),
      name = name,
      col = prop$col,
      type = sfc_type
    )
  }
}

# validate get_path
validate_get_path.layer <- function(layer) {
  validate_geometry_accessor(layer, "get_path", c("sfc_LINESTRING", "sfc_MULTILINESTRING"))
}

# validate get_polygon
validate_get_polygon.layer <- function(layer) {
  validate_geometry_accessor(layer, "get_polygon", c("sfc_POLYGON", "sfc_MULTIPOLYGON"))
}

# validate get_position
validate_get_position.layer <- function(layer) {
  validate_geometry_accessor(layer, "get_position", c("sfc_POINT", "sfc_MULTIPOINT"))
}

# validate get_source_position
validate_get_source_position.layer <- function(layer) {
  validate_geometry_accessor(layer, "get_source_position", c("sfc_POINT", "sfc_MULTIPOINT"))
}

# validate get_target_position
validate_get_target_position.layer <- function(layer) {
  validate_geometry_accessor(layer, "get_target_position", c("sfc_POINT", "sfc_MULTIPOINT"))
}

# validate image
validate_image.layer <- function(layer) {
  if (!is.null(layer$image)) {
    tidyassert::assert_inherits(layer$image, c("character", "array"))
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
  tidyassert::assert(
    rlang::is_string(point_type) && point_type %in% all_types,
    c("x" = "{.arg point_type} must be one of {.val {types}}, or a combination joined by {.val +}"),
    types = types
  )
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

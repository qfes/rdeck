check_dots <- function(...) {
  dots <- rlang::dots_list(...)
  dots_names <- names(dots)

  if (!all(nzchar(dots_names))) {
    rlang::abort(
      paste0("All dots must be named."),
      class = "rdeck_dots_unnamed"
    )
  }

  tidyassert::warn_if(
    length(dots) != 0,
    c(
      "i" = "These dots are unrecognised arguments that will be forwarded to Deck.GL javascript:",
      paste0("`", dots_names, "` -> `", to_camel_case(dots_names), "`")
    )
  )
}

check_dots_access_token <- function(...) {
  dots <- rlang::dots_list(...)
  dots_names <- names(dots)

  var_names <- c("MAPBOX_ACCESS_TOKEN", "MAPBOX_TOKEN")
  tidyassert::warn_if(
    any(dots_names == "mapbox_access_token"),
    c(
      "i" = "mapbox_access_token should be supplied via one of:",
      "`options(rdeck.mapbox_access_token)`",
      paste0("environment variable `", var_names, " = <token>`"),
      " " = "",
      "i" = "see {.code ?mapbox_access_token}"
    )
  )
}

# validate data
#' @export
validate_data.layer <- function(layer) {
  data <- layer$data
  if (is_cur_value(data)) return()

  if (!is.null(data)) {
    tidyassert::assert_inherits(data, c("data.frame", "character"))
  }
}

#' @export
validate_data.GeoJsonLayer <- function(layer) {
  data <- layer$data
  if (is_cur_value(data)) return()

  if (!is.null(data)) {
    tidyassert::assert(
      inherits(data, "data.frame") && wk::is_handleable(data)
        || rlang::is_string(data, "character"),
      "{.arg data} must be a {.cls dataframe} with a geometry column, an {.cls sf} object, or a {.cls string}",
    )
  }
}

#' @export
validate_data.MVTLayer <- function(layer) {
  data <- layer$data
  if (is_cur_value(data)) return()

  if (!is.null(data)) {
    tidyassert::assert_inherits(data, c("character", "tile_json"))
  }
}

validate_geometry_accessor <- function(layer, name, geom_type) {
  prop <- layer[[name]]
  if (is_cur_value(prop)) return()

  tidyassert::assert(
    !is.null(prop) && inherits(prop, "accessor"),
    "{.arg {name}} must be a {.cls column accessor}",
    name = name
  )

  data <- layer$data
  if (inherits(data, "data.frame") && nrow(data) != 0) {
    vec <- data[[tidyselect::eval_select(prop$col, data)]]
    tidyassert::assert(
      wk_is(vec, geom_type) && is_wgs84(vec),
      c(
        "x" = "Column {.col {col}} is invalid for accessor {.arg {name}}",
        "x" = "A {.emph WGS84} {.cls {type}} geometry vector expected"
      ),
      call = rlang::caller_call(),
      # prettier assertion expression
      print_expr = substitute(
        wk_is(data$col, geom_type) && is_wgs84(data$col),
        list(col = prop$col, geom_type = geom_type)
      ),
      name = name,
      col = prop$col,
      type = wk::wk_geometry_type_label(geom_type)
    )
  }
}

# validate get_path
#' @export
validate_get_path.layer <- function(layer) {
  validate_geometry_accessor(
    layer,
    "get_path",
    wk::wk_geometry_type(c("linestring", "multilinestring"))
  )
}

# validate get_polygon
#' @export
validate_get_polygon.layer <- function(layer) {
  validate_geometry_accessor(
    layer,
    "get_polygon",
    wk::wk_geometry_type(c("polygon", "multipolygon"))
  )
}

# validate get_position
#' @export
validate_get_position.layer <- function(layer) {
  validate_geometry_accessor(
    layer,
    "get_position",
    wk::wk_geometry_type(c("point", "multipoint"))
  )
}

# validate get_source_position
#' @export
validate_get_source_position.layer <- function(layer) {
  validate_geometry_accessor(
    layer,
    "get_source_position",
    wk::wk_geometry_type(c("point", "multipoint"))
  )
}

# validate get_target_position
#' @export
validate_get_target_position.layer <- function(layer) {
  validate_geometry_accessor(
    layer,
    "get_target_position",
    wk::wk_geometry_type(c("point", "multipoint"))
  )
}

# validate image
#' @export
validate_image.layer <- function(layer) {
  image <- layer$image
  if (is_cur_value(image)) return()

  if (!is.null(image)) {
    tidyassert::assert_inherits(image, c("character", "array"))
  }
}

#' @export
validate_get_icon.GeoJsonLayer <- function(layer) {
  if (grepl("icon", layer$point_type, fixed = TRUE) %??% TRUE) {
    NextMethod()
  }
}

#' @export
validate_get_text.GeoJsonLayer <- function(layer) {
  if (grepl("text", layer$point_type, fixed = TRUE) %??% TRUE) {
    NextMethod()
  }
}

#' validate point_type
#' @autoglobal
#' @noRd
#' @export
validate_point_type.layer <- function(layer) {
  point_type <- layer$point_type
  if (is_cur_value(point_type)) return()

  # build vector of all point type combinations
  types <- c("circle", "icon", "text")
  grid <- expand.grid(z = types, y = types, x = types) %>%
    subset(x != y & x != z & y != z) %>%
    transform(
      pair = paste(x, y, sep = "+"),
      triple = paste(x, y, z, sep = "+")
    )

  all_types <- c(types, unique(grid$pair), grid$triple)
  tidyassert::assert(
    rlang::is_string(point_type) && point_type %in% all_types,
    c("x" = "{.arg point_type} must be one of {.val {types}}, or a combination joined by {.val +}"),
    types = types
  )
}

# validate high_precision
#' @export
validate_high_precision.layer <- function(layer) {
  high_precision <- layer$high_precision
  if (is_cur_value(high_precision)) return()

  tidyassert::assert(!is.null(high_precision))
  tidyassert::assert(
    (is.character(high_precision) && high_precision == "auto" ||
      is.logical(high_precision) && high_precision %in% c(TRUE, FALSE)) && length(high_precision) == 1,
    c("x" = "{.arg {name}} must be TRUE, FALSE, or \"auto\""),
    name = "high_precision"
  )
}

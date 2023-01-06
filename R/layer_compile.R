#' @export
compile.Layer <- function(object, ...) {
  mutate(
    object,
    data = compile_data(data, .env$object)
  )
}

compile.layer <- compile.Layer

#' @autoglobal
#' @export
compile.BitmapLayer <- function(object, ...) {
  mutate(
    object,
    data = compile_data(data, .env$object),
    image = if (inherits(image, "array")) as_png(image) else image
  )
}

#' @autoglobal
#' @export
compile.IconLayer <- function(object, ...) {
  mutate(
    object,
    data = compile_data(data, .env$object),
    icon_atlas = if (inherits(icon_atlas, "array")) as_png(icon_atlas) else icon_atlas
  )
}

compile_data <- function(data, layer) {
  UseMethod("compile_data")
}

compile_data.default <- function(object, layer) object

compile_data.data.frame <- function(object, layer) {
  data <- select(
    unclass(object),
    # keep used columns
    tidyselect::any_of(get_used_colnames(.env$layer))
  )

  # how many features per sfg?
  sfc <- purrr::detect(data, is_sfc)
  feature_lengths <- if (!is.null(sfc)) get_feature_lengths(sfc)

  # size of each coordinate
  dim <- nchar(layer$position_format)

  structure(
    list(
      # number of features
      length = max(sum(feature_lengths), nrow(object)),
      lengths = if (max(feature_lengths, 0L) > 1L) feature_lengths,
      columns = purrr::map_if(data, is_sfc, function(x) get_coordinates(x, dim))
    ),
    # attrs for json_serialiser
    sf_columns = names(data)[vlapply(data, is_sfc)],
    class = "layer_table"
  )
}

compile_data.sf <- function(object, layer) {
  if (!inherits(layer, "GeoJsonLayer")) {
    return(compile_data(as.data.frame(object), layer))
  }

  select(
    object,
    # not relying on sticky-geoms
    attr(.env$object, "sf_column"),
    # keep used columns
    tidyselect::any_of(get_used_colnames(.env$layer))
  )
}

# get column names used in layer parameters
get_used_colnames <- function(layer) {
  # cannot *easily* know which cols are referenced in js() accessors
  js_props <- select(layer, where(is_js_eval))
  if (!rlang::is_empty(js_props)) {
    rlang::warn(
      c(
        "!" = "Some properties are javascript expressions, cannot safely omit columns",
        rlang::set_names(names(js_props), "*")
      )
    )

    return(tidyselect::everything())
  }

  # any accessors with cur_value() -> unsafe to subset layer
  missing_accessors <- select(layer, maybe_accessor() & where(is_cur_value))
  if (!rlang::is_empty(missing_accessors)) {
    rlang::warn(
      c(
        "!" = "Some accessors are `cur_value()`, cannot safely omit columns from output",
        rlang::set_names(names(missing_accessors), "*")
      )
    )

    return(tidyselect::everything())
  }

  tooltip <- layer$tooltip
  tooltip_cols <- if (isTRUE(layer$pickable) && is_tooltip(tooltip)) tooltip$cols

  accessors <- select(unclass(layer), where(is_accessor), where(is_scale))
  accessor_cols <- vcapply(accessors, purrr::pluck, "col")

  unique(c(accessor_cols, tooltip_cols))
}

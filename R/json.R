
#' To JSON
#'
#' Modify `obj` for JSON serialisation.
#'
#' @keywords internal
#' @noRd
to_json <- function(obj) {
  UseMethod("to_json")
}

to_json.default <- function(obj) {
  # remove names from vectors
  if (is.vector(obj) && !is.null(names(obj))) as.vector(obj) else obj
}

to_json.list <- function(obj) {
  obj_json <- structure(
    lapply(obj, function(p) to_json(p)),
    class = class(obj)
  )

  mostattributes(obj_json) <- attributes(obj)
  obj_json
}

camel_case <- function(obj) {
  obj_names <- names(obj)
  names(obj) <- to_camel_case(names(obj))
  to_json.list(obj)
}

to_json.layer <- function(obj) {
  if (!is.null(obj$data)) {
    obj$data <- layer_data(obj)
  }

  # base64 encode image data
  if (!is.null(obj$image) && inherits(obj$image, "array")) {
    b64_image <- base64enc::base64encode(png::writePNG(obj$image))
    obj$image <- paste0("data:image/png;base64,", b64_image)
  }

  camel_case(obj)
}

to_json.rdeck <- to_json.list
to_json.rdeck_data <- camel_case
to_json.rdeck_props <- camel_case
to_json.view_state <- camel_case
to_json.bbox <- function(obj) as.vector(obj)

to_json.accessor <- function(obj) {
  utils::modifyList(
    camel_case(obj),
    list(type = "accessor"),
    keep.null = TRUE
  )
}

#' @autoglobal
#' @noRd
to_json.scale <- function(obj) {
  compiled <- mutate(
    compile(obj),
    type = jsonlite::unbox("accessor"),
    scale_type = jsonlite::unbox(scale_type),
    col = jsonlite::unbox(col),
    data_type = jsonlite::unbox(data_type),
    legend = jsonlite::unbox(legend),
    unknown = jsonlite::unbox(unknown),

    # may not exist
    unknown_tick = if (rlang::has_name(.data, "unknown_tick")) jsonlite::unbox(unknown_tick),
    base = if (scale_type == "log") jsonlite::unbox(base),
    exponent = if (scale_type == "power") jsonlite::unbox(exponent)
  )

  # FIXME: rename scale -> scaleType in typescript
  compiled <- rename(compiled, scale = scale_type)

  jsonlite::toJSON(
    select(camel_case(compiled), -where(is.null)),
    digits = 15,
    use_signif = TRUE
  )
}

to_json.scale_color <- function(obj) {
  is_category <- obj$scale_type == "category"

  obj <- rename(
    obj,
    unknown = ifelse(is_category, "unmapped_color", "na_color"),
    unknown_tick = if (rlang::has_name(.data, "unmapped_tick")) "unmapped_tick"
  )

  NextMethod()
}

to_json.scale_numeric <- function(obj) {
  is_category <- obj$scale_type == "category"

  obj <- rename(
    obj,
    unknown = ifelse(is_category, "unmapped_value", "na_value")
  )

  NextMethod()
}

to_json.tooltip <- function(obj) {
  # true can be simplified, names cannot
  cols <- if (is.logical(obj$cols)) obj$cols else I(obj$cols)

  utils::modifyList(
    camel_case(obj),
    list(
      type = "tooltip",
      cols = cols
    ),
    keep.null = TRUE
  )
}

to_camel_case <- function(string) {
  # preserve _ prefix
  prefix <- ifelse(startsWith(string, "_"), "_", "")
  snakecase::to_lower_camel_case(string, prefix = prefix)
}

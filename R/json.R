
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

to_json.scale <- function(obj) {
  compiled <- compile(obj)
  compiled <- purrr::list_modify(
    compiled,
    type = jsonlite::unbox("accessor"),
    scale_type = jsonlite::unbox(compiled$scale_type),
    col = jsonlite::unbox(compiled$col),
    data_type = jsonlite::unbox(compiled$data_type),
    base = jsonlite::unbox(compiled$base),
    exponent = jsonlite::unbox(compiled$exponent),
    legend = jsonlite::unbox(compiled$legend),
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
  obj <- purrr::list_modify(
    select(obj, -tidyselect::ends_with("_color"), -tidyselect::ends_with("_tick")),
    unknown = jsonlite::unbox(obj$na_color %||% obj$unmapped_color),
    unknown_tick = jsonlite::unbox(obj$unknown_tick %||% obj$unmapped_tick)
  )

  NextMethod()
}

to_json.scale_numeric <- function(obj) {
  obj <- purrr::list_modify(
    select(obj, -tidyselect::ends_with("_value")),
    unknown = jsonlite::unbox(obj$na_value %||% obj$unmapped_value)
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

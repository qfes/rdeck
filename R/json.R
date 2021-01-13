
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

to_json.rdeck <- to_json.list

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

to_json.accessor_scale <- function(obj) {
  # prevent simplification
  names_ <- names(obj)
  obj$domain <- I(obj$domain)
  if ("palette" %in% names_) obj$palette <- I(obj$palette)
  if ("range" %in% names_) obj$range <- I(obj$range)
  if ("ticks" %in% names_) obj$ticks <- I(obj$ticks)

  # get unknown value
  obj$unknown <- obj$na_color %||% obj$na_value %||% obj$unmapped_color %||% obj$unmapped_value

  keep <- c(
    "col", "data_type",
    "scale", "domain", "range",
    "palette", "unknown",
    "exponent", "base",
    "ticks", "legend"
  )
  obj <- pick(obj, keep)

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

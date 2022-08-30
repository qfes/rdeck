#' @export
rescale_center <- function(scale, center = 0) {
  UseMethod("rescale_center")
}

#' @export
rescale_center.scale_color_category <- function(scale, center) {
  rescale_not_supported("rescale_center()", scale$scale_type)
  scale
}

#' @export
rescale_center.scale_numeric_category <- rescale_center.scale_color_category

#' @export
rescale_center.scale_color <- function(scale, center = 0) {
  get_palette <- scale$get_palette

  scale$get_palette <- function(x) {
    xmid <- rescale_ramp(scale, center)
    ramp <- scales::rescale_mid(x, mid = xmid)
    get_palette(ramp)
  }

  scale
}

#' @export
rescale_center.scale_numeric <- function(scale, center = 0) {
  get_range <- scale$get_range

  scale$get_range <- function(x) {
    xmid <- rescale_ramp(scale, center)
    ramp <- scales::rescale_mid(x, mid = xmid)
    get_range(ramp)
  }

  scale
}

rescale_ramp <- function(scale, x) {
  limits <- (scale$limits %||% scale$data)$range
  tidyassert::assert(x >= limits[1] & x <= limits[2])

  # use transform if available
  trans <- attr(scale$get_breaks, "trans")
  if (!is.null(trans)) {
    scales::rescale(trans$transform(x), from = trans$transform(limits))
  # approximate function from breaks
  } else {
    breaks <- scale$get_breaks(limits)
    rescale <- splinefun(breaks, seq.int(0, 1, length.out = length(breaks)))
    rescale(x)
  }
}

rescale_not_supported <- function(rescale_fn, scale_type) {
  rlang::abort(
    paste(rescale_fn, "doesn't handle", scale_type, "scales."),
    class = "rdeck_warning"
  )
}

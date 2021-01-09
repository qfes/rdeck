scale_ticks <- function(scale) {
  UseMethod("scale_ticks")
}

scale_ticks.scale_linear <- function(scale) {
  ticks(scale$n_ticks, scale$limits, scale$breaks) %>%
    format_ticks(scale$tick_format)
}

scale_ticks.scale_power <- function(scale) {
  trans <- function(x) x^scale$exponent
  invert <- function(x) x^(1 / scale$exponent)

  ticks(scale$n_ticks, trans(scale$limits), trans(scale$breaks)) %>%
    invert() %>%
    format_ticks(scale$tick_format)
}

scale_ticks.scale_log <- function(scale) {
  trans <- function(x) log(x, scale$base)
  invert <- function(x) scale$base^x

  ticks(scale$n_ticks, trans(scale$limits), trans(scale$breaks)) %>%
    invert() %>%
    format_ticks(scale$tick_format)
}

scale_ticks.scale_threshold <- function(scale) {
  c(scale$limits[1], scale$domain, scale$limits[2]) %>%
    format_ticks(scale$tick_format)
}

scale_ticks.scale_quantile <- scale_ticks.scale_threshold

scale_ticks.scale_quantize <- function(scale) {
  ticks(length(scale$palette %||% scale$range) + 1, scale$domain) %>%
    format_ticks(scale$tick_format)
}

scale_ticks.scale_category <- function(scale) {
  format_ticks(scale$domain, scale$tick_format)
}

ticks <- function(length, limits, breaks = NULL) {
  if (is.null(breaks)) {
    seq(limits[1], limits[2], length.out = as.integer(length))
  } else {
    stats::approx(c(limits[1], breaks, limits[2]), n = length)$y
  }
}

format_ticks <- function(ticks, tick_format) {
  if (is.null(tick_format)) {
    return(ticks)
  }

  formatted_ticks <- tick_format(ticks)
  # tick_format should return a character vector of n_ticks length
  assert_type(formatted_ticks, "character")
  if (length(formatted_ticks) != length(ticks)) {
    rlang::abort(
      paste0("length(formatted_ticks) must equal length(ticks)"),
      "rdeck_error"
    )
  }

  formatted_ticks
}

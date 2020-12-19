scale_ticks <- function(scale) {
  UseMethod("scale_ticks")
}

scale_ticks.scale_linear <- function(scale) {
  ticks(scale$limits, scale$n_ticks) %>%
    format_ticks(scale$tick_format)
}

scale_ticks.scale_power <- function(scale) {
  trans <- function(x) x^scale$exponent
  invert <- function(x) x^(1 / scale$exponent)

  ticks(trans(scale$limits), scale$n_ticks) %>%
    invert() %>%
    format_ticks(scale$tick_format)
}

scale_ticks.scale_log <- function(scale) {
  trans <- function(x) log(x, scale$base)
  invert <- function(x) scale$base^x

  ticks(trans(scale$limits), scale$n_ticks) %>%
    invert() %>%
    format_ticks(scale$tick_format)
}

scale_ticks.scale_threshold <- function(scale) {
  c(scale$limits[1], scale$domain, scale$limits[2]) %>%
    format_ticks(scale$tick_format)
}

scale_ticks.scale_quantile <- scale_ticks.scale_threshold

scale_ticks.scale_quantize <- function(scale) {
  ticks(scale$domain, length(scale$palette %||% scale$range) + 1) %>%
    format_ticks(scale$tick_format)
}

scale_ticks.scale_category <- function(scale) {
  format_ticks(scale$domain, scale$tick_format)
}

ticks <- function(limits, length, tick_format) {
  seq(limits[1], limits[2], length.out = as.integer(length))
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

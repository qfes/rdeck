scale_ticks <- function(scale) {
  UseMethod("scale_ticks")
}

scale_ticks.scale_linear <- function(scale) {
  ticks(scale$limits, scale$n_ticks)
}

scale_ticks.scale_power <- function(scale) {
  trans <- function(x) x^scale$exponent
  invert <- function(x) x^(1 / scale$exponent)

  ticks(trans(scale$limits), scale$n_ticks) %>%
    invert()
}

scale_ticks.scale_log <- function(scale) {
  trans <- function(x) log(x, scale$base)
  invert <- function(x) scale$base^x

  ticks(trans(scale$limits), scale$n_ticks) %>%
    invert()
}

scale_ticks.scale_threshold <- function(scale) {
  c(scale$limits[1], scale$domain, scale$limits[2])
}

scale_ticks.scale_quantile <- scale_ticks.scale_threshold

scale_ticks.scale_quantize <- function(scale) {
  ticks(scale$domain, length(scale$palette %||% scale$range) + 1)
}

ticks <- function(limits, length) {
  seq(limits[1], limits[2], length.out = length)
}

scale_domain <- function(scale, data) {
  UseMethod("scale_domain")
}

scale_domain.default <- function(scale, data) {
  domain(data, domain_length(scale$range))
}

scale_domain.scale_quantize <- function(scale, data) {
  c(min(data, na.rm = TRUE), max(data, na.rm = TRUE))
}

scale_domain.scale_log <- function(scale, data) {
  invert <- function(x) scale$base^x

  domain(
    log(data, scale$base),
    domain_length(scale$range)
  ) %>%
    invert()
}

scale_domain.scale_power <- function(scale, data) {
  invert <- function(x) x^(1 / scale$exponent)

  domain(
    data^scale$exponent,
    domain_length(scale$range)
  ) %>%
    invert()
}

domain_length <- function(range) {
  ifelse(is.matrix(range), nrow(range), length(range))
}

domain <- function(data, length) {
  seq(min(data, na.rm = TRUE), max(data, na.rm = TRUE), length.out = length)
}

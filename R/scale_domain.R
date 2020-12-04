scale_domain <- function(scale, data = NULL) {
  UseMethod("scale_domain")
}

scale_domain.scale_linear <- function(scale, data = NULL) {
  range_len <- length(scale$palette %||% scale$range)
  continuous_domain(scale$limits, scale$breaks, range_len)
}

scale_domain.scale_power <- function(scale, data = NULL) {
  trans <- function(x) x^scale$exponent
  invert <- function(x) x^(1 / scale$exponent)

  range_len <- length(scale$palette %||% scale$range)
  trans_limits <- trans(scale$limits)
  trans_breaks <- if (!is.null(scale$breaks)) trans(scale$breaks)
  domain <- continuous_domain(trans_limits, trans_breaks, range_len)
  invert(domain)
}

scale_domain.scale_log <- function(scale, data = NULL) {
  trans <- function(x) log(x, scale$base)
  invert <- function(x) scale$base^x

  range_len <- length(scale$palette %||% scale$range)
  trans_limits <- trans(scale$limits)
  trans_breaks <- if (!is.null(scale$breaks)) trans(scale$breaks)
  domain <- continuous_domain(trans_limits, trans_breaks, range_len)
  invert(domain)
}

scale_domain.scale_threshold <- function(scale, data) scale$breaks

scale_domain.scale_quantile <- function(scale, data = NULL) {
  assert_type(data, "data.frame")
  col <- data[[scale$col]]

  # compute the quantile breaks
  n_breaks <- length(scale$palette %||% scale$range) - 1
  breaks <- seq(0, 1, length.out = n_breaks + 2)[seq_len(n_breaks) + 1]

  quantile(col, probs = breaks, na.rm = TRUE, names = FALSE)
}

scale_domain.scale_category <- function(scale, data) {
  if (!inherits(data, "data.frame")) {
    assert_not_null(scale$levels)
  }

  levels_ <- scale$levels %||% data[[scale$col]]
  scale$levels <- levels(levels_) %||% unique(levels_)

  assert_length(scale$levels, length(scale$palette %||% scale$range), name = "levels")
  scale$levels
}

scale_domain.scale_quantize <- function(scale, data) scale$limits

continuous_domain <- function(limits, breaks = NULL, length) {
  if (is.null(breaks)) {
    seq(limits[1], limits[2], length.out = length)
  } else {
    c(limits[1], breaks, limits[2])
  }
}

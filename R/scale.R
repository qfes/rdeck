#' Linear Scale
#'
#' @name scale_linear
#' @inheritParams scale
#'
#' @family scales
#' @export
scale_linear <- function(domain = NULL, range = c(0, 1), value, legend = TRUE) {
  value <- substitute(value) %>% {
    ifelse(is.name(.), deparse(., backtick = FALSE), value)
  }

  stopifnot(
    is.character(value) && length(value) == 1,
    is.null(domain) || length(domain) != length(range)
  )

  scale(
    type = "linear",
    domain = domain,
    range = range,
    value = value,
    legend = legend
  )
}

#' Power Scale
#'
#' @name scale_power
#' @param exponent
#' @inheritParams scale
#'
#' @family scales
#' @export
scale_power <- function(domain = NULL, range = c(0, 1), exponent = 1, value, legend = TRUE) {
  value <- substitute(value) %>% {
    ifelse(is.name(.), deparse(., backtick = FALSE), value)
  }

  stopifnot(
    is.character(value) && length(value) == 1,
    is.null(domain) || length(domain) == length(range)
  )

  scale(
    type = "power",
    domain = domain,
    range = range,
    value = value,
    legend = legend,
    exponent = exponent
  )
}

#' Log Scale
#'
#' @name scale_log
#' @inheritParams scale
#'
#' @family scales
#' @export
scale_log <- function(domain = NULL, range = c(0, 1), base = 10, value, legend = TRUE) {
  value <- substitute(value) %>% {
    ifelse(is.name(.), deparse(., backtick = FALSE), value)
  }

  stopifnot(
    is.character(value) && length(value) == 1,
    is.null(domain) || length(domain) == length(range)
  )

  scale(
    type = "log",
    domain = domain,
    range = range,
    value = value,
    legend = legend,
    base = base
  )
}

#' Quantize Scale
#'
#' @name scale_quantize
#' @inheritParams scale
#'
#' @family scales
#' @export
scale_quantize <- function(domain = NULL, range = c(0, 1), value, legend = TRUE) {
  value <- substitute(value) %>% {
    ifelse(is.name(.), deparse(., backtick = FALSE), value)
  }

  stopifnot(
    is.character(value) && length(value) == 1,
    is.null(domain) || length(domain) == 2
  )

  scale(
    type = "quantize",
    domain = domain,
    range = range,
    value = value,
    legend = legend
  )
}

#' Quantile Scale
#'
#' @name scale_quantile
#' @inheritParams scale
#'
#' @family scales
#' @export
scale_quantile <- function(range = c(0, 1), value, legend = TRUE) {
  value <- substitute(value) %>% {
    ifelse(is.name(.), deparse(., backtick = FALSE), value)
  }

  stopifnot(
    is.character(value) && length(value) == 1
  )

  scale(
    type = "quantile",
    range = range,
    value = value,
    legend = legend
  )
}

#' @name scale
#' @param type
#' @param domain
#' @param range
#' @param value
#' @param legend
#' @param ...
#' @family scales
#' @keywords internal
scale <- function(type,
                  domain = NULL,
                  range = c(0, 1),
                  value,
                  legend = TRUE,
                  ...) {
  properties <- c(
    list(
      type = type,
      domain = domain,
      range = range,
      value = value,
      legend = legend
    ),
    list(...)
  )

  structure(
    properties,
    class = c("scale", paste0("scale_", type))
  )
}

scale_domain <- function(scale, data) {
  UseMethod("scale_domain")
}

scale_domain.default <- function(scale, data) {
  domain(data, domain_length(scale$range))
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

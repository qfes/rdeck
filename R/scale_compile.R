#' @export
compile.scale_color <- function(object, ...) {
  tidyassert::assert_not_null(object$limits$range)

  scale <- mutate(
    unclass(object),
    domain = get_breaks(limits$range),
    palette = get_palette(ramp_n(length(domain))),
    ticks = get_ticks(limits$range) %>%
      tick_format()
  )

  select(scale, where(is.atomic))
}

#' @export
compile.scale_numeric <- function(object, ...) {
  tidyassert::assert_not_null(object$limits$range)

  scale <- mutate(
    unclass(object),
    domain = get_breaks(limits$range),
    range = get_range(ramp_n(length(domain)))
  )

  select(scale, where(is.atomic))
}


#' @export
compile.scale_color_threshold <- function(object, ...) {
  scale <- mutate(
    unclass(object),
    # d3 threshold domain excludes limits
    domain = get_breaks(limits$range) %>%
      drop_ends(),
    palette = get_palette(ramp_n(length(domain) + 1)),
    ticks = get_ticks(limits$range) %>%
      tick_format()
  )

  tidyassert::warn_if(length(scale$domain) == 0, "domain is empty, scale will be constant")
  select(scale, where(is.atomic))
}

#' @export
compile.scale_numeric_threshold <- function(object, ...) {
  scale <- mutate(
    unclass(object),
    # d3 threshold domain excludes limits
    domain = get_breaks(limits$range) %>%
      drop_ends(),
    range = get_range(ramp_n(length(domain) + 1))
  )

  tidyassert::warn_if(length(scale$domain) == 0, "domain is empty, scale will be constant")
  select(scale, where(is.atomic))
}


#' @export
compile.scale_color_quantile <- function(object, ...) {
  tidyassert::assert_not_null(object$data$range)

  # 'convert' to threshold scale
  object <- mutate(
    rename(object, limits = data),
    scale_type = "threshold"
  )

  compile.scale_color_threshold(object)
}

#' @export
compile.scale_numeric_quantile <- function(object, ...) {
  tidyassert::assert_not_null(object$data$range)

  # 'convert' to threshold scale
  object <- mutate(
    rename(object, limits = data),
    scale_type = "threshold"
  )

  compile.scale_numeric_threshold(object)
}


#' @export
compile.scale_color_category <- function(object, ...) {
  tidyassert::assert_not_null(object$levels$range)

  scale <- mutate(
    unclass(object),
    domain = levels$range,
    palette = get_palette(domain),
    ticks = tick_format(domain)
  )

  select(scale, where(is.atomic))
}

#' @export
compile.scale_numeric_category <- function(object, ...) {
  tidyassert::assert_not_null(object$levels$range)

  scale <- mutate(
    unclass(object),
    domain = levels$range,
    range = get_range(domain)
  )

  select(scale, where(is.atomic))
}


#' @export
compile.scale_color_quantize <- function(object, ...) {
  tidyassert::assert_not_null(object$limits$range)

  scale <- mutate(
    unclass(object),
    domain = limits$range,
    palette = get_palette(get_breaks(0:1)),
    ticks = get_ticks(domain) %>%
      tick_format()
  )

  select(scale, where(is.atomic))
}

#' @export
compile.scale_numeric_quantize <- function(object, ...) {
  tidyassert::assert_not_null(object$limits$range)

  scale <- mutate(
    unclass(object),
    domain = limits$range,
    range = get_range(get_breaks(0:1))
  )

  select(scale, where(is.atomic))
}

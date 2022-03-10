#' @export
compile.scale_color <- function(object, ...) {
  tidyassert::assert_not_null(object$limits$range)

  limits <- object$limits$range
  domain <- object$get_breaks(limits)
  ramp <- seq.int(0, 1, length.out = length(domain))

  purrr::list_modify(
    select(unclass(object), where(is.atomic)),
    domain = domain,
    palette = object$get_palette(ramp),
    ticks = object$get_ticks(limits) %>%
      object$tick_format()
  )
}

#' @export
compile.scale_numeric <- function(object, ...) {
  tidyassert::assert_not_null(object$limits$range)

  limits <- object$limits$range
  domain <- object$get_breaks(limits)
  ramp <- seq.int(0, 1, length.out = length(domain))

  purrr::list_modify(
    select(unclass(object), where(is.atomic)),
    domain = domain,
    range = object$get_range(ramp)
  )
}


#' @export
compile.scale_color_threshold <- function(object, ...) {
  limits <- object$limits$range
  domain <- object$get_breaks(limits)
  # d3 threshold domain excludes limits
  domain <- domain[-c(1, length(domain))]
  tidyassert::warn_if(length(domain) == 0, "domain is empty, scale will be constant")

  ramp <- seq.int(0, 1, length.out = length(domain) + 1)

  purrr::list_modify(
    select(unclass(object), where(is.atomic)),
    domain = domain,
    palette = object$get_palette(ramp),
    ticks = object$get_ticks(limits) %>%
      object$tick_format()
  )
}

#' @export
compile.scale_numeric_threshold <- function(object, ...) {
  limits <- object$limits$range
  domain <- object$get_breaks(limits)
  # d3 threshold domain excludes limits
  domain <- domain[-c(1, length(domain))]
  tidyassert::warn_if(length(domain) == 0, "domain is empty, scale will be constant")

  ramp <- seq.int(0, 1, length.out = length(domain) + 1)

  purrr::list_modify(
    select(unclass(object), where(is.atomic)),
    domain = domain,
    range = object$get_range(ramp)
  )
}


#' @export
compile.scale_color_quantile <- function(object, ...) {
  tidyassert::assert_not_null(object$data$range)

  purrr::list_modify(
    compile.scale_color_threshold(rename(object, limits = data)),
    scale_type = "threshold"
  )
}

#' @export
compile.scale_numeric_quantile <- function(object, ...) {
  tidyassert::assert_not_null(object$data$range)

  purrr::list_modify(
    compile.scale_numeric_threshold(rename(object, limits = data)),
    scale_type = "threshold"
  )
}


#' @export
compile.scale_color_category <- function(object, ...) {
  tidyassert::assert_not_null(object$levels$range)
  domain <- object$levels$range

  purrr::list_modify(
    select(unclass(object), where(is.atomic)),
    domain = domain,
    palette = object$get_palette(domain),
    ticks = object$tick_format(domain)
  )
}

#' @export
compile.scale_numeric_category <- function(object, ...) {
  tidyassert::assert_not_null(object$levels$range)
  domain <- object$levels$range

  purrr::list_modify(
    select(unclass(object), where(is.atomic)),
    domain = domain,
    range = object$get_range(domain)
  )
}


#' @export
compile.scale_color_quantize <- function(object, ...) {
  tidyassert::assert_not_null(object$limits$range)
  domain <- object$limits$range
  ramp <- object$get_breaks(0:1)

  purrr::list_modify(
    select(unclass(object), where(is.atomic)),
    domain = domain,
    palette = object$get_palette(ramp),
    ticks = object$get_ticks(domain) %>%
      object$tick_format()
  )
}

#' @export
compile.scale_numeric_quantize <- function(object, ...) {
  tidyassert::assert_not_null(object$limits$range)
  domain <- object$limits$range
  ramp <- object$get_breaks(0:1)

    purrr::list_modify(
      select(unclass(object), where(is.atomic)),
      domain = domain,
      range = object$get_range(ramp)
    )
}

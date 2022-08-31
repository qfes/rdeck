#' Rescale center
#'
#' @description
#' Re-centers a scale to have a defined center / midpoint. This is the rdeck equivalent of
#' [scales::rescale_mid()].
#'
#' Centering an rdeck scale creates a new scale with the output palette or range centered at `center`.
#' This is similar to creating a diverging scale; the key difference is that the output palette or range
#' remains linear (with respect to the breaks) and is truncated on the side that is closest to `center`.
#' This is useful in creating _difference_ layer, where the output palette or range represents distance
#' from the center.
#'
#' # Centering vs Diverging
#' The plot below shows how [scale_center()] and [scale_diverge()] distort the scale output. The input
#' scale in this case is `power_scale(limits = -36:4)`, centered and diverged at 0 (which is 0.75 on the
#' original output).
#'
#' [rescale_diverge()] is creating a piecewise scale, so the two halves of the output ramp have a different slope;
#' [rescale_center()] is keeping the output linear, but adjusting the slope such that y = 0.5 at x = 0.75 on
#' the linear ramp.
#'
#' ![](rescale.png)
#'
#' @note
#' Category and identity scales aren't supported.
#'
#' @examples
#' # create a sqrt scale that is centered at 0
#' rescale_center(
#'   scale_color_power(col, limits = -36:4),
#'   center = 0
#' )
#'
#' # create a discrete symlog scale that is centered at 5
#' rescale_center(
#'   scale_color_threshold(col, limits = -100:100, breaks = breaks_symlog()),
#'   center = 5
#' )
#'
#' @param scale <`scale`> a scale object
#' @param center <`number`> the center of the scale input
#' @family scales
#' @export
rescale_center <- function(scale, center = 0) {
  UseMethod("rescale_center")
}

#' @export
rescale_center.scale_color <- function(scale, center = 0) {
  get_palette <- scale$get_palette

  scale$get_palette <- function(x) {
    xmid <- rescale_breaks(scale, center)
    ramp <- scales::rescale_mid(x, mid = xmid)
    get_palette(ramp)
  }

  scale
}

#' @export
rescale_center.scale_numeric <- function(scale, center = 0) {
  get_range <- scale$get_range

  scale$get_range <- function(x) {
    xmid <- rescale_breaks(scale, center)
    ramp <- scales::rescale_mid(x, mid = xmid)
    get_range(ramp)
  }

  scale
}

rescale_center_not_supported <- function(scale, center) {
  rescale_not_supported("rescale_center()", scale$scale_type)
}

#' @export
rescale_center.scale_numeric_identity <- rescale_center_not_supported

#' @export
rescale_center.scale_color_category <- rescale_center_not_supported

#' @export
rescale_center.scale_numeric_category <- rescale_center_not_supported


#' Rescale diverge
#'
#' @description
#' Creates a diverging scale with defined center / midpoint. Similar to [rescale_center()], key difference is
#' the output palette / range is piecewise linear (with respect to breaks) and the entire output range is
#' always used.
#'
#' @examples
#' # create a diverging linear scale at 0
#' rescale_diverge(
#'   scale_color_linear(col, limits = -5:10),
#'   center = 0
#' )
#'
#' # create a diverging log scale at 10
#' rescale_diverge(
#'   scale_log(col, limits = 1:1000),
#'   center = 10
#' )
#' @inherit rescale_center
#' @family scales
#' @export
#' @export
rescale_diverge <- function(scale, center = 0) {
  UseMethod("rescale_diverge")
}

#' @export
rescale_diverge.scale_color <- function(scale, center = 0) {
  get_palette <- scale$get_palette

  scale$get_palette <- function(x) {
    xmid <- rescale_breaks(scale, center)
    ramp <- rescale_piecewise(x, xmid)
    get_palette(ramp)
  }

  scale
}

#' @export
rescale_diverge.scale_numeric <- function(scale, center = 0) {
  get_range <- scale$get_range

  scale$get_range <- function(x) {
    xmid <- rescale_breaks(scale, center)
    ramp <- rescale_piecewise(x, xmid)
    get_range(ramp)
  }

  scale
}

rescale_diverge_not_supported <- function(scale, center) {
  rescale_not_supported("rescale_diverge()", scale$scale_type)
}

#' @export
rescale_diverge.scale_numeric_identity <- rescale_diverge_not_supported

#' @export
rescale_diverge.scale_color_category <- rescale_diverge_not_supported

#' @export
rescale_diverge.scale_numeric_category <- rescale_diverge_not_supported


rescale_breaks <- function(scale, x) {
  range <- (scale$limits %||% scale$data)$range
  tidyassert::assert(x >= range[1] & x <= range[2])

  # use transform if available
  trans <- attr(scale$get_breaks, "trans")
  if (!is.null(trans)) {
    scales::rescale(trans$transform(x), from = trans$transform(range))
  # approximate function from breaks
  } else {
    breaks <- scale$get_breaks(range)
    rescale <- stats::splinefun(breaks, seq.int(0, 1, length.out = length(breaks)))
    rescale(x)
  }
}

rescale_piecewise <- function(x, mid) {
  dplyr::case_when(
    x == mid ~ 0.5,
    x < mid ~ scales::rescale(x, c(0, 0.5), c(0, mid)),
    x > mid ~ scales::rescale(x, c(0.5, 1), c(mid, 1))
  )
}

rescale_not_supported <- function(rescale_fn, scale_type) {
  rlang::abort(
    paste(rescale_fn, "doesn't handle", scale_type, "scales."),
    class = "rdeck_error"
  )
}

function() {
  devtools::load_all(export=F)

  ramp <- seq.int(0, 1, length.out = 101)
  limits <- range(-36:4)
  trans <- power_trans()

  mid <- scales::rescale(trans$transform(0), from = trans$transform(limits))
  centered <- scales::rescale_mid(ramp, mid = mid)
  diverged <- rdeck:::rescale_piecewise(ramp, mid)

  linear <- tibble::tibble(
    x = rep(ramp, 3),
    y = c(ramp, centered, diverged),
    type = rep(c("original", "centered", "diverged"), each = length(ramp))
  )

  nonlinear <- dplyr::mutate(linear, x = rep(breaks_trans(101, trans)(limits), 3))
  data <- dplyr::bind_rows(linear_ramp = linear, input_range = nonlinear, .id = "input_scale")



  p <- ggplot2::ggplot(data, ggplot2::aes(x, y, color = type)) +
    ggplot2::geom_line() +
    ggplot2::xlab("input") +
    ggplot2::ylab("output") +
    ggplot2::facet_wrap(~ input_scale, ncol = 2, scales="free_x")

  ggplot2::ggsave(
    filename = "man/figures/rescale.png",
    plot = p,
    width = 8,
    height = 5,
    # width = 600,
    # height = 600,
    # units = "px",
    dpi = 150
  )
}

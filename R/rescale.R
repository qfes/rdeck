#' Rescale center
#'
#' @description
#' Re-centres a scale to have a defined centre / midpoint. This is the rdeck equivalent of
#' [scales::rescale_mid()].
#'
#' centring an rdeck scale creates a new scale with the output palette or range centred at `center`.
#' This is similar to creating a diverging scale; the key difference is that the output palette or range
#' remains linear (with respect to the breaks) and is truncated on the side that is closest to `center`.
#' This is useful in creating _difference_ layers, where the output palette or range represents distance
#' from the centre.
#'
#' # Centring vs Diverging
#' The plot below shows how [rescale_center()] and [rescale_diverge()] distort the scale output. The input
#' scale in this case is `power_scale(limits = -36:4)`; this scale is centred and diverged at 0.
#'
#' The plot on the left shows the mapping between the input `-36:4` (x axis) and output `0:1` (y axis). The
#' plot on the right is a linear representation of the left and is the space that rdeck works in. The input
#' `-36:4` transformed with `power_trans()` and rescaled to `0:1`. This plot has been included because it's
#' (hopefully) easier to understand.
#'
#' In the unaltered scale, we see that 0 is mapped to 0.75 in the output, which would be the colour at 0.75
#' on a colour ramp (e.g. `scales::colour_ramp(viridis::viridis(256))(0.75)`).
#'
#' When applying [rescale_center()] we see that gradient of function has become y = 2/3x in the linear
#' scale, which is `2/3 * scales::rescale(trans$transform(x))` for our data. For [rescale_diverge()]
#' we see a piecewise scale with the break at `center`; both sides of `center` have a different gradient
#' (y = 2/3x and y = 2x - 1) and the full range  of y is used.
#'
#' The colour ramp plot shows the effect rescaling has on a colour palette (in this case viridis).
#'
#' ![](rescale.png)
#'
#' @note
#' Category and identity scales aren't supported.
#'
#' @examples
#' # create a sqrt scale that is centered at 0
#' sqrt_centered <- rescale_center(
#'   scale_color_power(col, limits = -36:4),
#'   center = 0
#' )
#'
#' # create a discrete symlog scale that is centered at 5
#' symlog_centered <- rescale_center(
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
#' Creates a diverging scale with defined centre / midpoint. Similar to [rescale_center()], key difference is
#' the output palette / range is piecewise linear (with respect to breaks) and the entire output range is
#' always used.
#'
#' @examples
#' # create a diverging linear scale at 0
#' linear_diverged <- rescale_diverge(
#'   scale_color_linear(col, limits = -5:10),
#'   center = 0
#' )
#'
#' # create a diverging log scale at 10
#' log_diverged <- rescale_diverge(
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
  out <- x

  out[x == mid] <- 0.5
  out[x < mid] <- scales::rescale(x[x < mid], c(0, 0.5), c(0, mid))
  out[x > mid] <- scales::rescale(x[x > mid], c(0.5, 1), c(mid, 1))

  out
}

rescale_not_supported <- function(rescale_fn, scale_type) {
  rlang::abort(
    paste(rescale_fn, "doesn't handle", scale_type, "scales."),
    class = "rdeck_error"
  )
}

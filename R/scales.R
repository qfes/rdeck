#' Scale linear
#'
#' Creates a continuous linear scale.
#' @name scale_linear
#' @inheritParams scale
#' @family scales
#' @export
scale_color_linear <- function(col, palette, na_color = "#000000",
                               limits = NULL, breaks = NULL, n_ticks = 6, legend = TRUE) {
  col <- rlang::enquo(col)
  assert_quo_is_sym(col, "col")

  linear_scale <- scale(
    "linear",
    col = rlang::as_name(col),
    palette = palette,
    na_color = na_color,
    limits = limits,
    breaks = breaks,
    n_ticks = n_ticks,
    legend = legend
  )

  validate_palette(linear_scale)
  validate_na_color(linear_scale)
  validate_limits(linear_scale)
  validate_breaks(linear_scale)
  validate_n_ticks(linear_scale)
  validate_legend(linear_scale)

  linear_scale
}

#' @name scale_linear
#' @export
scale_linear <- function(col, range = 0:1, na_value = 0,
                         limits = NULL, breaks = NULL, legend = FALSE) {
  col <- rlang::enquo(col)
  assert_quo_is_sym(col, "col")

  linear_scale <- scale(
    "linear",
    col = rlang::as_name(col),
    range = range,
    na_value = na_value,
    limits = limits,
    breaks = breaks,
    legend = legend
  )

  validate_range(linear_scale)
  validate_na_value(linear_scale)
  validate_limits(linear_scale)
  validate_breaks(linear_scale)
  validate_legend(linear_scale)

  linear_scale
}

#' Scale power
#'
#' Creates a continuous power scale. Similar to a `scale_linear` except that an exponential
#' transform is applied to each input.
#' @name scale_power
#' @param exponent The power exponent.
#' @inheritParams scale
#' @family scales
#' @export
scale_color_power <- function(col, palette, na_color = "#000000", exponent = 0.5,
                              limits = NULL, breaks = NULL, n_ticks = 6, legend = TRUE) {
  col <- rlang::enquo(col)
  assert_quo_is_sym(col, "col")

  power_scale <- scale(
    "power",
    col = rlang::as_name(col),
    palette = palette,
    na_color = na_color,
    exponent = exponent,
    limits = limits,
    breaks = breaks,
    n_ticks = n_ticks,
    legend = legend
  )

  validate_palette(power_scale)
  validate_na_color(power_scale)
  validate_exponent(power_scale)
  validate_limits(power_scale)
  validate_breaks(power_scale)
  validate_n_ticks(power_scale)
  validate_legend(power_scale)

  power_scale
}

#' @name scale_power
#' @export
scale_power <- function(col, range = 0:1, na_value = 0, exponent = 0.5,
                        limits = NULL, breaks = NULL, legend = FALSE) {
  col <- rlang::enquo(col)
  assert_quo_is_sym(col, "col")

  power_scale <- scale(
    "power",
    col = rlang::as_name(col),
    range = range,
    na_value = na_value,
    exponent = exponent,
    limits = limits,
    breaks = breaks,
    legend = legend
  )

  validate_range(power_scale)
  validate_na_value(power_scale)
  validate_exponent(power_scale)
  validate_limits(power_scale)
  validate_breaks(power_scale)
  validate_legend(power_scale)

  power_scale
}

#' Scale log
#'
#' Creates a continuous log scale. Similar to a `scale_linear` except that an logarithmic
#' transform is applied to each input.
#' @note undefined behaviour if limits crosses 0.
#' @name scale_log
#' @param base The log base.
#' @inheritParams scale
#' @family scales
#' @export
scale_color_log <- function(col, palette, na_color = "#000000", base = 10,
                            limits = NULL, breaks = NULL, n_ticks = 6, legend = TRUE) {
  col <- rlang::enquo(col)
  assert_quo_is_sym(col, "col")

  log_scale <- scale(
    "log",
    col = rlang::as_name(col),
    palette = palette,
    na_color = na_color,
    base = base,
    limits = limits,
    breaks = breaks,
    n_ticks = n_ticks,
    legend = legend
  )

  validate_palette(log_scale)
  validate_na_color(log_scale)
  validate_base(log_scale)
  validate_limits(log_scale)
  validate_breaks(log_scale)
  validate_n_ticks(log_scale)
  validate_legend(log_scale)

  log_scale
}

#' @name scale_log
#' @export
scale_log <- function(col, range = 0:1, na_value = 0, base = 10,
                      limits = NULL, breaks = NULL, legend = FALSE) {
  col <- rlang::enquo(col)
  assert_quo_is_sym(col, "col")

  log_scale <- scale(
    "log",
    col = rlang::as_name(col),
    range = range,
    na_value = na_value,
    base = base,
    limits = limits,
    breaks = breaks,
    legend = legend
  )

  validate_range(log_scale)
  validate_na_value(log_scale)
  validate_base(log_scale)
  validate_limits(log_scale)
  validate_breaks(log_scale)
  validate_legend(log_scale)

  log_scale
}

#' Scale threshold
#'
#' Creates a discrete threshold scale. Threshold scale is similar to `scale_quantize()`, except
#' that threshold values can be arbitrary.
#' @name scale_threshold
#' @param breaks The threshold breaks of the scale. Must be `length(palette) - 1`
#' or `length(range) - 1`, such that each `break` defines boundary between between a
#' pair of a `palette` or `range` entries.
#' @inheritParams scale
#' @family scales
#' @export
scale_color_threshold <- function(col, palette, na_color = "#000000",
                                  limits = NULL, breaks = 0.5, legend = TRUE) {
  col <- rlang::enquo(col)
  assert_quo_is_sym(col, "col")

  threshold_scale <- scale(
    "threshold",
    col = rlang::as_name(col),
    palette = palette,
    na_color = na_color,
    limits = limits,
    breaks = breaks,
    legend = legend
  )

  validate_palette(threshold_scale)
  validate_na_color(threshold_scale)
  validate_limits(threshold_scale)
  validate_breaks(threshold_scale)
  validate_legend(threshold_scale)

  threshold_scale
}

#' @name scale_threshold
#' @export
scale_threshold <- function(col, range = 0:1, na_value = 0,
                            limits = NULL, breaks = 0.5, legend = FALSE) {
  col <- rlang::enquo(col)
  assert_quo_is_sym(col, "col")

  threshold_scale <- scale(
    "threshold",
    col = rlang::as_name(col),
    range = range,
    na_value = na_value,
    breaks = breaks,
    legend = legend
  )

  validate_range(threshold_scale)
  validate_na_value(threshold_scale)
  validate_limits(threshold_scale)
  validate_breaks(threshold_scale)
  validate_legend(threshold_scale)

  threshold_scale
}

#' Scale quantile
#'
#' Creates a quantile scale. Number of quantiles is defined by the length of
#' `palette` or `range`.
#' As the quantiles are computed from input data, quantile scales
#' are incompatible with layers that load data from a url. (e.g `mvt_layer`).
#' @name scale_quantile
#' @inheritParams scale
#' @family scales
#' @export
scale_color_quantile <- function(col, palette, na_color = "#000000", legend = TRUE) {
  col <- rlang::enquo(col)
  assert_quo_is_sym(col, "col")

  quantile_scale <- scale(
    "quantile",
    col = rlang::as_name(col),
    palette = palette,
    na_color = na_color,
    legend = legend
  )

  validate_palette(quantile_scale)
  validate_na_color(quantile_scale)
  validate_legend(quantile_scale)

  quantile_scale
}

#' @name scale_quantile
#' @export
scale_quantile <- function(col, range = 1:5, na_value = 0, legend = FALSE) {
  col <- rlang::enquo(col)
  assert_quo_is_sym(col, "col")

  quantile_scale <- scale(
    "quantile",
    col = rlang::as_name(col),
    range = range,
    na_value = na_value,
    legend = legend
  )

  validate_range(quantile_scale)
  validate_na_value(quantile_scale)
  validate_legend(quantile_scale)

  quantile_scale
}

#' Scale category
#'
#' Creates a categorical scale.
#' @name scale_category
#' @param levels The category levels. If NULL, will be populated from input data.
#' The order of the levels is determined by `levels()` for factors & `unique()` otherwise.
#' Length of `levels` must equal `palette` or `range`, such that each category level is
#' assigned a `color` or `range` value.
#' @param unmapped_color The color representing unmapped levels.
#' @inheritParams scale
#' @family scales
#' @export
scale_color_category <- function(col, palette, unmapped_color = "#000000", levels = NULL,
                                 legend = TRUE) {
  col <- rlang::enquo(col)
  assert_quo_is_sym(col, "col")

  category_scale <- scale(
    "category",
    col = rlang::as_name(col),
    palette = palette,
    unmapped_color = unmapped_color,
    levels = levels,
    legend = legend
  )

  validate_palette(category_scale)
  validate_unmapped_color(category_scale)
  validate_legend(category_scale)

  category_scale
}

#' @name scale_category
#' @param unmapped_value The value representing unmapped levels.
#' @export
scale_category <- function(col, range = 0:1, unmapped_value = 0, levels = NULL, legend = FALSE) {
  col <- rlang::enquo(col)
  assert_quo_is_sym(col, "col")

  category_scale <- scale(
    "category",
    col = rlang::as_name(col),
    range = range,
    unmapped_value = unmapped_value,
    levels = levels,
    legend = legend
  )

  validate_range(category_scale)
  validate_unmapped_value(category_scale)
  validate_legend(category_scale)

  category_scale
}

#' Scale quantize
#'
#' Creates a discrete quantize scale. A more restrictive version of `scale_threshold` in
#' that each `break` is uniformly spaced between `limits`.
#' @name scale_quantize
#' @inheritParams scale
#' @family scales
#' @export
scale_color_quantize <- function(col, palette, na_color = "#000000",
                                 limits = NULL, legend = TRUE) {
  col <- rlang::enquo(col)
  assert_quo_is_sym(col, "col")

  quantize_scale <- scale(
    "quantize",
    col = rlang::as_name(col),
    palette = palette,
    na_color = na_color,
    limits = limits,
    legend = legend
  )

  validate_palette(quantize_scale)
  validate_na_color(quantize_scale)
  validate_limits(quantize_scale)
  validate_legend(quantize_scale)

  quantize_scale
}

#' @name scale_quantize
#' @export
scale_quantize <- function(col, range = 0:1, na_value = 0, limits = NULL, legend = FALSE) {
  col <- rlang::enquo(col)
  assert_quo_is_sym(col, "col")

  quantize_scale <- scale(
    "quantize",
    col = rlang::as_name(col),
    range = range,
    na_value = na_value,
    limits = limits,
    legend = legend
  )

  validate_range(quantize_scale)
  validate_na_value(quantize_scale)
  validate_limits(quantize_scale)
  validate_legend(quantize_scale)

  quantize_scale
}

#' @name scale
#' @param col The name of the column containing data to be scaled. Can be either
#' a named column (non-standard evaluation), or an expression evaluating a string.
#' @param palette The color palette of the color scale. Must be a vector of
#' rgb[a] hex strings of length >= 2.
#' @param range The output range of the numeric scale. Must be be a numeric vector of
#' length >= 2.
#' @param na_color The color value for `NA` input values.
#' @param na_value The output value for `NA` input values.
#' @param limits The limits of the scale's input. If not null, must be a numeric vector
#' of length 2, representing `c(min, max)`. Values outside the range of `limits` will be
#' constrained to the limits of the scale.
#' @param breaks The breaks of the scale, allowing to define a piecewise scale. If not
#' null, must be `length(palette) - 2` or `length(range) - 2`, such that each `break`
#' is mapped to a `palette` or `range` entry.
#' @param n_ticks The number of ticks to display on the legend. Includes the domain
#' of the scale.
#'
#' @param legend Indicate whether the legend should be displayed for this scale.
#'
#' @keywords internal
scale <- function(scale, ...) {
  structure(
    c(list(scale = scale), rlang::dots_list(...)),
    class = c(paste0("scale_", scale), "scale")
  )
}
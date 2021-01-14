#' Scale linear
#'
#' Creates a continuous linear scale. The colour palette (or range) is linearly interpolated
#' between `limits` (or between `limits` and between `breaks` for piecewise scales).
#'
#' @name scale_linear
#' @inheritParams scale_props
#' @family scales
#' @export
scale_color_linear <- function(col, palette, na_color = "#000000",
                               limits = NULL, breaks = NULL,
                               n_ticks = NULL, tick_format = format_number, legend = TRUE) {
  col <- rlang::enquo(col)
  assert_quo_is_sym(col, "col")

  linear_scale <- scale(
    "linear",
    col = rlang::as_name(col),
    palette = palette,
    na_color = na_color,
    limits = limits,
    breaks = breaks,
    n_ticks = n_ticks %||% ifelse(is.null(breaks), 6, length(breaks) + 2),
    tick_format = tick_format,
    legend = legend
  )

  validate_palette(linear_scale)
  validate_na_color(linear_scale)
  validate_limits(linear_scale)
  validate_breaks(linear_scale)
  validate_n_ticks(linear_scale)
  validate_tick_format(linear_scale)
  validate_legend(linear_scale)

  linear_scale
}

#' @name scale_linear
#' @export
scale_linear <- function(col, range = 0:1, na_value = 0,
                         limits = NULL, breaks = NULL, legend = TRUE) {
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
#' @description
#' Creates a continuous power scale. Power scales are similar to a [`scale_linear`], except
#' that an exponential transform is applied to each input prior to calculating the output
#' colour or number.
#'
#' Power scales can be useful in transforming positively skewed data. A square-root or
#' cube-root scale can be helpful in dealing with right-skewed data.
#'
#' A square-root scale can be defined with `scale_power(exponent = 0.5, ...)` (the default). A
#' square-root scale is a good choice for scaling the radius of point data, as the `area` of
#' each point will be effectively linear in the data.
#'
#' @name scale_power
#' @param exponent <`number`> The power exponent.
#' @inheritParams scale_props
#' @family scales
#' @export
scale_color_power <- function(col, palette, na_color = "#000000", exponent = 0.5,
                              limits = NULL, breaks = NULL,
                              n_ticks = NULL, tick_format = format_number, legend = TRUE) {
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
    n_ticks = n_ticks %||% ifelse(is.null(breaks), 6, length(breaks) + 2),
    tick_format = tick_format,
    legend = legend
  )

  validate_palette(power_scale)
  validate_na_color(power_scale)
  validate_exponent(power_scale)
  validate_limits(power_scale)
  validate_breaks(power_scale)
  validate_n_ticks(power_scale)
  validate_tick_format(power_scale)
  validate_legend(power_scale)

  power_scale
}

#' @name scale_power
#' @export
scale_power <- function(col, range = 0:1, na_value = 0, exponent = 0.5,
                        limits = NULL, breaks = NULL, legend = TRUE) {
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
#' @description
#' Creates a continuous log scale. Log scales are similar to a [`scale_linear`], except
#' that a logarithmic transform is applied to each input prior to calculating the output
#' colour or number.
#'
#' Log scales can be useful in transforming positively skewed data.
#'
#' @note
#' Undefined behaviour if `limits` crosses 0. `limits` must be strictly positive or negative.
#'
#' @name scale_log
#' @param base <`number`> The log base. The log base must be a strictly positive value != 1.
#' @inheritParams scale_props
#' @family scales
#' @export
scale_color_log <- function(col, palette, na_color = "#000000", base = 10,
                            limits = NULL, breaks = NULL,
                            n_ticks = NULL, tick_format = format_number, legend = TRUE) {
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
    n_ticks = n_ticks %||% ifelse(is.null(breaks), 6, length(breaks) + 2),
    tick_format = tick_format,
    legend = legend
  )

  validate_palette(log_scale)
  validate_na_color(log_scale)
  validate_base(log_scale)
  validate_limits(log_scale)
  validate_breaks(log_scale)
  validate_n_ticks(log_scale)
  validate_tick_format(log_scale)
  validate_legend(log_scale)

  log_scale
}

#' @name scale_log
#' @export
scale_log <- function(col, range = 0:1, na_value = 0, base = 10,
                      limits = NULL, breaks = NULL, legend = TRUE) {
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
#' @description
#' Creates a discrete threshold scale. Threshold scales slice the input data into
#' `length(palette)` (or `length(range)`) bins, with each bin being assigned a colour
#' (or number) associated with that bin.
#'
#' Threshold scales are similar [`scale_quantize`], except that threshold break values can be
#' any sequence of numbers, provided that they are in increasing order and within the bounds
#' of limits.
#'
#' @name scale_threshold
#' @param breaks <`numeric`> The threshold breaks of the scale. Must be `length(palette) - 1`
#' or `length(range) - 1`, such that each `break` defines boundary between between a
#' pair of a `palette` or `range` entries.
#'
#' Breaks must be in increasing order, within the bounds of `limits`. Each break will be
#' present on the legend for colour scales.
#' @inheritParams scale_props
#' @family scales
#' @export
scale_color_threshold <- function(col, palette, na_color = "#000000",
                                  limits = NULL, breaks = 0.5,
                                  tick_format = format_number, legend = TRUE) {
  col <- rlang::enquo(col)
  assert_quo_is_sym(col, "col")

  threshold_scale <- scale(
    "threshold",
    col = rlang::as_name(col),
    palette = palette,
    na_color = na_color,
    limits = limits,
    breaks = breaks,
    tick_format = tick_format,
    legend = legend
  )

  validate_palette(threshold_scale)
  validate_na_color(threshold_scale)
  validate_limits(threshold_scale)
  validate_breaks(threshold_scale)
  validate_tick_format(threshold_scale)
  validate_legend(threshold_scale)

  threshold_scale
}

#' @name scale_threshold
#' @export
scale_threshold <- function(col, range = 0:1, na_value = 0,
                            limits = NULL, breaks = 0.5,
                            tick_format = format_number, legend = TRUE) {
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
#' @description
#' Creates a quantile scale. The number of quantiles is defined by the length of
#' `palette` or `range`. For example, a quantile scale with 5 colours will have quantile
#' breaks at: `c(0.2, 0.4, 0.6, 0.8)`.
#'
#' Quantile scale legend ticks will be quantile values at each quantile break (including
#' limits), not the quantile probabilities at each break. You may override this with
#' `tick_format`.
#'
#' Example:
#' `tick_format = function(x) format_number(seq(0, 1, length.out = length(x)))`.
#'
#' @note
#' As the quantiles are computed from input data, quantile scales are incompatible with
#' layers that load data from a url (e.g `mvt_layer`). If quantiles for remote data are
#' known, a quantile scale can be constructed manually with [`scale_threshold`].
#'
#' @name scale_quantile
#' @inheritParams scale_props
#' @family scales
#' @export
scale_color_quantile <- function(col, palette, na_color = "#000000",
                                 tick_format = format_number, legend = TRUE) {
  col <- rlang::enquo(col)
  assert_quo_is_sym(col, "col")

  quantile_scale <- scale(
    "quantile",
    col = rlang::as_name(col),
    palette = palette,
    na_color = na_color,
    tick_format = tick_format,
    legend = legend
  )

  validate_palette(quantile_scale)
  validate_na_color(quantile_scale)
  validate_tick_format(quantile_scale)
  validate_legend(quantile_scale)

  quantile_scale
}

#' @name scale_quantile
#' @export
scale_quantile <- function(col, range = 1:5, na_value = 0, legend = TRUE) {
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
#' Creates a categorical scale. Categorical scales map input values defined in the set of
#' `levels` to colours (or values). Input values not in the set of `levels` are assigned
#' `unmapped_color` (or `unmapped_value`).
#'
#' @name scale_category
#' @param levels <`factor` | `character` | `logical`> The category levels. If `NULL`, will be
#' populated from input data. The order of the levels is determined by `levels()` for factors
#' & `unique()` otherwise. Length of `levels` must equal `palette` or `range`, such that each
#' category level is assigned a colour or range value.
#' @param unmapped_color <[`color`]> The colour representing unmapped levels.
#' @param unmapped_tick <`string`> The tick label of the unmapped category. If not `NULL` and
#' `legend == TRUE`, the unmapped category will appear at the bottom of the legend.
#' @inheritParams scale_props
#' @family scales
#' @export
scale_color_category <- function(col, palette, unmapped_color = "#000000", levels = NULL,
                                 unmapped_tick = NULL, tick_format = NULL, legend = TRUE) {
  col <- rlang::enquo(col)
  assert_quo_is_sym(col, "col")

  category_scale <- scale(
    "category",
    col = rlang::as_name(col),
    palette = palette,
    unmapped_color = unmapped_color,
    levels = base::levels(levels) %||% unique(levels),
    unmapped_tick = unmapped_tick,
    tick_format = tick_format,
    legend = legend
  )

  validate_palette(category_scale)
  validate_unmapped_color(category_scale)
  validate_unmapped_tick(category_scale)
  validate_tick_format(category_scale)
  validate_legend(category_scale)

  category_scale
}

#' @name scale_category
#' @param unmapped_value <`number`> The value representing unmapped levels.
#' @export
scale_category <- function(col, range = 0:1, unmapped_value = 0, levels = NULL, legend = TRUE) {
  col <- rlang::enquo(col)
  assert_quo_is_sym(col, "col")

  category_scale <- scale(
    "category",
    col = rlang::as_name(col),
    range = range,
    unmapped_value = unmapped_value,
    levels = base::levels(levels) %||% unique(levels),
    legend = legend
  )

  validate_range(category_scale)
  validate_unmapped_value(category_scale)
  validate_legend(category_scale)

  category_scale
}

#' Scale quantize
#'
#' @description
#' Creates a discrete quantize scale. Quantize scales are a special case of [`scale_threshold`]
#' in that each threshold break is uniformly spaced between limits.
#'
#' Similar to [`scale_threshold`], quantize scales slice input data into `length(palette)`
#' (or `length(range)`) equally spaced bins, with each bin being assigned a colour (or number)
#' associated with that bin.
#'
#' @name scale_quantize
#' @inheritParams scale_props
#' @family scales
#' @export
scale_color_quantize <- function(col, palette, na_color = "#000000",
                                 limits = NULL, tick_format = format_number, legend = TRUE) {
  col <- rlang::enquo(col)
  assert_quo_is_sym(col, "col")

  quantize_scale <- scale(
    "quantize",
    col = rlang::as_name(col),
    palette = palette,
    na_color = na_color,
    limits = limits,
    tick_format = tick_format,
    legend = legend
  )

  validate_palette(quantize_scale)
  validate_na_color(quantize_scale)
  validate_limits(quantize_scale)
  validate_tick_format(quantize_scale)
  validate_legend(quantize_scale)

  quantize_scale
}

#' @name scale_quantize
#' @export
scale_quantize <- function(col, range = 0:1, na_value = 0, limits = NULL, legend = TRUE) {
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

scale <- function(scale, ...) {
  structure(
    c(list(scale = scale), rlang::dots_list(...)),
    class = c(paste0("scale_", scale), "scale")
  )
}

#' @title scale_props
#' @name scale_props
#' @rdname _scale_props
#' @param col <`name` | `string`> The name of the column containing data to be scaled.
#' Can be either a named column (non-standard evaluation), or an expression evaluating a string.
#' Supports [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html).
#' @param palette <[`color`]> The colour palette of the colour scale. Must be a vector of
#' rgb[a] hex strings of length >= 2.
#' @param range <`numeric`> The output range of the numeric scale. Must be be a numeric vector of
#' length >= 2.
#' @param na_color <[`color`]> The colour value for `NA` input values.
#' @param na_value <`number`> The output value for `NA` input values.
#' @param limits <`c(min, max)`> The limits of the scale's input. If not null, must be a
#' numeric vector of length 2, representing `c(min, max)`. Values outside the range of
#' `limits` will be clamped to the limits of the scale.
#' @param breaks <`numeric`> The breaks of the scale, allowing to define a piecewise scale.
#' If not null, must be `length(palette) - 2` or `length(range) - 2`, such that each `break`
#' is mapped to a `palette` or `range` entry.
#'
#' Each break will be present on the legend for colour scales.
#' @param n_ticks <`number`> The number of ticks to display on the legend. Includes the domain
#' of the scale. If `breaks` is not `NULL`, each break must map to a tick and gaps between
#' breaks must have the same number of ticks; i.e. `n_ticks` must be
#' `2 + length(breaks) + x * (length(breaks) + 1)`, where `x` is any positive integer.
#'
#' Defaults to `2 + length(breaks)` when `breaks` is not `NULL`; `6` otherwise.
#' @param tick_format <`function`> A function taking a vector of ticks returning formatted ticks.
#' @param legend <`logical`> Indicate whether the legend should be displayed for this scale.
NULL

#' Format number
#'
#' Format numeric and integer values.
#' @name format_number
#' @param tick a vector of tick values
#' @param digits the number of digits to output
#' @export
format_number <- function(tick, digits = 2) {
  formatC(
    tick,
    digits = digits,
    format = "f",
    big.mark = ",",
    drop0trailing = is.integer(tick)
  )
}

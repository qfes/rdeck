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


# construct a scale object
scale <- function(scale_type, ..., trans = scales::identity_trans(), legend) {
  rlang::check_required(scale_type)
  tidyassert::assert(scales::is.trans(trans))
  tidyassert::assert_is_scalar_logical(legend)

  structure(
    rlang::dots_list(
      scale_type,
      trans,
      legend,
      ...,
      .named = TRUE
    ),
    class = "scale"
  )
}

scale_color <- function(scale_type, ..., na_color, tick_format) {
  tidyassert::assert(is.null(tick_format) || is.function(tick_format))
  assert_is_rgba(na_color)
  tick_format <- tick_format %||% function(x) x

  cls <- c(paste0("scale_color_", scale_type), "scale_color")
  add_class(scale(scale_type, ..., na_color, tick_format), cls)
}

scale_numeric <- function(scale_type, ..., na_value) {
  tidyassert::assert_is_scalar_numeric(na_value)

  cls <- c(paste0("scale_numeric_", scale_type), "scale_numeric")
  add_class(scale(scale_type, ..., na_value), cls)
}


#' Scale linear
#'
#' Creates a continuous linear scale. The colour palette (or range) is linearly interpolated
#' between `limits` (or between `limits` and between `breaks` for piecewise scales).
#'
#' @name scale_linear
#' @inheritParams scale_props
#' @family scales
#' @export
scale_color_linear <- function(col, palette = scales::viridis_pal(), na_color = "#000000",
                               limits = NULL, breaks = NULL,
                               n_ticks = NULL, tick_format = format_number, legend = TRUE) {
  rlang::check_required(col)

  scale_color(
    "linear",
    trans = scales::identity_trans(),
    col = enstring({{ col }}),
    get_palette = color_gradient(palette),
    na_color = na_color,
    limits = continuous_range(limits),
    get_breaks = as_breaks(breaks) %||% breaks_linear(10),
    get_ticks = breaks_linear(n_ticks %||% 6),
    tick_format = tick_format,
    legend = legend
  )
}


#' @name scale_linear
#' @export
scale_linear <- function(col, range = 0:1, na_value = 0,
                         limits = NULL, breaks = NULL, legend = TRUE) {
  rlang::check_required(col)

  scale_numeric(
    "linear",
    trans = scales::identity_trans(),
    col = enstring({{ col }}),
    get_range = number_gradient(range),
    na_value = na_value,
    limits = continuous_range(limits),
    get_breaks = as_breaks(breaks) %||% breaks_linear(length(range)),
    legend = legend
  )
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
#' square-root scale is a good choice for scaling the radius of point data, as this would result
#' in a linear scale for the `area` of each point.
#'
#' @name scale_power
#' @param exponent <`number`> The power exponent.
#' @inheritParams scale_props
#' @family scales
#' @export
scale_color_power <- function(col, palette = scales::viridis_pal(), na_color = "#000000", exponent = 0.5,
                              limits = NULL, breaks = NULL,
                              n_ticks = 6, tick_format = format_number, legend = TRUE) {
  rlang::check_required(col)

  scale_color(
    "power",
    trans = power_trans(exponent),
    exponent = exponent,
    col = enstring({{ col }}),
    get_palette = color_gradient(palette),
    na_color = na_color,
    limits = continuous_range(limits),
    get_breaks = as_breaks(breaks) %||% breaks_power(10, exponent),
    get_ticks = breaks_power(n_ticks %||% 6, exponent),
    tick_format = tick_format,
    legend = legend
  )
}

#' @name scale_power
#' @export
scale_power <- function(col, range = 0:1, na_value = 0, exponent = 0.5,
                        limits = NULL, breaks = NULL, legend = TRUE) {
  rlang::check_required(col)

  scale_numeric(
    "power",
    trans = power_trans(exponent),
    exponent = exponent,
    col = enstring({{ col }}),
    get_range = number_gradient(range),
    na_value = na_value,
    limits = continuous_range(limits),
    get_breaks = as_breaks(breaks) %||% breaks_power(length(range), exponent),
    legend = legend
  )
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
scale_color_log <- function(col, palette = scales::viridis_pal(), na_color = "#000000", base = 10,
                            limits = NULL, breaks = NULL,
                            n_ticks = NULL, tick_format = format_number, legend = TRUE) {
  rlang::check_required(col)

  scale_color(
    "log",
    trans = log_trans(base),
    base = base,
    col = enstring({{ col }}),
    get_palette = color_gradient(palette),
    na_color = na_color,
    limits = continuous_range(limits),
    get_breaks = as_breaks(breaks) %||% breaks_log(10, base),
    get_ticks = breaks_log(n_ticks %||% 6, base),
    tick_format = tick_format,
    legend = legend
  )
}

#' @name scale_log
#' @export
scale_log <- function(col, range = 0:1, na_value = 0, base = 10,
                      limits = NULL, breaks = NULL, legend = TRUE) {
  rlang::check_required(col)

  scale_numeric(
    "log",
    trans = log_trans(base),
    base = base,
    col = enstring({{ col }}),
    get_range = number_gradient(range),
    na_value = na_value,
    limits = continuous_range(limits),
    get_breaks = as_breaks(breaks) %||% breaks_log(length(range), base),
    legend = legend
  )
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
scale_color_threshold <- function(col, palette = scales::viridis_pal(), na_color = "#000000",
                                  limits = NULL, breaks = 0.5,
                                  tick_format = format_number, legend = TRUE) {
  rlang::check_required(col)
  tidyassert::assert_not_null(breaks)

  scale_color(
    "threshold",
    col = enstring({{ col }}),
    get_palette = color_gradient(palette),
    na_color = na_color,
    limits = continuous_range(limits),
    get_breaks = as_breaks(breaks),
    get_ticks = as_breaks(breaks),
    tick_format = tick_format,
    legend = legend
  )
}

#' @name scale_threshold
#' @export
scale_threshold <- function(col, range = 0:1, na_value = 0,
                            limits = NULL, breaks = 0.5,
                            tick_format = format_number, legend = TRUE) {
  rlang::check_required(col)
  tidyassert::assert_not_null(breaks)

  scale_numeric(
    "threshold",
    col = enstring({{ col }}),
    get_range = number_gradient(range),
    na_value = na_value,
    limits = continuous_range(limits),
    get_breaks = as_breaks(breaks),
    legend = legend
  )
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
scale_color_quantile <- function(col, palette = scales::viridis_pal(), na_color = "#000000",
                                 probs = seq.int(0, 1, 0.25), data = NULL,
                                 tick_format = format_number, legend = TRUE) {
  rlang::check_required(col)

  scale_color(
    "quantile",
    col = enstring({{ col }}),
    get_palette = color_gradient(palette),
    na_color = na_color,
    data = continuous_identity_range(data),
    get_breaks = quantile_breaks(probs),
    get_ticks = quantile_breaks(probs),
    tick_format = tick_format,
    legend = legend
  )
}


#' @name scale_quantile
#' @export
scale_quantile <- function(col, range = 0:1, na_value = 0,
                           probs = seq.int(0, 1, 0.25), data = NULL,
                           legend = TRUE) {
  rlang::check_required(col)

  scale_numeric(
    "quantile",
    col = enstring({{ col }}),
    get_range = number_gradient(range),
    na_value = na_value,
    data = continuous_identity_range(data),
    get_breaks = quantile_breaks(probs),
    legend = legend
  )
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
scale_color_category <- function(col, palette = scales::brewer_pal("div"), unmapped_color = "#000000",
                                 levels = NULL, unmapped_tick = NULL,
                                 tick_format = NULL, legend = TRUE) {
  rlang::check_required(col)
  assert_is_rgba(unmapped_color)
  tidyassert::assert(is.null(unmapped_tick) || rlang::is_string(unmapped_tick))
  tidyassert::assert(is.null(tick_format) || is.function(tick_format))

  category_scale <- scale(
    "category",
    col = enstring({{ col }}),
    get_palette = color_categories(palette),
    unmapped_color = unmapped_color,
    levels = discrete_range(levels),
    tick_format = tick_format %||% function(x) x,
    legend = legend
  )

  add_class(category_scale, c("scale_color_category", "scale_color"))
}

#' @name scale_category
#' @param unmapped_value <`number`> The value representing unmapped levels.
#' @export
scale_category <- function(col, range = 0:1, unmapped_value = 0, levels = NULL, legend = TRUE) {
  rlang::check_required(col)
  tidyassert::assert_is_scalar_numeric(unmapped_value)

  category_scale <- scale(
    "category",
    col = enstring({{ col }}),
    get_range = number_categories(range),
    unmapped_value = unmapped_value,
    levels = discrete_range(levels),
    legend = legend
  )

  add_class(category_scale, c("scale_numeric_category", "scale_numeric"))
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
scale_color_quantize <- function(col, palette = scales::viridis_pal(), na_color = "#000000",
                                 limits = NULL, n_breaks = 6,
                                 tick_format = format_number, legend = TRUE) {
  rlang::check_required(col)
  tidyassert::assert_is_scalar_integerish(n_breaks)

  scale_color(
    "quantize",
    col = enstring({{ col }}),
    get_palette = color_gradient(palette),
    na_color = na_color,
    limits = continuous_range(limits),
    get_breaks = breaks_linear(n_breaks),
    get_ticks = breaks_linear(n_breaks),
    tick_format = tick_format,
    legend = legend
  )
}

#' @name scale_quantize
#' @export
scale_quantize <- function(col, range = 0:1, na_value = 0, limits = NULL, n_breaks = 6, legend = TRUE) {
  rlang::check_required(col)
  tidyassert::assert_is_scalar_integerish(n_breaks)

  scale_numeric(
    "quantize",
    col = enstring({{ col }}),
    get_range = number_gradient(range),
    na_value = na_value,
    limits = continuous_range(limits),
    get_breaks = breaks_linear(n_breaks),
    legend = legend
  )
}


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

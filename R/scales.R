#' @title scale_props
#' @name scale_props
#' @rdname _scale_props
#' @param col <`name` | `string`> The name of the column containing data to be scaled.
#' Must be a valid input to [rlang::ensym()]; either a named column (non-standard evaluation), a string.
#' Supports [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html).
#' @param palette <[`color`]|`function`> The colour palette of the colour scale. Must be a:
#' - vector of RGBA hex colours,
#' - a palette generator function, taking a length parameter, or
#' - a palette ramp created from [scales::colour_ramp()]
#'
#' A [scales::colour_ramp()] interpolator is created from the input palette.
#' @param range <`numeric`> The output range of the numeric scale. Must be length >= 2.
#' A [stats::approxfun()] interpolator is created from the input range.
#' @param na_color <[`color`]> The colour value for `NA` input values.
#' @param na_value <`number`> The output value for `NA` input values.
#' @param limits <`c(min, max)`> The limits of the scale's input. If `NULL`, limits are computed
#' from layer data. Values outside the range of limits are clamped.
#' @param breaks <`numeric` | `function`> The breaks of the scale, allowing to define a piecewise scale.
#' The scale `palette` or numeric `range` are linearly interpolated (by length) and mapped onto `breaks`.
#' Breaks outside the `limits` of the scale are discarded.
#'
#' If not `NULL`, breaks must be either:
#' - a numeric vector
#' - a breaks function, taking a numeric vector argument (e.g. [breaks_linear()])
#'
#' Defaults to [breaks_trans()] where `trans` is the scale's transformer.
#' @param n_ticks <`number`> The number of ticks to display on the legend. Must be >= 2.
#' The legend size will grow and shrink depending on this value.
#'
#' @param col_label <`string` | `function`> A template string or a label function for customising the
#' column name in the legend.
#' - if `col_label` is a string, `{.col}` may be used to represent the `col` name
#' - if `col_label` is a function, the function must take a single argument: the `col` name
#'
#' @param tick_format <`function`> A label function taking a vector of ticks returning formatted ticks.
#' @param legend <`boolean`> Indicate whether the legend should be displayed for this scale.
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
  tidyassert::assert(is_rgba_color(na_color))
  tick_format <- tick_format %||% function(x) x

  cls <- c(paste0("scale_color_", scale_type), "scale_color")
  add_class(scale(scale_type, ..., na_color, tick_format), cls)
}

scale_numeric <- function(scale_type, ..., na_value) {
  tidyassert::assert_is_scalar_numeric(na_value)

  cls <- c(paste0("scale_numeric_", scale_type), "scale_numeric")
  add_class(scale(scale_type, ..., na_value), cls)
}

is_scale <- function(object) inherits(object, "scale")
is_color_scale <- function(object) is_scale(object) && inherits(object, "scale_color")
is_numeric_scale <- function(object) is_scale(object) && inherits(object, "scale_numeric")

is_quantile_scale <- function(object) is_scale(object) && object$scale_type == "quantile"
is_category_scale <- function(object) is_scale(object) && object$scale_type == "category"

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
                               n_ticks = NULL, tick_format = format_number,
                               col_label = "{.col}", legend = TRUE) {
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
    col_label = as_labeller(col_label),
    legend = legend
  )
}


#' @name scale_linear
#' @export
scale_linear <- function(col, range = 0:1, na_value = 0,
                         limits = NULL, breaks = NULL,
                         col_label = "{.col}", legend = TRUE) {
  rlang::check_required(col)

  scale_numeric(
    "linear",
    trans = scales::identity_trans(),
    col = enstring({{ col }}),
    get_range = number_gradient(range),
    na_value = na_value,
    limits = continuous_range(limits),
    get_breaks = as_breaks(breaks) %||% breaks_linear(length(range)),
    col_label = as_labeller(col_label),
    legend = legend
  )
}


#' Scale power
#'
#' @description
#' Creates a continuous power scale, where input values are transformed with
#' [power_trans(exponent)][power_trans()] before calculating the output.
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
                              n_ticks = 6, tick_format = format_number,
                              col_label = "{.col}", legend = TRUE) {
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
    col_label = as_labeller(col_label),
    legend = legend
  )
}

#' @name scale_power
#' @export
scale_power <- function(col, range = 0:1, na_value = 0, exponent = 0.5,
                        limits = NULL, breaks = NULL,
                        col_label = "{.col}", legend = TRUE) {
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
    col_label = as_labeller(col_label),
    legend = legend
  )
}


#' Scale log
#'
#' @description
#' Creates a continuous log scale, where input values are transformed with [log_trans(base)][log_trans()]
#' before calculating the output.
#'
#' Log scales can be useful in transforming positively skewed data.
#'
#' @note
#' `limits`, whether explicitly supplied, or computed from data, must not cross 0.
#'
#' @name scale_log
#' @param base <`number`> The log base. The log base must be a strictly positive value != 1.
#' @inheritParams scale_props
#' @family scales
#' @export
scale_color_log <- function(col, palette = scales::viridis_pal(), na_color = "#000000", base = 10,
                            limits = NULL, breaks = NULL,
                            n_ticks = NULL, tick_format = format_number,
                            col_label = "{.col}", legend = TRUE) {
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
    col_label = as_labeller(col_label),
    legend = legend
  )
}

#' @name scale_log
#' @export
scale_log <- function(col, range = 0:1, na_value = 0, base = 10,
                      limits = NULL, breaks = NULL,
                      col_label = "{.col}", legend = TRUE) {
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
    col_label = as_labeller(col_label),
    legend = legend
  )
}


#' Scale symlog
#'
#' @description
#' Creates a continuous log1p scale, where input values are transformed with [symlog_trans()][symlog_trans()]
#' before calculating the output. Unlike [scale_log()], `limits` may cross 0.
#'
#' Symlog scales can be useful in transforming positively skewed data.
#'
#' @name scale_symlog
#' @inheritParams scale_props
#' @family scales
#' @export
scale_color_symlog <- function(col, palette = scales::viridis_pal(), na_color = "#000000",
                               limits = NULL, breaks = NULL,
                               n_ticks = NULL, tick_format = format_number,
                               col_label = "{.col}", legend = TRUE) {
  rlang::check_required(col)

  scale_color(
    "symlog",
    trans = symlog_trans(),
    col = enstring({{ col }}),
    get_palette = color_gradient(palette),
    na_color = na_color,
    limits = continuous_range(limits),
    get_breaks = as_breaks(breaks) %||% breaks_symlog(10),
    get_ticks = breaks_symlog(n_ticks %||% 6),
    tick_format = tick_format,
    col_label = as_labeller(col_label),
    legend = legend
  )
}

#' @name scale_symlog
#' @export
scale_symlog <- function(col, range = 0:1, na_value = 0,
                         limits = NULL, breaks = NULL,
                         col_label = "{.col}", legend = TRUE) {
  rlang::check_required(col)

  scale_numeric(
    "symlog",
    trans = symlog_trans(),
    col = enstring({{ col }}),
    get_range = number_gradient(range),
    na_value = na_value,
    limits = continuous_range(limits),
    get_breaks = as_breaks(breaks) %||% breaks_symlog(length(range)),
    col_label = as_labeller(col_label),
    legend = legend
  )
}


#' Scale identity
#'
#' Creates an identity scale; a special case of a linear scale, where input is
#' mapped to itself (input limits = output range). An identity scale is useful
#' in cases where input data is already expressed in a visual representation
#' (e.g. a line width) and should be used as-is.
#'
#' @note
#' Identity scales are _almost_ equivalent to an [`accessor`] to a numeric column;
#' differences are:
#' - `NA` is replaced with `na_value`
#' - May render a _numeric_ legend
#'
#' @name scale_identity
#' @inheritParams scale_props
#' @family scales
#' @export
scale_identity <- function(col, na_value = 0, col_label = "{.col}", legend = TRUE) {
  rlang::check_required(col)

  scale_numeric(
    "identity",
    trans = scales::identity_trans(),
    col = enstring({{ col }}),
    na_value = na_value,
    col_label = as_labeller(col_label),
    legend = legend
  )
}


#' Scale threshold
#'
#' @description
#' Creates a discrete threshold scale. Threshold scales slice `palette` or `range` into
#' `length(breaks) + 1` bins, with each break defining the threshold between 2 bins.
#'
#' Threshold scales can be used to create any discrete scale, using either manual breaks
#' or generated breaks via a transform (e.g. [breaks_power(n = 6, exponent = 0.5)][breaks_power()] for a
#' discrete sqrt scale).
#'
#' @note
#' Threshold scales don't require limits, but [breaks_trans()] does.
#'
#' @name scale_threshold
#' @param breaks <`numeric` | `function`> The threshold breaks of the scale.
#' The scale `palette` or numeric `range` are linearly interpolated (by length) and mapped onto `breaks`.
#' Breaks outside the `limits` of the scale are discarded.
#'
#' If not `NULL`, breaks must be either:
#' - a numeric vector
#' - a breaks function, taking a numeric vector argument (e.g. [breaks_linear()])
#'
#' Breaks must be in increasing order. Each break will be present on the legend for colour scales.
#' @inheritParams scale_props
#' @family scales
#' @export
scale_color_threshold <- function(col, palette = scales::viridis_pal(), na_color = "#000000",
                                  limits = NULL, breaks = 0.5,
                                  tick_format = format_number,
                                  col_label = "{.col}", legend = TRUE) {
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
    col_label = as_labeller(col_label),
    legend = legend
  )
}

#' @name scale_threshold
#' @export
scale_threshold <- function(col, range = 0:1, na_value = 0,
                            limits = NULL, breaks = 0.5,
                            tick_format = format_number,
                            col_label = "{.col}", legend = TRUE) {
  rlang::check_required(col)
  tidyassert::assert_not_null(breaks)

  scale_numeric(
    "threshold",
    col = enstring({{ col }}),
    get_range = number_gradient(range),
    na_value = na_value,
    limits = continuous_range(limits),
    get_breaks = as_breaks(breaks),
    col_label = as_labeller(col_label),
    legend = legend
  )
}

#' Scale quantile
#'
#' @description
#' Creates a threshold scale, where threshold breaks are computed from the given quantile
#' `probs`.
#'
#' Quantile scale legend ticks will be quantile values at each quantile break (including
#' limits), not the quantile probabilities at each break. This can be overridden in
#' `tick_format`.
#'
#' Example:
#' `tick_format = function(x) as.character(probs)`.
#'
#' @note
#' As the quantiles are computed from input data, quantile scales are incompatible with
#' layers that load data from a url (e.g `mvt_layer`). If quantiles for remote data are
#' known, a quantile scale can be constructed manually with [scale_threshold()].
#'
#' @name scale_quantile
#' @inheritParams scale_props
#' @param probs <`numeric`> The quantile probabilities. Must be between 0 and 1.
#' @param data <`numeric`> The data used to compute the quantiles. If `NULL`, will be
#' taken from the layer data.
#' @family scales
#' @export
scale_color_quantile <- function(col, palette = scales::viridis_pal(), na_color = "#000000",
                                 probs = seq.int(0, 1, 0.25), data = NULL,
                                 tick_format = format_number,
                                 col_label = "{.col}", legend = TRUE) {
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
    col_label = as_labeller(col_label),
    legend = legend
  )
}


#' @name scale_quantile
#' @export
scale_quantile <- function(col, range = 0:1, na_value = 0,
                           probs = seq.int(0, 1, 0.25), data = NULL,
                           col_label = "{.col}", legend = TRUE) {
  rlang::check_required(col)

  scale_numeric(
    "quantile",
    col = enstring({{ col }}),
    get_range = number_gradient(range),
    na_value = na_value,
    data = continuous_identity_range(data),
    get_breaks = quantile_breaks(probs),
    col_label = col_label,
    col_label = as_labeller(col_label),
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
#' & `unique()` otherwise.
#'
#' If there are more levels than colours (or range values), the palette (or range) is interpolated.
#' @param unmapped_color <[`color`]> The colour representing unmapped levels.
#' @param unmapped_tick <`string`> The tick label of the unmapped category. If not `NULL` and
#' `legend == TRUE`, the unmapped category will appear at the bottom of the legend.
#' @inheritParams scale_props
#' @family scales
#' @export
scale_color_category <- function(col, palette = scales::brewer_pal("div"), unmapped_color = "#000000",
                                 levels = NULL, unmapped_tick = NULL, tick_format = NULL,
                                 col_label = "{.col}", legend = TRUE) {
  rlang::check_required(col)
  tidyassert::assert(is_rgba_color(unmapped_color))
  tidyassert::assert(is.null(unmapped_tick) || rlang::is_string(unmapped_tick))
  tidyassert::assert(is.null(tick_format) || is.function(tick_format))

  category_scale <- scale(
    "category",
    col = enstring({{ col }}),
    get_palette = color_categories(palette),
    unmapped_color = unmapped_color,
    levels = discrete_range(levels),
    tick_format = tick_format %||% function(x) x,
    col_label = as_labeller(col_label),
    legend = legend
  )

  add_class(category_scale, c("scale_color_category", "scale_color"))
}

#' @name scale_category
#' @param unmapped_value <`number`> The value representing unmapped levels.
#' @export
scale_category <- function(col, range = 0:1, unmapped_value = 0, levels = NULL,
col_label = "{.col}", legend = TRUE) {
  rlang::check_required(col)
  tidyassert::assert_is_scalar_numeric(unmapped_value)

  category_scale <- scale(
    "category",
    col = enstring({{ col }}),
    get_range = number_categories(range),
    unmapped_value = unmapped_value,
    levels = discrete_range(levels),
    col_label = as_labeller(col_label),
    legend = legend
  )

  add_class(category_scale, c("scale_numeric_category", "scale_numeric"))
}


#' Scale quantize
#'
#' @description
#' Creates a discrete quantize scale, with `n_breaks` linearly spaced threshold breaks between
#' `limits`. This scale can be thought of as a restricted special case of [scale_threshold()],
#' or a discrete [scale_linear()].
#'
#' @name scale_quantize
#' @inheritParams scale_props
#' @param n_breaks <`integer`> The number of linearly spaced breaks in the scale.
#' Each break will be present on the legend for colour scales.
#' @family scales
#' @export
scale_color_quantize <- function(col, palette = scales::viridis_pal(), na_color = "#000000",
                                 limits = NULL, n_breaks = 6,
                                 tick_format = format_number,
                                 col_label = "{.col}", legend = TRUE) {
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
    col_label = as_labeller(col_label),
    legend = legend
  )
}

#' @name scale_quantize
#' @export
scale_quantize <- function(col, range = 0:1, na_value = 0, limits = NULL, n_breaks = 6,
col_label = "{.col}", legend = TRUE) {
  rlang::check_required(col)
  tidyassert::assert_is_scalar_integerish(n_breaks)

  scale_numeric(
    "quantize",
    col = enstring({{ col }}),
    get_range = number_gradient(range),
    na_value = na_value,
    limits = continuous_range(limits),
    get_breaks = breaks_linear(n_breaks),
    col_label = as_labeller(col_label),
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


as_labeller <- function(col_label) {
  tidyassert::assert(is.null(col_label) || rlang::is_string(col_label) || is.function(col_label))

  if (is.function(col_label)) {
    col_label
  } else {
    function(col) gsub("{.col}", col, col_label %||% col, fixed = TRUE)
  }
}

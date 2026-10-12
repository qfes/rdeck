# Scale linear

Creates a continuous linear scale. The colour palette (or range) is
linearly interpolated between `limits` (or between `limits` and between
`breaks` for piecewise scales).

## Usage

``` r
scale_color_linear(
  col,
  palette = scales::viridis_pal(),
  na_color = "#000000",
  limits = NULL,
  breaks = NULL,
  n_ticks = NULL,
  tick_format = format_number,
  col_label = "{.col}",
  legend = TRUE
)

scale_linear(
  col,
  range = 0:1,
  na_value = 0,
  limits = NULL,
  breaks = NULL,
  col_label = "{.col}",
  legend = TRUE
)
```

## Arguments

- col:

  \<`name` \| `string`\> The name of the column containing data to be
  scaled. Must be a valid input to
  [`rlang::ensym()`](https://rlang.r-lib.org/reference/defusing-advanced.html);
  either a named column (non-standard evaluation), a string. Supports
  [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html).

- palette:

  \<[`color`](https://qfes.github.io/rdeck/reference/color.md)\|`function`\>
  The colour palette of the colour scale. Must be a:

  - vector of RGBA hex colours,

  - a palette generator function, taking a length parameter, or

  - a palette ramp created from
    [`scales::colour_ramp()`](https://scales.r-lib.org/reference/colour_ramp.html)

  A
  [`scales::colour_ramp()`](https://scales.r-lib.org/reference/colour_ramp.html)
  interpolator is created from the input palette.

- na_color:

  \<[`color`](https://qfes.github.io/rdeck/reference/color.md)\> The
  colour value for `NA` input values.

- limits:

  \<`c(min, max)`\> The limits of the scale's input. If `NULL`, limits
  are computed from layer data. Values outside the range of limits are
  clamped.

- breaks:

  \<`numeric` \| `function`\> The breaks of the scale, allowing to
  define a piecewise scale. The scale `palette` or numeric `range` are
  linearly interpolated (by length) and mapped onto `breaks`. Breaks
  outside the `limits` of the scale are discarded.

  If not `NULL`, breaks must be either:

  - a numeric vector

  - a breaks function, taking a numeric vector argument (e.g.
    [`breaks_linear()`](https://qfes.github.io/rdeck/reference/breaks_linear.md))

  Defaults to
  [`breaks_trans()`](https://qfes.github.io/rdeck/reference/breaks_trans.md)
  where `trans` is the scale's transformer.

- n_ticks:

  \<`number`\> The number of ticks to display on the legend. Must be
  \>= 2. The legend size will grow and shrink depending on this value.

- tick_format:

  \<`function`\> A label function taking a vector of ticks returning
  formatted ticks.

- col_label:

  \<`string` \| `function`\> A template string or a label function for
  customising the column name in the legend.

  - if `col_label` is a string, `{.col}` may be used to represent the
    `col` name

  - if `col_label` is a function, the function must take a single
    argument: the `col` name

- legend:

  \<`boolean`\> Indicate whether the legend should be displayed for this
  scale.

- range:

  \<`numeric`\> The output range of the numeric scale. Must be length
  \>= 2. A
  [`stats::approxfun()`](https://rdrr.io/r/stats/approxfun.html)
  interpolator is created from the input range.

- na_value:

  \<`number`\> The output value for `NA` input values.

## See also

Other scales:
[`rescale_center()`](https://qfes.github.io/rdeck/reference/rescale_center.md),
[`rescale_diverge()`](https://qfes.github.io/rdeck/reference/rescale_diverge.md),
[`scale_category()`](https://qfes.github.io/rdeck/reference/scale_category.md),
[`scale_identity()`](https://qfes.github.io/rdeck/reference/scale_identity.md),
[`scale_log()`](https://qfes.github.io/rdeck/reference/scale_log.md),
[`scale_power()`](https://qfes.github.io/rdeck/reference/scale_power.md),
[`scale_quantile()`](https://qfes.github.io/rdeck/reference/scale_quantile.md),
[`scale_quantize()`](https://qfes.github.io/rdeck/reference/scale_quantize.md),
[`scale_symlog()`](https://qfes.github.io/rdeck/reference/scale_symlog.md),
[`scale_threshold()`](https://qfes.github.io/rdeck/reference/scale_threshold.md)

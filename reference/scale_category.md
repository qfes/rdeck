# Scale category

Creates a categorical scale. Categorical scales map input values defined
in the set of `levels` to colours (or values). Input values not in the
set of `levels` are assigned `unmapped_color` (or `unmapped_value`).

## Usage

``` r
scale_color_category(
  col,
  palette = scales::brewer_pal("div"),
  unmapped_color = "#000000",
  levels = NULL,
  unmapped_tick = NULL,
  tick_format = NULL,
  col_label = "{.col}",
  legend = TRUE
)

scale_category(
  col,
  range = 0:1,
  unmapped_value = 0,
  levels = NULL,
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

- unmapped_color:

  \<[`color`](https://qfes.github.io/rdeck/reference/color.md)\> The
  colour representing unmapped levels.

- levels:

  \<`factor` \| `character` \| `logical`\> The category levels. If
  `NULL`, will be populated from input data. The order of the levels is
  determined by [`levels()`](https://rdrr.io/r/base/levels.html) for
  factors & [`unique()`](https://rdrr.io/r/base/unique.html) otherwise.

  If there are more levels than colours (or range values), the palette
  (or range) is interpolated.

- unmapped_tick:

  \<`string`\> The tick label of the unmapped category. If not `NULL`
  and `legend == TRUE`, the unmapped category will appear at the bottom
  of the legend.

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

- unmapped_value:

  \<`number`\> The value representing unmapped levels.

## See also

Other scales:
[`rescale_center()`](https://qfes.github.io/rdeck/reference/rescale_center.md),
[`rescale_diverge()`](https://qfes.github.io/rdeck/reference/rescale_diverge.md),
[`scale_identity()`](https://qfes.github.io/rdeck/reference/scale_identity.md),
[`scale_linear()`](https://qfes.github.io/rdeck/reference/scale_linear.md),
[`scale_log()`](https://qfes.github.io/rdeck/reference/scale_log.md),
[`scale_power()`](https://qfes.github.io/rdeck/reference/scale_power.md),
[`scale_quantile()`](https://qfes.github.io/rdeck/reference/scale_quantile.md),
[`scale_quantize()`](https://qfes.github.io/rdeck/reference/scale_quantize.md),
[`scale_symlog()`](https://qfes.github.io/rdeck/reference/scale_symlog.md),
[`scale_threshold()`](https://qfes.github.io/rdeck/reference/scale_threshold.md)

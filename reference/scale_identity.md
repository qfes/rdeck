# Scale identity

Creates an identity scale; a special case of a linear scale, where input
is mapped to itself (input limits = output range). An identity scale is
useful in cases where input data is already expressed in a visual
representation (e.g. a line width) and should be used as-is.

## Usage

``` r
scale_identity(col, na_value = 0, col_label = "{.col}", legend = TRUE)
```

## Arguments

- col:

  \<`name` \| `string`\> The name of the column containing data to be
  scaled. Must be a valid input to
  [`rlang::ensym()`](https://rlang.r-lib.org/reference/defusing-advanced.html);
  either a named column (non-standard evaluation), a string. Supports
  [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html).

- na_value:

  \<`number`\> The output value for `NA` input values.

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

## Note

Identity scales are *almost* equivalent to an
[`accessor`](https://qfes.github.io/rdeck/reference/accessor.md) to a
numeric column; differences are:

- `NA` is replaced with `na_value`

- May render a *numeric* legend

## See also

Other scales:
[`rescale_center()`](https://qfes.github.io/rdeck/reference/rescale_center.md),
[`rescale_diverge()`](https://qfes.github.io/rdeck/reference/rescale_diverge.md),
[`scale_category()`](https://qfes.github.io/rdeck/reference/scale_category.md),
[`scale_linear()`](https://qfes.github.io/rdeck/reference/scale_linear.md),
[`scale_log()`](https://qfes.github.io/rdeck/reference/scale_log.md),
[`scale_power()`](https://qfes.github.io/rdeck/reference/scale_power.md),
[`scale_quantile()`](https://qfes.github.io/rdeck/reference/scale_quantile.md),
[`scale_quantize()`](https://qfes.github.io/rdeck/reference/scale_quantize.md),
[`scale_symlog()`](https://qfes.github.io/rdeck/reference/scale_symlog.md),
[`scale_threshold()`](https://qfes.github.io/rdeck/reference/scale_threshold.md)

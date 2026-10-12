# Prop Type: Scale

Scales transform input data into visual representations, predominantly:

- colours: `fill`, `line`, `highlight`

- sizes: `radius`, `elevation`, `width`, `height`

Transformations are performed in client-side javascript, thus scales
have very minimal file-size overhead; what you pay for is the source
data being scaled & the scale descriptor (palette, breaks, etc), but you
don't pay for the scaled output (e.g. the vector of colours). Many
scales can refer to the same column of a dataframe, but the column will
only be serialised once.

Data retrieved in the browser dynamically can also be scaled, including
[`mvt_layer()`](https://qfes.github.io/rdeck/reference/mvt_layer.md).
All `rdeck` scales (except
[`scale_quantile()`](https://qfes.github.io/rdeck/reference/scale_quantile.md))
support both R dataframes and data fetched in javascript, with the
following restrictions:

- column validation isn't performed – missing column / incorrect type
  may error in javascript, or result in the `na_color` / `na_value` used
  for all features

- `limits` / `levels` must be explictly defined in the scale – they
  cannot be learnt from data

- quantile scales technically work, but they require a copy of the data
  to compute the quantiles

## Tidy-eval

Columns referenced by a scale support
[tidy-eval](https://dplyr.tidyverse.org/articles/programming.html)
expressions. The `col` parameter for a scale must be a valid argument to
[`rlang::ensym()`](https://rlang.r-lib.org/reference/defusing-advanced.html)
and follows the same rules. Use the [injection
operators](https://rlang.r-lib.org/reference/topic-inject.html) to pass
the value of a name from the environment, e.g. `!!my_column`.

## Legend

Scales can optionally produce a colour or numeric legend in the client.
Numeric legends give context for which visual field is being scaled and
by what column; colour legends additionally provide a colour scale and
*untransformed* ticks.

Legend ticks can be formatted with a labelling function (e.g.
[`scales::label_number()`](https://scales.r-lib.org/reference/label_number.html)).
This function can completely replace the input ticks if you wish; the
only constraint is the return value is a character vector of the same
length as input *unformatted ticks*.

Legends are [kepler.gl](https://kepler.gl) inspired.

![](https://user-images.githubusercontent.com/391385/103058278-7b1d1000-45ed-11eb-86d2-7ab594bb32de.png)

## Available scales

- [`scale_linear`](https://qfes.github.io/rdeck/reference/scale_linear.md)

- [`scale_power`](https://qfes.github.io/rdeck/reference/scale_power.md)

- [`scale_log`](https://qfes.github.io/rdeck/reference/scale_log.md)

- [`scale_symlog`](https://qfes.github.io/rdeck/reference/scale_symlog.md)

- [`scale_identity`](https://qfes.github.io/rdeck/reference/scale_identity.md)

- [`scale_threshold`](https://qfes.github.io/rdeck/reference/scale_threshold.md)

- [`scale_quantile`](https://qfes.github.io/rdeck/reference/scale_quantile.md)

- [`scale_category`](https://qfes.github.io/rdeck/reference/scale_category.md)

- [`scale_quantize`](https://qfes.github.io/rdeck/reference/scale_quantize.md)

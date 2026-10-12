# Prop Type: Accessor

Accessors map `data` columns to visual representations, primarily:

- colours: `fill`, `line`, `highlight`

- sizes: `radius`, `elevation`, `width`, `height`

- geometries `point/multipoint`, `linestring/multilinestring`,
  `polygon/multipolygon`

On the client, an accessor is translated to a javascript function that
retrieves the specified column values for each rendered feature. An
equivalent R function would look something like
`function(data, col, index) data[[index, col]]`.

## Tidy-eval

Accessors support
[tidy-eval](https://dplyr.tidyverse.org/articles/programming.html)
expressions. Rules for referencing a column vs. a value from the
environment is similar to
[`dplyr::mutate()`](https://dplyr.tidyverse.org/reference/mutate.html),
with the main difference being that *all* names are assumed to be
columns of `data`, not falling back to the environment when they're not
found.

Like
[`dplyr::mutate()`](https://dplyr.tidyverse.org/reference/mutate.html),
using string literals to reference columns isn't supported – this will
be interpreted as a literal string. You may reference a column with:

- a [`name`](https://rdrr.io/r/base/name.html) (e.g. `my_col`)

- a call evaluating [`name`](https://rdrr.io/r/base/name.html), e.g.
  [`as.name()`](https://rdrr.io/r/base/name.html),
  [`rlang::sym()`](https://rlang.r-lib.org/reference/sym.html), etc

- by injecting a variable from the environment containing a `name` with
  `!!my_var`, or `{{myvar}}`

Literal expressions – except calls evaluating a
[`name`](https://rdrr.io/r/base/name.html) or a
[`scale`](https://qfes.github.io/rdeck/reference/scale.md) – will be
interpreted as constant values (e.g. `"#ff0000"`, `1`, `TRUE`, etc.). To
use the *value* of a variable from the environment, use the [injection
operators](https://rlang.r-lib.org/reference/topic-inject.html), e.g.
`!!my_constant`.

Examples:

- `get_fill_color = color`: column accessor, referencing the "color"
  column

- `get_fill_color = "#ff0000"`: a constant value (red)

- `get_fill_color = !!color`: injects the value of `color` from the
  environment; if it's a name it will be a column with the value of
  `color` (e.g. color \<- as.name("my_color_column"))

- `get_fill_color = rlang::sym("my_color")`: column accessor,
  referencing "my_color" column

- `get_fill_color = scale_color_threshold(color)`: a threshold scale,
  which transforms the "color" column

## Accessors vs. Scales

Some parameters accept either an accessor or a
[`scale`](https://qfes.github.io/rdeck/reference/scale.md). Scales
transform numeric and categorical vectors into colours and numeric
values, and optionally render a legend; similar to ggplot scaling
aesthetics.

An accessor can perform this same task by *manually* transforming some
input into a vector of colours or numbers, but this is worse because:

- the transformed output (e.g. a colour vector) must be stored in the
  data (data bloat)

- visual representations aren't data

- legend won't be rendered

## Accessors vs. Values

Some parameters accept either an accessor or a value; `get_radius` is
such an example which accepts either a *scalar* `numeric` value, or an
`accessor` to a `numeric` column, or a `numeric`
[`scale`](https://qfes.github.io/rdeck/reference/scale.md). A value can
be thought of as accessor where all values in the referenced column are
the same (i.e. a constant column), but optimised for file size and
render speed.

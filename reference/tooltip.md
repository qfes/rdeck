# Prop Type: Tooltip

If `pickable == TRUE`, tooltip defines which columns (and their order)
will be displayed when an object is *hovered*. The tooltip will be
displayed as a transposed table (1 row per column) and is styled
according to the
[`rdeck()`](https://qfes.github.io/rdeck/reference/rdeck.md) `theme`.
The tooltip layout is inspired by [kepler.gl](https://kepler.gl).

![](https://user-images.githubusercontent.com/391385/103058202-57f26080-45ed-11eb-9131-f09585c1b894.png)

Tooltips support
[tidy-select](https://dplyr.tidyverse.org/reference/dplyr_tidy_select.html)
expressions (renaming isn't supported and will fail silently) and
boolean expressions. Tidy-select support is limited when layer `data` is
a URL or `NULL`.

Similar to
[`dplyr::select()`](https://dplyr.tidyverse.org/reference/select.html),
names are interpreted as column / field names. Use the [injection
operators](https://rlang.r-lib.org/reference/topic-inject.html) to pass
the value of a name from the environment, e.g. `!!my_column`.

## Always supported

Tooltips support different arguments depending on the value of the layer
`data`, but the following arguments are always supported:

- `NULL` \| `NA` \| `FALSE` -\> no tooltip

- `TRUE` -\> all columns. This will be translated to
  [`tidyselect::everything()`](https://tidyselect.r-lib.org/reference/everything.html)
  when data is a data frame or a tile json object

- character vector of column names, e.g. `c("foo", "bar")`

- a [`c()`](https://rdrr.io/r/base/c.html) expression of bare names,
  e.g. `c(foo, bar)`

- a bare name, e.g. `my_col`

## Data is a `data.frame` or `tile_json` object

When layer `data` is a
[`data.frame()`](https://rdrr.io/r/base/data.frame.html) or
[`tile_json()`](https://qfes.github.io/rdeck/reference/tile_json.md)
object, `tooltip` supports
[tidy-select](https://dplyr.tidyverse.org/reference/dplyr_tidy_select.html),
including selection helpers. The following are some examples of
supported expressions:

- `c(foo, bar)`

- [`tidyselect::everything()`](https://tidyselect.r-lib.org/reference/everything.html)

- `tidyselect::matches("foo")`,

- `-unwanted`

- `where(is.character) & matches("foo")`

- `1:6`

Like
[`dplyr::select()`](https://dplyr.tidyverse.org/reference/select.html),
referencing non-existent columns results in an error. Use
[`tidyselect::any_of()`](https://tidyselect.r-lib.org/reference/all_of.html)
to include columns that may not exist.

All geometry columns will be forcibly removed from the tooltip.

## Data is a `string` or `NULL`

There is no column / field name validation when When layer `data` is a
`string` (interpreted as a URL) or `NULL`. Including non-existent names
in the tooltip will *not* cause errors in the client; these columns will
be given a value of `null` in the rendered tooltip.

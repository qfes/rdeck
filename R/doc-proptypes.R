#' Prop Type: Accessor
#'
#' @description
#' Accessors map `data` columns to visual representations, primarily colours: `fill`, `line`,
#' `highlight` and sizes: `radius`, `elevation`, `width`, `height`.
#'
#' On the client, an accessor is translated to a javascript function that retrieves a value from
#' `data` for each object rendered. Constant columns will work fine, but aren't recommended as
#' they are less performant on render and bloat file size; prefer a constant _value_ for these
#' cases.
#'
#' See [accessors](https://deck.gl/docs/developer-guide/using-layers#accessors) for details.
#'
#' # Tidy-eval
#' Accessors support [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html) expressions.
#' Rules for referencing a column vs. a value from the environment is similar to [dplyr::mutate()],
#' main difference is that _all_ names are interpreted as columns, instead of falling back to the
#' environment when a column isn't found.
#'
#' Like [dplyr::mutate()], using string literals to reference columns isn't supported -- this will be
#' interpreted as a literal string. You may reference a column with:
#' - a bare name (e.g. `my_col`)
#' - a call evaluating [`name`], e.g. [as.name()], [rlang::sym()], etc
#' - by injecting a variable from the environment containing a `name` with `!!my_var`, or `{{ myvar }}`
#'
#' Literal expressions -- except calls evaluating a [`name`] or a [`scale`] -- will be interpreted as
#' constants and used for all features in a layer. To use the _value_ of a variable from the environment,
#' use the [injection operators][rlang::topic-inject], e.g. `!!my_constant`.
#'
#' # Accessors & Scales
#' Accessors may be used everywhere that scales can and can perform _almost_ the same function
#' (i.e. mapping data to a vector of numbers or [colours][color]), but there are downsides:
#' - larger file size
#' - no legend support
#'
#' Prefer scales over accessors where both are supported, and use accessors where scales aren't
#' supported (e.g. `get_path`) or where scaling functions aren't appropriate.
#'
#' @name accessor
#' @keywords internal
NULL

#' Prop Type: Scale
#'
#' @description
#' Scales transform input data into visual representations, predominantly colours:
#' `fill`, `line`, `highlight` and sizes: `radius`, `elevation`, `width`, `height`.
#'
#' Transformations are performed in client-side javascript, thus scales have very minimal
#' file-size overhead; what you _pay_ for is the source data being scaled, not the scale
#' itself. Additional scales referring the same column only _pay_ for that column once.
#' Adding fields being scaled to the tooltips have minimal overhead also, as this
#' data is already required for the scale.
#'
#' Data retrieved in the browser dynamically can also be scaled (including [mvt_layer()]). The R
#' interface for scaling dynamic data is identical to scaling `data.frame` columns, but there is
#' no R-validation for this (i.e. your scale can refer a non-existent column, which will error in
#' javascript, but not in R).
#'
#' # Tidy-eval
#' Columns referenced by a scale support [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html)
#' expressions. The `col` parameter for a scale must be a valid argument to [rlang::ensym()] and follows
#' the same rules. Use the [injection operators][rlang::topic-inject] to pass the value of a name
#' from the environment, e.g. `!!my_column`.
#'
#' # Legend
#' Scales can optionally produce a colour or numeric legend in the client. Numeric legends give
#' context for which visual field is being scaled and by what column; colour legends additionally
#' provide a colour scale and _untransformed_ ticks.
#'
#' Legend ticks can be formatted with a format function (e.g. [scales::label_number()]). This function can
#' completely replace the input ticks if you wish; the only constraint is the return value is a character
#' vector of the same length as the number of _unformatted ticks_.
#'
#' Legends are [kepler.gl](https://kepler.gl) inspired.
#' \if{html}{\out{
#'   <div class="text-center">
#'     <img src="https://user-images.githubusercontent.com/391385/103058278-7b1d1000-45ed-11eb-86d2-7ab594bb32de.png" />
#'   </div>
#' }}
#'
#' # Available scales
#' - [`scale_linear`]
#' - [`scale_power`]
#' - [`scale_log`]
#' - [`scale_symlog`]
#' - [`scale_threshold`]
#' - [`scale_quantile`]
#' - [`scale_category`]
#' - [`scale_quantize`]
#'
#' @name scale
#' @keywords internal
NULL

#' Prop Type: Tooltip
#'
#' @description
#' If `pickable == TRUE`, tooltip defines which columns (and their order) will be displayed
#' when an object is _hovered_. The tooltip will be displayed as a transposed table (1 row
#' per column) and is styled according to the [`rdeck`] `theme`. The tooltip layout is inspired
#' by [kepler.gl](https://kepler.gl).
#'
#' \if{html}{\out{
#'   <div class="text-center">
#'     <img src="https://user-images.githubusercontent.com/391385/103058202-57f26080-45ed-11eb-9131-f09585c1b894.png" />
#'   </div>
#' }}
#'
#' Tooltips support different arguments depending on the value of `data`, but the following
#' arguments are always supported:
#' - `NULL` | `NA` | `FALSE` -> no tooltip
#' - `TRUE` -> all columns (except `sfc` columns)
#'
#' # Data inherits `data.frame`
#' When `data` is a `data.frame`, tooltip supports
#' [tidy-select](https://dplyr.tidyverse.org/reference/dplyr_tidy_select.html) (renaming isn't
#' supported). Expressions such as `c(foo, bar)`, `everything()`, `matches("foo")`, `-unwanted`,
#' `1:6` etc. are supported.
#'
#' All columns referenced in tooltip must exist.
#'
#' # Data is a `string` or `NULL`
#' For cases where data is absent (tooltip wouldn't be displayed anyway), or dynamically loaded
#' in the client, tooltips may take a character vector of column names, or a `c()` expression
#' of bare names (e.g. `c(foo, bar)`).
#'
#' No validation on these columns is possible in this case.
#'
#' @name tooltip
#' @keywords internal
NULL

#' Prop Type: Color
#'
#' Colours are represented by `RGB` or `RGBA` hex strings.
#' Example: `#663399ff` \if{html}{\out{<img width="20" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVQYV2NIM575HwAEZwIytoDTwwAAAABJRU5ErkJggg==" />}}
#'
#' @name color
#' @keywords internal
NULL

#' Prop Type: Accessor
#'
#' @description
#' Accessors map `data` columns to visual representations, primarily colours: `fill`, `line`,
#' `highlight` and sizes: `radius`, `elevation`, `width`, `height`.
#'
#' Columns referenced by an accessor support
#' [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html) expressions. Passing
#' a string literal to reference a column isn't supported (this will be interpreted as a literal
#' string), however you may pass a bare name (`my_col`) or an unquoted variable (`!!my_var` or
#' `{{my_var}}`).
#'
#' On the client, an accessor is translated to a javascript function that retrieves a value from
#' `data` for each object rendered. Constant columns will work fine, but aren't recommended as
#' they are less performant on rendering and bloat file size; prefer a constant value for these
#' cases.
#'
#' See [accessors](https://deck.gl/docs/developer-guide/using-layers#accessors) for details.
#'
#' # Accessors vs Scales
#' Accessors may be used everywhere that scales can, and can perform _almost_ the same function
#' (i.e. mapping data to a vector of numbers or [colours][color]), but there are downsides:
#' - generally larger file size
#' - no legend support
#'
#' It is recommended to only use accessors where scales aren't supported (e.g. `get_path`) or
#' where scaling functions aren't appropriate.
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
#' Columns referenced by a scale support string literals and
#' [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html) expressions. Columns
#' may be bare names (`my_col`), string literals (`"my_col"`), or unquoted expressions
#' (`!!my_var` or `{{my_var}}`).
#'
#' Transformations are performed in client-side javascript, thus scales have very minimal
#' file-size overhead; what you pay for is the source data being _scaled_, not the scale
#' itself. Additional scales referring the same column only _pay_ for that column once.
#' Adding fields being _scaled_ to the tooltips have minimal overhead also, as this
#' data is already required for the scale.
#'
#' Data retrieved in the browser dynamically can also be scaled. The R interface for scaling
#' dynamic data is identical to scaling `data.frame` columns, but there is no R-validation for
#' this (i.e. your scale can refer a non-existent column, which will error in javascript, but
#' not in R).
#'
#' # Legend
#' Scales can optionally produce a colour or numeric legend in the client. Numeric legends give
#' context for which visual field is being scaled and by what column; colour legends additionally
#' provide a colour scale and _untransformed_ ticks.
#'
#' Legend ticks can be formatted with a format function. This function can completely replace the
#' input ticks if you wish; the only constraint is the return value is a character vector of the
#' same length as the number of _unformatted ticks_.
#'
#' # Available scales
#' - [`scale_linear`]
#' - [`scale_power`]
#' - [`scale_log`]
#' - [`scale_quantize`]
#' - [`scale_quantile`]
#' - [`scale_threshold`]
#' - [`scale_category`]
#'
#' @name scale
#' @keywords internal
NULL

#' Prop Type: Tooltip
#'
#' @name tooltip
#' @keywords internal
NULL

#' Prop Type: Color
#'
#' Colours are represented by `RGB` or `RGBA` hex strings.
#' Example: `#663399ff` \if{html}{\out{#' <img width="20" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVQYV2NIM575HwAEZwIytoDTwwAAAABJRU5ErkJggg==" />}}
#'
#' @name color
#' @keywords internal
NULL

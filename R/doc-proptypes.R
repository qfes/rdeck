#' Prop Type: Accessor
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
#' file-size overhead; what you pay for this the source data being _scaled_, not the scale
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
#' provide a colour scale and _untransformed_ ticks (i.e. you will see the ticks in the original
#' representation, not the transformed representation).
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

#' Power transformation
#'
#' Applies an exponential transform of the input: `y = abs(x)^k`, where:
#' - `x` is the input vector
#' - `k` is the exponent
#'
#' @details
#' If `x` is negative, the result is multiplied by -1.
#'
#' @name power_trans
#' @param exponent <`number`> The power exponent
#'
#' @family transform
#' @export
power_trans <- function(exponent = 0.5) {
  tidyassert::assert(
    rlang::is_scalar_double(exponent) ||
    rlang::is_scalar_integer(exponent)
  )

  scales::trans_new(
    paste0("power-", exponent),
    function(x) sign0(x) * abs(x)^exponent,
    function(x) sign0(x) * abs(x)^(1 / exponent)
  )
}


#' Log transformation
#'
#' Applies a log transform on the input: `y = log(abs(x), b)`, where:
#' - `x` is the input vector
#' - `b` is the log base
#'
#' @details
#' If `x` is negative, the result is multiplied by -1.
#'
#' This transform requires that the input range doesn't cross zero. Transforming an input
#' that crosses 0 will succeed and give predictable output, but its inverse will not, due
#' to unsigned 0 (i.e. -1 * log(1) == log(1)).
#'
#' @name log_trans
#' @param base <`number`> The log base
#'
#' @family transform
#' @export
log_trans <- function(base = exp(1)) {
  tidyassert::assert(
    is.numeric(base) && length(base) == 1 &&
    base > 0 && base != 1
  )

  scales::trans_new(
    paste0("log-", base),
    function(x) sign0(x) * log(abs(x), base),
    function(x) {
      finite_x <- x[is.finite(x)]
      # range cannot cross zero
      tidyassert::assert(
        !all(c(-1, 1) %in% sign(finite_x)),
        "input range must not cross zero"
      )

      # absolute value for all finite x
      abs_x <- replace(abs(x), x == -Inf, -Inf)
      min(sign0(finite_x)) * base^abs_x
    }
  )
}


#' SymLog transformation
#'
#' Applies a log1p transform: `y = log1p(abs(x))`, where:
#' - `x` is the input vector
#'
#' @name symlog_trans
#' @inherit power_trans details
#'
#' @family transform
#' @export
symlog_trans <- function() {
  scales::trans_new(
    "symlog",
    function(x) sign0(x) * log1p(abs(x)),
    function(x) sign0(x) * expm1(abs(x))
  )
}

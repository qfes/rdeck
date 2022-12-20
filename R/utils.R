#' Cur value
#'
#' @description
#' A sentinel object that represents the current value in the browser. Use this value
#' to indicate that a map / layer property should remain unchanged.
#'
#' Intended for use in shiny applications.
#'
#' @examples
#' \dontrun{
#' rdeck_proxy("map") %>%
#'   set_layer_visibility("layer_id", visible = cur_value(), visibility_toggle = TRUE)
#' }
#' @name cur_value
#' @keywords internal
#' @export
cur_value <- function() structure(list(), class = "cur_value")

is_cur_value <- function(object) inherits(object, "cur_value")

# extension of sign, where 0 is treated as positive
sign0 <- function(x) (x >= 0L) - (x < 0L)

# are a and b approximately equal?
isapprox <- function(a, b, tol = sqrt(.Machine$double.eps)) {
  abs(a - b) < abs(tol)
}

# levels of categorical data
get_levels <- function(x) if (is.factor(x)) levels(x) else unique(x)

# add class
add_class <- function(object, new_class, pos = 1L) {
  set_class(object, append(class(object), new_class, pos - 1L))
}

# set class
set_class <- `class<-`

as_class <- function(x) structure(x, class = x)

# replace value
set_value <- function(x, i, value) `[[<-`(x, i, value = value)

set_null <- function(x, i) `[<-`(x, i, value = list(NULL))

# set most attributes
set_mostattributes <- `mostattributes<-`

# vapply shorthands
vlapply <- function(x, fn, ..., named = TRUE) vapply(x, fn, logical(1), ..., USE.NAMES = named)
vcapply <- function(x, fn, ..., named = TRUE) vapply(x, fn, character(1), ..., USE.NAMES = named)

# expects arg be embraced
enstring <- function(arg) rlang::as_name(rlang::ensym(arg))

ramp_n <- function(n) seq.int(0, 1, length.out = n)

drop_ends <- function(x) x[-c(1, length(x))]

n_unique <- function(x, na_rm = FALSE) {
  unique_x <- unique(x)
  if (na_rm) length(unique_x[!is.na(unique_x)]) else length(unique_x)
}

# from {scales} + treat integer as discrete
is_discrete <- function(x) is.factor(x) || is.character(x) || is.logical(x) || rlang::is_integerish(x)

# is an rgba hex colour vector
is_rgba_color <- function(x) grepl("^#([0-9A-F]{6}|[0-9A-F]{8})$", x, ignore.case = TRUE)

is_js_eval <- function(object) inherits(object, "JS_EVAL")

is_dataframe <- function(object) inherits(object, "data.frame")

is_absolute_url <- function(object) !is.na(urltools::scheme(object))

all_finite <- function(x) all(is.finite(x))

as_png <- function(image) add_class(png::writePNG(image), "png")

# nullish coalesce, where length-0 is treated as null
`%??%` <- function(a, b) if(length(a) == 0) b else a

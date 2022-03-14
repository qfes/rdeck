#' MVT URL
#'
#' Make a mapbox vector tile url template
#' @name mvt_url
#' @param tileset_id A mapbox tileset identifier of the form:
#'
#' - `mapbox.mapbox-streets-v8`, or
#' - `mapbox://mapbox.mapbox-streets-v8`
#'
#' @seealso mvt_layer
#' @export
mvt_url <- function(tileset_id) {
  mvt_endpoint <- "https://api.mapbox.com/v4"
  xyz_template <- "{z}/{x}/{y}.vector.pbf"
  id <- sub("mapbox://", "", tileset_id)

  url <- file.path(mvt_endpoint, id, xyz_template, fsep = "/") %>%
    urltools::param_set("access_token", mapbox_access_token())
}

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

# replace value
set_value <- `[[<-`

# set most attributes
set_mostattributes <- `mostattributes<-`

# vapply shorthands
vlapply <- function(x, fn, ..., named = TRUE) vapply(x, fn, logical(1), ..., USE.NAMES = named)
vcapply <- function(x, fn, ..., named = TRUE) vapply(x, fn, character(1), ..., USE.NAMES = named)

# dplyr-like select for lists
#' @global where
#' @noRd
select <- function(lst, ...) {
  pos <- tidyselect::eval_select(rlang::expr(c(...)), unclass(lst), )
  attrs <- purrr::list_modify(attributes(lst), names = names(pos))
  set_mostattributes(lst[pos], attrs)
}

# dplyr-like rename for lists
rename <- function(lst, ...) {
  pos <- tidyselect::eval_rename(rlang::expr(c(...)), unclass(lst))
  names(lst)[pos] <- names(pos)

  lst
}

# dplyr-like mutate for lists
mutate <- function(lst, ...) {
  quos <- rlang::enquos(..., .named = TRUE, .ignore_empty = "all", .check_assign = TRUE)
  nms <- rlang::names2(quos)

  purrr::reduce2(
    nms,
    quos,
    .init = lst,
    function(lst, nm, quo) set_value(lst, nm, rlang::eval_tidy(quo, lst))
  )
}

# expects arg be embraced
enstring <- function(arg) rlang::as_name(rlang::ensym(arg))

ramp_n <- function(n) seq.int(0, 1, length.out = n)

drop_ends <- function(x) x[-c(1, length(x))]

# from {scales}
is_discrete <- function(x) is.factor(x) || is.character(x) || is.logical(x)

# is an rgba hex colour vector
is_rgba_color <- function(x) grepl("^#([0-9A-F]{6}|[0-9A-F]{8})$", x, ignore.case = TRUE)

is_js_eval <- function(object) inherits(object, "JS_EVAL")

is_dataframe <- function(object) inherits(object, "data.frame")

all_finite <- function(x) all(is.finite(x))

# nullish coalesce, where length-0 is treated as null
`%??%` <- function(a, b) if(length(a) == 0) b else a

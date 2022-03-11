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

discard_null <- function(obj) {
  obj_filtered <- obj[!vapply(obj, is.null, logical(1))]
  mostattributes(obj_filtered) <- c(attributes(obj), names = names(obj_filtered))

  obj_filtered
}

pick <- function(obj, names) {
  obj_filtered <- obj[base::names(obj) %in% names]
  class(obj_filtered) <- class(obj)

  obj_filtered
}

omit <- function(obj, names) {
  obj_filtered <- obj[!base::names(obj) %in% names]
  class(obj_filtered) <- class(obj)

  obj_filtered
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
add_class <- function(obj, new_class, pos = 1L) {
  class(obj) <- append(class(obj), new_class, pos - 1L)
  obj
}

# set class
set_class <- `class<-`

# replace value
set_value <- `[[<-`

# vapply shorthands
vapply_l <- function(x, fn, ..., named = TRUE) vapply(x, fn, logical(1), ..., USE.NAMES = named)
vapply_c <- function(x, fn, ..., named = TRUE) vapply(x, fn, character(1), ..., USE.NAMES = named)

# dplyr-like select for lists
select <- function(lst, ...) {
  pos <- tidyselect::eval_select(rlang::expr(c(...)), unclass(lst), )
  lst_subset <- rlang::set_names(lst[pos], names(pos))

  set_class(lst_subset, class(lst))
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

# obj is an rgba hex colour vector
is_rgba_color <- function(obj) grepl("^#([0-9A-F]{6}|[0-9A-F]{8})$", obj, ignore.case = TRUE)

is_js_eval <- function(obj) inherits(obj, "JS_EVAL")

is_sfc <- function(obj) inherits(obj, "sfc")

all_finite <- function(x) all(is.finite(x))

# nullish coalesce, where length-0 is treated as null
`%??%` <- function(a, b) if(length(a) == 0) b else a

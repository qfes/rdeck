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

paste_line <- function(...) {
  paste(c(...), collapse = "\n")
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

select <- function(lst, ...) {
  pos <- tidyselect::eval_select(rlang::expr(c(...)), unclass(lst))
  rlang::set_names(lst[pos], names(pos))
}

rename <- function(lst, ...) {
  pos <- tidyselect::eval_rename(rlang::expr(c(...)), unclass(lst))
  names(lst)[pos] <- names(pos)

  lst
}

# expects arg be embraced
enstring <- function(arg) rlang::as_name(rlang::ensym(arg))

# obj is an rgba hex colour vector
is_rgba_color <- function(obj) grepl("^#([0-9A-F]{6}|[0-9A-F]{8})$", obj, ignore.case = TRUE)

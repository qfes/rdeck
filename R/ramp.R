# a linear colour ramp for continuous input
color_gradient <- function(palette) {
  UseMethod("color_gradient")
}

#' @export
color_gradient.character <- function(palette) {
  tidyassert::assert(is_rgba_color(palette))
  color_gradient(function(n) palette)
}

#' @export
color_gradient.function <- function(palette) {
  # function is a ramp built with scales::colour_ramp
  if (isTRUE(attr(palette, "safe_palette_func"))) return(palette)

  # assume palette takes a length param
  function(x) {
    colors <- suppressWarnings(palette(256))
    ramp <- scales::colour_ramp(colors[!is.na(colors)])
    ramp(x)
  }
}


# a linear colour ramp for discrete input
color_categories <- function(palette) {
  UseMethod("color_categories")
}

#' @export
color_categories.character <- function(palette) {
  tidyassert::assert(is_rgba_color(palette))
  color_categories(scales::manual_pal(palette))
}

#' @export
color_categories.function <- function(palette) {
  rescale <- function(x, levels) scales::rescale(match(x, levels))

  # function is a ramp built with scales::colour_ramp
  if (isTRUE(attr(palette, "safe_palette_func"))) {
    ramp <- function(x) {
      levels <- get_levels(x)
      palette(rescale(x, levels))
    }
    return(ramp)
  }

  # assume palette takes a length param
  function(x) {
    levels <- get_levels(x)
    colors <- palette(length(levels))
    ramp <- scales::colour_ramp(colors[!is.na(colors)])
    ramp(rescale(x, levels))
  }
}


# a linear numeric ramp for continous input
number_gradient <- function(seq) {
  UseMethod("number_gradient")
}

#' @export
number_gradient.numeric <- function(seq) {
  tidyassert::assert(all_finite(seq) && length(seq) >= 2)
  stats::approxfun(scales::rescale(seq_along(seq)), seq)
}

#' @export
number_gradient.integer <- number_gradient.numeric


# a linear numeric ramp for discrete input
number_categories <- function(seq) UseMethod("number_categories")

#' @export
number_categories.numeric <- function(seq) {
  tidyassert::assert(all_finite(seq) && length(seq) >= 2)
  seq_pal <- scales::manual_pal(seq)

  function(x) {
    levels <- get_levels(x)
    # pull at least 2 values
    values <- seq_pal(max(length(levels), 2))
    ramp <- number_gradient(values[!is.na(values)])
    ramp(scales::rescale(match(x, levels)))
  }
}

#' @export
number_categories.integer <- number_categories.numeric

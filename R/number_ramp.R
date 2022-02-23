# a linear numeric ramp for continous input
number_gradient <- function(seq) {
  UseMethod("number_gradient")
}

number_gradient.numeric <- function(seq) {
  tidyassert::assert(is.finite(seq))
  stats::approxfun(scales::rescale(seq_along(seq)), seq)
}

number_gradient.integer <- number_gradient.numeric

# a linear numeric ramp for discrete input
number_categories <- function(seq) UseMethod("number_categories")

number_categories.numeric <- function(seq) {
  seq_pal <- scales::manual_pal(seq)

  function(x) {
    levels <- get_levels(x)
    values <- seq_pal(length(levels))
    ramp <- number_gradient(values[!is.na(values)])
    ramp(scales::rescale(match(x, levels)))
  }
}

number_categories.integer <- number_categories.numeric

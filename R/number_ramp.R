# a linear numeric ramp for continous input
number_gradient <- function(seq) {
  UseMethod("number_gradient")
}

number_gradient.numeric <- function(seq) {
  stats::approxfun(scales::rescale(seq_along(seq)), seq)
}

number_gradient.integer <- number_gradient.numeric

# a linear numeric ramp for discrete input
number_categories <- function(seq) UseMethod("number_categories")

number_categories.numeric <- function(seq) {
  ramp <- number_gradient.numeric(seq)

  function(x) {
    levels <- get_levels(x)
    ramp(scales::rescale(match(x, levels)))
  }
}

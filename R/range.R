# initialise a continuous range
continuous_range <- function(limits = NULL) {
  rng <- scales::ContinuousRange$new()
  rng$train(limits)
  rng
}


# initialise a discrete range
discrete_range <- function(levels = NULL) {
  rng <- scales::DiscreteRange$new()
  # ensure input order is preserved
  if (!is.factor(levels)) {
    lvls <- unique(levels)
    levels <- factor(lvls, lvls)
  }
  rng$train(levels)
  rng
}


# initialise a continuous identity range
continuous_identity_range <- function(x = NULL) {
  rng <- ContinuousIdentityRange$new()
  rng$train(x)
  rng
}

# mutable continuous identity range
ContinuousIdentityRange <- R6::R6Class(
  "ContinuousIdentityRange",
  inherit = scales::Range,
  list(
    train = function(x) {
      tidyassert::assert(is.null(x) || is.numeric(x), "discrete data supplied to continuous scale")
      self$range <- x
    },
    reset = function() self$range <- NULL
  )
)

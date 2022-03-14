# initialise a continuous range
continuous_range <- function(limits = NULL) {
  rng <- scales::ContinuousRange$new()
  rng$train(limits)
  rng
}


# initialise a discrete range
discrete_range <- function(levels = NULL) {
  rng <- DiscreteRange$new()
  rng$train(levels)
  rng
}

# re-implementation of scales::DiscreteRange, with the following changes:
# - input order preserved for non-factor input
# - doesn't coerce logical as string
DiscreteRange <- R6::R6Class(
  "DiscreteRange",
  inherit = scales::Range,
  list(
    train = function(x) {
      if (is.null(x)) return()

      tidyassert::assert(is_discrete(x), "Continuous value supplied to discrete scale")
      lvls <- if (is.factor(x)) levels(x) else unique(x)
      lvls <- lvls[!is.na(lvls)]
      self$range <- unique(c(self$range, lvls))
    },
    reset = function() self$range <- NULL
  )
)


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
      if (is.null(x)) return()

      tidyassert::assert(is.numeric(x), "Discrete data supplied to continuous scale")
      self$range <- c(self$range, x)
    },
    reset = function() self$range <- NULL
  )
)

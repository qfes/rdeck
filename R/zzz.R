
.onLoad <- function(...) {
  # @importMethodsFrom jsonlite asJSON
  # HACK: jsonlite asJSON isn't exported, but should be
  # https://github.com/jeroen/jsonlite/issues/62
  setGeneric("asJSON", getGeneric("asJSON", package = "jsonlite"))
  invisible()
}

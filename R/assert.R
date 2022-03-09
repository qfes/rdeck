check_dots <- function(...) {
  dots <- rlang::dots_list(...)
  dots_names <- names(dots)

  if (!all(nzchar(dots_names))) {
    rlang::abort(
      paste0("All dots must be named."),
      class = "rdeck_dots_unnamed"
    )
  }

  if (length(dots) != 0) {
    rlang::warn(
      paste_line(
        "These dots are unrecognised arguments that will be forwarded to Deck.GL javascript:",
        paste0("  * `", dots_names, "` -> `", to_camel_case(dots_names), "`")
      ),
      class = "rdeck_dots_nonempty"
    )
  }
}

check_dots_access_token <- function(...) {
  dots <- rlang::dots_list(...)
  dots_names <- names(dots)

  if (any(dots_names == "mapbox_api_access_token")) {
    rlang::warn(
      paste_line(
        "mapbox_api_access_token should be supplied via one of:",
        "  * `options(rdeck.mapbox_access_token)",
        "  * `environment variable MAPBOX_ACCESS_TOKEN",
        "  * `environment variable MAPBOX_TOKEN",
        "",
        "see ?mapbox_access_token"
      ),
      class = "rdeck_dots_access_token"
    )
  }
}

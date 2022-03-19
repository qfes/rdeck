#' Mapbox access token
#'
#' @description
#' A mapbox access token is required for rendering the mapbox basemap (regardless of tiles used)
#' and mapbox services (tiles). To use a basemap, you need to register for a
#' [mapbox account](https://account.mapbox.com/auth/signup). Mapbox has a generous free tier.
#'
#' Each rdeck map _rendered_ equates to a
#' [map load for web](https://www.mapbox.com/pricing/#maploads).
#'
#' @details
#' The mapbox token is read from the following locations (in order):
#' - `getOption("rdeck.mapbox_access_token")`
#' - `Sys.getenv("MAPBOX_ACCESS_TOKEN")`
#' - `Sys.getenv("MAPBOX_TOKEN")`
#'
#' @name mapbox_access_token
#' @seealso <https://docs.mapbox.com/help/glossary/access-token>
#'
#' @export
mapbox_access_token <- function() {
  option <- "rdeck.mapbox_access_token"
  token <- getOption(option)
  if (!is.null(token)) {
    return(token)
  }

  var_names <- c("MAPBOX_ACCESS_TOKEN", "MAPBOX_TOKEN")
  vars <- Sys.getenv(var_names) %>%
    unname()

  tokens <- vars[vars != ""]

  tidyassert::warn_if(
    length(tokens) == 0,
    c(
      "!" = "No mapbox access token found, mapbox basemap won't be shown.",
      "i" = "Set mapbox token with one of:",
      "option `options({option} = <token>)`",
      paste0("environment variable `", var_names, " = <token>`"),
      " " = "",
      "i" = "See {.url https://docs.mapbox.com/help/glossary/access-token}"
    ),
    option = option
  )

  utils::head(tokens, 1) %??% NULL
}


tile_service <- function() {
  service <- getOption("rdeck.tile_service") %||% "mapbox"
  tidyassert::assert(rlang::is_string(service))

  service
}

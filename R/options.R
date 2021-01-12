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
#' - `Sys.getenv("MAPBOX_TOKEN")
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

  vars <- Sys.getenv(c("MAPBOX_ACCESS_TOKEN", "MAPBOX_TOKEN")) %>%
    unname()

  tokens <- vars[vars != ""]
  if (length(tokens) == 0) {
    rlang::warn(
      paste_line(
        "No mapbox access token found, mapbox basemap won't be shown.",
        "Set mapbox token with one of:",
        paste0("  * option `options(", option, " = <token>)`."),
        "  * environment variable `MAPBOX_ACCESS_TOKEN = <token>`.",
        "  * environment variable `MAPBOX_TOKEN = <token>`.",
        "",
        "See https://docs.mapbox.com/help/glossary/access-token"
      ),
      class = "rdeck_error_token"
    )

    return(NULL)
  }

  utils::head(tokens, 1)
}

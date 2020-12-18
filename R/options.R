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
      paste0(
        "No mapbox access token found, mapbox basemap won't be shown.\n",
        "Set mapbox token with `options(", option, " = <token>)`",
        " or environment variable MAPBOX_ACCESS_TOKEN = <token>.\n\n",
        "See https://docs.mapbox.com/help/glossary/access-token"
      ),
      class = "rdeck_error_token"
    )

    return(NULL)
  }

  utils::head(tokens, 1)
}

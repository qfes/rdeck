#' Create rdeck widget
#'
#' @name rdeck
#' @param mapbox_api_access_token `{character}`
#' @param map_style `{character}`
#' @param width `{numeric}`
#' @param height `{numeric}`
#' @param elementId `{character}`
#' @param ... additional parameters to pass to deck
#' @return `{rdeck}`
#'
#' @export
rdeck <- function(mapbox_api_access_token = Sys.getenv("MAPBOX_ACCESS_TOKEN"),
                  map_style = "mapbox://styles/mapbox/dark-v10",
                  width = NULL,
                  height = NULL,
                  elementId = NULL,
                  ...) {
  params <- list(
    mapbox_api_access_token = mapbox_api_access_token,
    map_style = map_style,
    ...
  )

  names(params) <- snakecase::to_lower_camel_case(names(params))

  # create widget
  htmlwidgets::createWidget(
    name = "rdeck",
    x = structure(
      list(
        props = params,
        layers = list()
      ),
      TOJSON_ARGS = list(digits = 9)
    ),
    width = width,
    height = height,
    sizingPolicy = htmlwidgets::sizingPolicy(
      defaultWidth = "100%",
      defaultHeight = 400,
      padding = 0,
      browser.fill = TRUE,
    ),
    elementId = elementId,
    dependencies = dependencies
  )
}

#' Manually create the container to have control of dependency order
#'
#' @name rdeck_html
#' @param id `{character}`
#' @param style `{character}`
#' @param class `{character}`
#' @param ... required by htmlwidgets
#' @return `{rdeck}`
rdeck_html <- function(id, style, class, ...) {
  container <- htmltools::tags$div(
    id = id,
    style = style,
    class = class
  ) %>%
    htmltools::attachDependencies(dependencies)
}

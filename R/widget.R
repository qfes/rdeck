#' Create rdeck widget
#'
#' @name rdeck
#' @param mapbox_api_access_token [`character`]
#'  The api access token to use mapbox tiles.
#'
#' @param map_style [`character`]
#'  A mapbox style url. \url{https://docs.mapbox.com/api/maps/#mapbox-styles}
#'
#' @param initial_bounds [`bounds`]
#'  The initial bounds of the map; overwrites `initial_view_state`.
#'
#' @param initial_view_state [`view_state`]
#'  The initial view state of the map. See [view_state] for details.
#'
#' @param layers [`list`]
#'  The list of deck.gl layers.
#'
#' @param controller [`logical`]
#'  If `NULL` or `FALSE`, the map is not interactive.
#'
#' @param picking_radius [`numeric`]
#'  Extra pixels around the pointer to include while picking.
#'
#' @param use_device_pixels [`logical`] | [`numeric`]
#'  Controls the resolution of drawing buffer used for rendering.
#'
#' @param width [`numeric`]
#'  Width of the map
#'
#' @param height [`numeric`]
#'  Height of the map
#'
#' @param elementId [`character`]
#'  element id for the map.
#'
#' @param ... additional parameters to pass to the [Deck](https://github.com/uber/deck.gl/blob/master/docs/api-reference/deck.md).
#'
#' @return [`rdeck`]
#'  An rdeck widget for a deck.gl map
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/master/docs/api-reference/deck.md}
#'
#' @export
rdeck <- function(mapbox_api_access_token = Sys.getenv("MAPBOX_ACCESS_TOKEN"),
                  map_style = "mapbox://styles/mapbox/dark-v10",
                  initial_bounds = NULL,
                  initial_view_state = NULL,
                  layers = NULL,
                  controller = TRUE,
                  picking_radius = 0,
                  use_device_pixels = TRUE,
                  width = NULL,
                  height = NULL,
                  elementId = NULL,
                  ...) {
  if (is.null(layers)) {
    layers <- list()
  }

  props <- list(
    mapbox_api_access_token = mapbox_api_access_token,
    map_style = map_style,
    initial_bounds = initial_bounds,
    initial_view_state = initial_view_state,
    controller = controller,
    picking_radius = picking_radius,
    use_device_pixels = use_device_pixels,
    ...
  ) %>%
    Filter(x = ., function(x) !is.null(x))

  names(props) <- snakecase::to_lower_camel_case(names(props))

  # create widget
  htmlwidgets::createWidget(
    name = "rdeck",
    x = structure(
      list(
        props = props,
        layers = layers
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
#' @param id [`character`]
#' @param style [`character`]
#' @param class [`character`]
#' @param ... required by htmlwidgets
#' @return [`rdeck`]
#'
#' @keywords internal
rdeck_html <- function(id, style, class, ...) {
  container <- htmltools::tags$div(
    id = id,
    style = style,
    class = class
  ) %>%
    htmltools::attachDependencies(dependencies)
}

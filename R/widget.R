#' RDeck
#'
#' Create a Deck.GL map.
#'
#' @name rdeck
#' @param mapbox_api_access_token `character`
#'  The api access token to use mapbox tiles.
#'
#' @param map_style `character`
#'  A mapbox style url. <https://docs.mapbox.com/api/maps/#mapbox-styles>
#' 
#' @param theme The widget theme. Either "kepler" or "light".
#'
#' @param initial_bounds `sf::st_bbox` | `sf::sf` | `sf::sfc` | `sf::sfg`
#'  The initial bounds of the map; overwrites `initial_view_state`.
#'
#' @param initial_view_state `view_state`
#'  The initial view state of the map. See [view_state()] for details.
#'
#' @param layers `list`
#'  The list of deck.gl layers.
#'
#' @param controller `logical`
#'  If `NULL` or `FALSE`, the map is not interactive.
#'
#' @param picking_radius `numeric`
#'  Extra pixels around the pointer to include while picking.
#'
#' @param use_device_pixels `logical` | `numeric`
#'  Controls the resolution of drawing buffer used for rendering.
#'
#' @param width `numeric`
#'  Width of the map
#'
#' @param height `numeric`
#'  Height of the map
#'
#' @param elementId `character`
#'  Element id for the map.
#'
#' @param ... additional parameters to pass to the `Deck`.
#'
#' @seealso <https://github.com/uber/deck.gl/blob/master/docs/api-reference/deck.md>
#'
#' @export
rdeck <- function(mapbox_api_access_token = NULL,
                  map_style = "mapbox://styles/mapbox/dark-v10",
                  theme = "kepler",
                  initial_bounds = NULL,
                  initial_view_state = view_state(
                    center = c(0, 0),
                    zoom = 0
                  ),
                  layers = list(),
                  controller = TRUE,
                  picking_radius = 0,
                  use_device_pixels = TRUE,
                  width = NULL,
                  height = NULL,
                  elementId = NULL,
                  ...) {
  mapbox_api_access_token <- mapbox_api_access_token %||% mapbox_access_token()

  if (!is.null(initial_bounds)) {
    assert_type(initial_bounds, c("bbox", "sf", "sfc", "sfg"))
    initial_bounds <- sf::st_as_sfc(initial_bounds) %>%
      sf::st_transform(4326) %>%
      sf::st_bbox()
  }

  props <- structure(
    c(
      list(
        mapbox_api_access_token = mapbox_api_access_token,
        map_style = map_style,
        initial_bounds = initial_bounds,
        initial_view_state = initial_view_state,
        controller = controller,
        picking_radius = picking_radius,
        use_device_pixels = use_device_pixels
      ),
      rlang::dots_list(...)
    ),
    class = "rdeck_props"
  )

  x <- structure(
    list(
      props = props,
      layers = layers,
      theme = theme
    ),
    TOJSON_ARGS = list(
      digits = 9,
      keep_vec_names = FALSE
    )
  )

  # create widget
  htmlwidgets::createWidget(
    name = "rdeck",
    x = x,
    width = width,
    height = height,
    sizingPolicy = htmlwidgets::sizingPolicy(
      defaultWidth = "100%",
      defaultHeight = 400,
      padding = 0,
      browser.fill = TRUE,
    ),
    elementId = elementId,
    preRenderHook = function(rdeck) to_json(rdeck)
  )
}

#' Layers
#'
#' Get map layers
#' @name layers
#' @param rdeck an rdeck instance
#' @export
layers <- function(rdeck) {
  assert_type(rdeck, "rdeck")

  rdeck$x$layers
}

add_layer <- function(rdeck, layer) {
  assert_type(rdeck, "rdeck")
  assert_type(layer, "layer")

  rdeck$x$layers <- c(layers(rdeck), list(layer))
  rdeck
}

#' Props
#'
#' Get map props
#' @name props
#' @param rdeck an rdeck instance
#' @export
props <- function(rdeck) {
  assert_type(rdeck, "rdeck")

  rdeck$x$props
}

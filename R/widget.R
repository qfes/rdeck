#' RDeck
#'
#' Create a Deck.GL map.
#'
#' @name rdeck
#' @inheritParams layer_props
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
#' @param controller `logical`
#'  If `NULL` or `FALSE`, the map is not interactive.
#'
#' @param picking_radius `numeric`
#'  Extra pixels around the pointer to include while picking.
#'
#' @param use_device_pixels `logical` | `numeric`
#'  Controls the resolution of drawing buffer used for rendering.
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
#' @seealso <https://github.com/visgl/deck.gl/blob/v8.3.13/docs/api-reference/core/deck.md>
#'
#' @export
rdeck <- function(mapbox_api_access_token = NULL,
                  map_style = mapbox_dark(),
                  theme = "kepler",
                  initial_bounds = NULL,
                  initial_view_state = view_state(
                    center = c(0, 0),
                    zoom = 1
                  ),
                  controller = TRUE,
                  picking_radius = 0,
                  use_device_pixels = TRUE,
                  blending_mode = "normal",
                  width = NULL,
                  height = NULL,
                  elementId = NULL,
                  ...) {
  if (missing(mapbox_api_access_token)) {
    mapbox_api_access_token <- mapbox_access_token()
  }

  props <- rdeck_props(
    mapbox_api_access_token = mapbox_api_access_token,
    map_style = map_style,
    initial_bounds = if (!is.null(initial_bounds)) map_bounds(initial_bounds),
    initial_view_state = initial_view_state,
    controller = controller,
    picking_radius = picking_radius,
    use_device_pixels = use_device_pixels,
    blending_mode = blending_mode,
    ...
  )

  x <- list(
    props = props,
    layers = list(),
    theme = theme
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
  UseMethod("add_layer")
}

add_layer.rdeck <- function(rdeck, layer) {
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

map_bounds <- function(initial_bounds) {
  assert_type(initial_bounds, c("bbox", "sf", "sfc", "sfg"))

  sfc <- if (inherits(initial_bounds, "bbox")) {
    sf::st_as_sfc(initial_bounds)
  } else {
    sf::st_geometry(initial_bounds)
  }

  sfc %>%
    sf::st_transform(4326) %>%
    sf::st_bbox()
}

rdeck_props <- function(mapbox_api_access_token = NULL,
                        map_style = NULL,
                        initial_bounds = NULL,
                        initial_view_state = NULL,
                        controller = NULL,
                        picking_radius = NULL,
                        use_device_pixels = NULL,
                        blending_mode = NULL,
                        ...) {
  check_dots(...)
  structure(
    c(
      list(
        mapbox_api_access_token = mapbox_api_access_token,
        map_style = map_style,
        initial_bounds = initial_bounds,
        initial_view_state = initial_view_state,
        controller = controller,
        picking_radius = picking_radius,
        use_device_pixels = use_device_pixels,
        blending_mode = blending_mode
      ),
      rlang::dots_list(...)
    ),
    class = "rdeck_props"
  )
}

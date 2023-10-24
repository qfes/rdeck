#' RDeck
#'
#' Create a Deck.GL map. Rendering the mapbox basemap requires a mapbox account and
#' [mapbox access token](mapbox_access_token).
#'
#' @name rdeck
#' @inheritParams layer_props
#' @param map_style <`string`> The mapbox basemap style url.
#' See <https://docs.mapbox.com/api/maps/#mapbox-styles>
#' @param theme <`"kepler"` | `"light"`> The widget theme which alters the style of the
#' legend and tooltips.
#' @param initial_bounds <[`rct`][wk::rct]/[`st_bbox`][sf::st_bbox]/[`wk-geometry`]>
#' Sets the initial bounds of the map if not `NULL`. Takes priority over `initial_view_state`.
#' Accepts a bounding box, or a geometry from which a bounding box can be computed. Requires
#' CRS [EPSG:4326](http://epsg.io/4326).
#' @param initial_view_state <[`view_state`]> Defines the map position, zoom, bearing and pitch.
#' @param controller <`logical`> If `NULL` or `FALSE`, the map is not interactive.
#' @param picking_radius <`number`> Extra pixels around the pointer to include while picking;
#' useful when rendering objects that are difficult to hover, e.g. thin lines, small points, etc.
#' @param use_device_pixels <`logical` | `number`> Controls the resolution of drawing buffer used
#' for rendering.
#' - `TRUE`: Resolution is defined by `window.devicePixelRatio`. On Retina/HD displays, this
#' resolution is usually twice as big as `CSS pixels` resolution.
#' - `FALSE`: `CSS pixels` resolution is used for rendering.
#' - `number`: Custom ratio (drawing buffer resolution to `CSS pixel`) to determine drawing
#' buffer size. A value less than `1` uses resolution smaller than `CSS pixels`, improving
#' rendering performance at the expense of image quality; a value greater than `1` improves
#' image quality at the expense of rendering performance.
#' @param layer_selector <`boolean`> If `TRUE`, the layer selector control will be enabled
#' and layers with `visibility_toggle = TRUE` may be toggled. If `FALSE`, the layer selector control
#' won't be rendered.
#' @param editor <`boolean`|[`editor_options`]> Whether to render the polygon editor.
#' If `TRUE`, renders with the default [editor_options()]. If `FALSE`, the polygon editor
#' is not rendered.
#' @param lazy_load `r lifecycle::badge("deprecated")`. Maps are always eagerly rendered.
#' @param width <`number`> The width of the map canvas.
#' @param height <`number`> The height of the map canvas.
#' @param id <`string`> The map element id. Not used in shiny applications.
#' @seealso <https://github.com/visgl/deck.gl/blob/8.7-release/docs/api-reference/core/deck.md>
#'
#' @export
rdeck <- function(map_style = mapbox_dark(),
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
                  layer_selector = TRUE,
                  editor = FALSE,
                  lazy_load = deprecated(),
                  width = NULL,
                  height = NULL,
                  id = NULL,
                  ...) {
  if (lifecycle::is_present(lazy_load)) {
    lifecycle::deprecate_warn("0.4", "rdeck::rdeck(lazy_load = )")
  }

  check_dots_access_token(...)
  tidyassert::assert(
    is_editor_options(editor) | rlang::is_scalar_logical(editor)
  )

  initial_bounds <- if (!is.null(initial_bounds)) wk::wk_bbox(initial_bounds)
  tidyassert::assert(is.null(initial_bounds) || is_wgs84(initial_bounds))

  deckgl <- deck_props(
    ...,
    initial_bounds = initial_bounds,
    initial_view_state = initial_view_state,
    controller = controller,
    picking_radius = picking_radius,
    use_device_pixels = use_device_pixels,
    blending_mode = blending_mode
  )

  mapgl <- map_props(
    map_style = map_style,
    mapbox_access_token = mapbox_access_token()
  )

  x <- structure(
    list(
      theme = theme,
      deckgl = deckgl,
      mapgl = mapgl,
      layers = list(),
      layer_selector = layer_selector,
      editor = as_editor_options(editor)
    ),
    class = "rdeck_data"
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
    elementId = id,
    preRenderHook = function(rdeck) mutate(rdeck, x = as_json(x))
  )
}

#' Layers
#'
#' Get map layers
#' @name layers
#' @param rdeck an rdeck instance
#' @export
layers <- function(rdeck) {
  tidyassert::assert_inherits(rdeck, "rdeck")

  rdeck$x$layers
}

add_layer.rdeck <- function(rdeck, layer) {
  tidyassert::assert_inherits(layer, "layer")

  rdeck$x$layers <- c(layers(rdeck), list(layer))
  rdeck
}

update_layer.rdeck <- function(rdeck, layer) {
  tidyassert::assert_inherits(layer, "layer")

  layer_index <- purrr::detect_index(
    rdeck$x$layers,
    function(l) l$id == layer$id & l$type == layer$type
  )

  tidyassert::assert(
    layer_index != 0,
    "Layer {.arg {layer_id}} doesn't exist",
    layer_id = layer$id
  )

  # update
  rdeck$x$layers <- purrr::assign_in(
    rdeck$x$layers,
    layer_index,
    mutate(
      rdeck$x$layers[[layer_index]],
      !!!select(layer, -where(is_cur_value))
    )
  )

  rdeck
}

#' Props
#'
#' Get map props
#' @name props
#' @param rdeck an rdeck instance
#' @export
props <- function(rdeck) {
  tidyassert::assert_inherits(rdeck, "rdeck")

  rdeck$x$props
}


deck_props <- function(...,
                        initial_bounds = cur_value(),
                        initial_view_state = cur_value(),
                        controller = cur_value(),
                        picking_radius = cur_value(),
                        use_device_pixels = cur_value(),
                        blending_mode = cur_value()) {
  check_dots(...)
  structure(
    c(
      list(
        initial_bounds = initial_bounds,
        initial_view_state = initial_view_state,
        controller = controller,
        picking_radius = picking_radius,
        use_device_pixels = use_device_pixels,
        blending_mode = blending_mode
      ),
      rlang::dots_list(...)
    ),
    class = "deck_props"
  )
}

map_props <- function(...,
                      map_style = cur_value(),
                      mapbox_access_token = cur_value()) {
  structure(
    list(
      map_style = map_style,
      mapbox_access_token = mapbox_access_token
    ),
    class = "map_props"
  )
}

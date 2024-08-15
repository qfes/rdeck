#' Shiny bindings for rdeck
#'
#' Output and render functions for using rdeck within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a rdeck
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name rdeck-shiny
#'
#' @export
rdeckOutput <- function(outputId, width = "100%", height = "400px") {
  htmlwidgets::shinyWidgetOutput(outputId, "rdeck", width, height, package = "rdeck")
}

#' @rdname rdeck-shiny
#' @export
renderRdeck <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) {
    expr <- substitute(expr)
  } # force quoted
  htmlwidgets::shinyRenderWidget(expr, rdeckOutput, env, quoted = TRUE)
}

#' RDeck proxy
#'
#' @description
#' Creates an [rdeck()] interface for asynchronous updates of a pre-rendered rdeck map
#' in Shiny apps.
#'
#' All rdeck props can be updated through the proxy (`NULL` values will be discarded),
#' layers that are added to the proxy (e.g. `rdeck_proxy %>% add_h3_hexagon_layer()`)
#' will be merged with pre-rendered rdeck layers.
#'
#' Layers are merged by their `id`. Matched layers will be updated in place, new layers
#' will be appended and hence drawn _on top_ of all existing layers. For layer updates, you
#' may omit the `data` prop to avoid re-serialising unchanged data. All other props will
#' assume their defaults if omitted.
#' @name rdeck_proxy
#' @param id <`string`> The map id
#' @param session <`ShinySession`> The shiny session
#' @inheritParams rdeck
#' @examples
#' \dontrun{
#' library(shiny)
#' library(dplyr)
#' library(h3jsr)
#' library(viridis)
#'
#' ui <- fillPage(
#'   rdeckOutput("map", height = "100%"),
#'   absolutePanel(
#'     top = 10, left = 10,
#'     sliderInput("range", "value", 0, 1, c(0, 1), step = 0.1)
#'   )
#' )
#'
#' h3_data <- tibble(
#'   hexagon = get_res0() %>%
#'     get_children(res = 3) %>%
#'     unlist() %>%
#'     unique(),
#'   value = runif(length(hexagon))
#' )
#'
#' map <- rdeck() %>%
#'   add_h3_hexagon_layer(
#'     id = "h3_hexagon",
#'     name = "hexagons",
#'     data = h3_data,
#'     get_fill_color = scale_color_quantize(
#'       col = value,
#'       palette = viridis(6, 0.3)
#'     ),
#'     pickable = TRUE,
#'     auto_highlight = TRUE,
#'     tooltip = c(hexagon, value)
#'   )
#'
#' server <- function(input, output, session) {
#'   output$map <- renderRdeck(map)
#'
#'   filtered_data <- reactive({
#'     h3_data %>%
#'       filter(value >= input$range[1] & value <= input$range[2])
#'   })
#'
#'   observe({
#'     rdeck_proxy("map") %>%
#'       add_h3_hexagon_layer(
#'         id = "h3_hexagon",
#'         name = "hexagons",
#'         data = filtered_data(),
#'         get_fill_color = scale_color_quantize(
#'           col = value,
#'           palette = cividis(6, 0.3)
#'         ),
#'         pickable = TRUE,
#'         auto_highlight = TRUE,
#'         tooltip = c(hexagon, value)
#'       )
#'   })
#' }
#'
#' app <- shinyApp(ui, server)
#' }
#' @export
rdeck_proxy <- function(id,
                        session = shiny::getDefaultReactiveDomain(),
                        map_style = cur_value(),
                        theme = cur_value(),
                        initial_bounds = cur_value(),
                        initial_view_state = cur_value(),
                        controller = cur_value(),
                        picking_radius = cur_value(),
                        use_device_pixels = cur_value(),
                        blending_mode = cur_value(),
                        layer_selector = cur_value(),
                        editor = cur_value(),
                        lazy_load = deprecated(),
                        ...) {
  tidyassert::assert_is_string(id)
  tidyassert::assert(
    is_cur_value(editor) |
      is_editor_options(editor) |
      rlang::is_scalar_logical(editor)
  )

  if (lifecycle::is_present(lazy_load)) {
    lifecycle::deprecate_warn("0.4", "rdeck::rdeck_proxy(lazy_load = )")
  }

  args <- rlang::call_args(rlang::current_call())
  needs_update <- !rlang::is_empty(
    select(
      args,
      -tidyselect::any_of(c("id", "session", "lazy_load")),
      -where(is_cur_value)
    )
  )

  rdeck <- structure(
    list(
      id = session$ns(id),
      session = session
    ),
    class = c("rdeck_proxy", "rdeck")
  )

  if (!needs_update) return(rdeck)

  deckgl <- deck_props(
    initial_bounds = initial_bounds,
    initial_view_state = initial_view_state,
    controller = controller,
    picking_radius = picking_radius,
    use_device_pixels = use_device_pixels,
    blending_mode = blending_mode,
    ...
  )

  mapgl <- map_props(map_style = map_style)

  data <- structure(
    list(
      theme = theme,
      deckgl = deckgl,
      mapgl = mapgl,
      layer_selector = layer_selector,
      editor = as_editor_options(editor)
    ),
    class = "rdeck_data"
  )

  as_json(data)

  send_msg(rdeck, "deck", as_json(data))
  rdeck
}

#' @export
add_layer.rdeck_proxy <- function(rdeck, layer) {
  tidyassert::assert_inherits(layer, "layer")

  send_msg(rdeck, "layer", as_json(layer))
  rdeck
}

#' @export
update_layer.rdeck_proxy <- add_layer.rdeck_proxy

#' Set layer visibility
#'
#' Sets a layer's visibility and whether it is _selectable_ in the layer selector.
#' Setting either `visible` or `visibility_toggle` as `cur_value()` will have no change
#' in the browser.
#' @name set_layer_visibility
#' @param rdeck <`rdeck_proxy`> the rdeck proxy object
#' @inheritParams layer_props
#'
#' @export
set_layer_visibility <- function(rdeck, id, visible = cur_value(), visibility_toggle = cur_value()) {
  tidyassert::assert_inherits(rdeck, "rdeck_proxy")
  layer <- list(
    id = id,
    visible = visible,
    visibility_toggle = visibility_toggle
  )

  validate_id(layer)
  validate_visible(layer)
  validate_visibility_toggle(layer)

  json <- json_stringify(
    purrr::discard(layer, is_cur_value),
    camel_case = TRUE,
    auto_unbox = TRUE
  )

  send_msg(rdeck, "layer", json)
  rdeck
}

send_msg <- function(rdeck, name, data) {
  tidyassert::assert_inherits(rdeck, "rdeck_proxy")
  tidyassert::assert_is_string(name)

  session <- rdeck$session
  session$onFlushed(
    function() session$sendCustomMessage(paste0(rdeck$id, ":", name), data),
    once = TRUE
  )
}

#' Shiny events data
#'
#' @description
#' Utilities for retrieving map event data in a shiny application.
#'
#' @name shiny-events
NULL

#' Get event data
#'
#' @name get_event_data
#' @param rdeck <`rdeck_proxy` | `string`> the map, or map id
#' @param event_name <`string`> the event name
#' @param session <`ShinySession`> the shiny session
#' @keywords internal
get_event_data <- function(rdeck, event_name, session = shiny::getDefaultReactiveDomain()) {
  tidyassert::assert(
    inherits(rdeck, "rdeck_proxy") && rlang::is_string(rdeck$id) || rlang::is_string(rdeck)
  )
  tidyassert::assert(rlang::is_string(event_name))
  tidyassert::assert(!is.null(session) || !is.null(rdeck$session))

  id <- if (inherits(rdeck, "rdeck_proxy")) rdeck$id else rdeck
  session <- session %||% rdeck$session
  session$input[[paste(id, event_name, sep = "_")]]
}

#' @describeIn shiny-events Get the current map bounding box
#' @inherit get_event_data
#' @export
get_view_bounds <- function(rdeck, session = shiny::getDefaultReactiveDomain()) {
  event_data <- with_event_data_errors(
    get_event_data(rdeck, "viewstate", session)
  )

  bounds <- unlist(event_data$bounds)
  if (is.null(bounds)) return(NULL)

  wk::as_rct(t(bounds), crs = "OGC:CRS84")
}

#' @describeIn shiny-events Get the map view state
#' @inherit get_event_data
#' @autoglobal
#' @export
get_view_state <- function(rdeck, session = shiny::getDefaultReactiveDomain()) {
  event_data <- with_event_data_errors(
    get_event_data(rdeck, "viewstate", session)
  )

  if (is.null(event_data$viewState)) return(NULL)

  purrr::modify_in(
    event_data$viewState,
    "center",
    \(x) wk::as_xy(t(unlist(x)), crs = "OGC:CRS84")
  )
}

#' @describeIn shiny-events Get the last clicked coordinates
#' @inherit get_event_data
#' @export
get_clicked_coordinates <- function(rdeck, session = shiny::getDefaultReactiveDomain()) {
  event_data <- with_event_data_errors(
    get_event_data(rdeck, "click", session)
  )

  coords <- event_data$coordinate
  if (is.null(coords)) return(NULL)

  wk::as_xy(t(unlist(coords)), crs = "OGC:CRS84")
}

#' @describeIn shiny-events Get the last clicked layer (or NULL)
#' @inherit get_event_data
#' @export
get_clicked_layer <- function(rdeck, session = shiny::getDefaultReactiveDomain()) {
  event_data <- with_event_data_errors(
    get_event_data(rdeck, "click", session)
  )

  event_data$layer
}

#' @describeIn shiny-events Get the last clicked object (or NULL)
#' @inherit get_event_data
#' @export
get_clicked_object <- function(rdeck, session = shiny::getDefaultReactiveDomain()) {
  event_data <- with_event_data_errors(
    get_event_data(rdeck, "click", session)
  )

  event_data$object
}

#' @describeIn shiny-events Get the edited features
#' @inherit get_event_data
#' @export
get_edited_features <- function(rdeck, session = shiny::getDefaultReactiveDomain()) {
  event_data <- with_event_data_errors(
    get_event_data(rdeck, "editorupload", session)
  )

  rlang::check_installed("geojsonsf")
  geojsonsf::geojson_sf(event_data$geojson %||% '{"type": "FeatureCollection","features": []}')
}

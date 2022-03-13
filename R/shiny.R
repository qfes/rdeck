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
                        map_style = NULL,
                        theme = NULL,
                        initial_bounds = NULL,
                        initial_view_state = NULL,
                        controller = NULL,
                        picking_radius = NULL,
                        use_device_pixels = NULL,
                        blending_mode = NULL,
                        layer_selector = NULL,
                        lazy_load = NULL,
                        ...) {
  tidyassert::assert_is_string(id)

  rdeck <- structure(
    list(
      id = session$ns(id),
      session = session
    ),
    class = c("rdeck_proxy", "rdeck")
  )

  props <- rdeck_props(
    map_style = map_style,
    initial_bounds = initial_bounds,
    initial_view_state = initial_view_state,
    controller = controller,
    picking_radius = picking_radius,
    use_device_pixels = use_device_pixels,
    blending_mode = blending_mode,
    ...
  )

  props <- select(props, -where(is.null))

  if (length(props) != 0) {
    data <- structure(
      list(
        props = props,
        theme = theme,
        layer_selector = layer_selector,
        lazy_load = lazy_load
      ),
      class = "rdeck_data"
    )
    send_msg(rdeck, "deck", to_json(data))
  }

  rdeck
}

add_layer.rdeck_proxy <- function(rdeck, layer) {
  tidyassert::assert_inherits(layer, "layer")

  send_msg(rdeck, "layer", to_json(layer))
  rdeck
}

#' Set layer visibility
#'
#' Sets a layer's visibility and whether it is _selectable_ in the layer selector.
#' Setting either `visible` or `visibility_toggle` as `NULL` will have no change
#' in the browser.
#' @name set_layer_visibility
#' @param rdeck <`rdeck_proxy`> the rdeck proxy object
#' @inheritParams layer_props
#'
#' @export
set_layer_visibility <- function(rdeck, id, visible = NULL, visibility_toggle = NULL) {
  tidyassert::assert_inherits(rdeck, "rdeck_proxy")
  props <- list(id = id, visible = visible, visibility_toggle = visibility_toggle)

  layer <- structure(
    select(props, -where(is.null)),
    class = "layer"
  )

  validate_id(layer)
  validate_visible(layer)
  if (!is.null(visibility_toggle)) {
    validate_visibility_toggle(layer)
  }

  send_msg(rdeck, "layer", to_json(layer))
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

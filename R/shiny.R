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
#' @name rdeck_proxy
#' @param id the map id
#' @export
rdeck_proxy <- function(id, session = shiny::getDefaultReactiveDomain(), ...) {
  assert_is_string(id)
  assert_type(session, "ShinySession")

  # mirror all stuff from the rdeck constructor
  rdeck <- structure(
    list(
      id = session$ns(id),
      session = session
    ),
    class = c("rdeck_proxy", "rdeck")
  )

  # TODO: send msg
}

add_layer.rdeck_proxy <- function(rdeck, layer) {
  assert_type(layer, "layer")

  cache <- rdeck$session$cache
  # avoid re-serialising cached data
  if (!is.null(cache) && inherits(layer$data, "data.frame")) {
    key <- get_key(rdeck$id, layer$id)
    cached <- cache$get(key)

    # layer$data === cached? skip data
    if (identical(cached, layer$data)) {
      layer$data <- NULL
    } else {
      cache$set(key, layer$data)
    }
  }

  send_msg(rdeck, "layer", to_json(layer))
  rdeck
}

send_msg <- function(rdeck, name, data) {
  assert_type(rdeck, "rdeck_proxy")
  assert_is_string(name)

  session <- rdeck$session
  session$onFlushed(function() {
    session$sendCustomMessage(paste0(rdeck$id, ":", name), data)
  }, once = TRUE)
}

get_key <- function(map_id, layer_id = NULL) {
  assert_is_string(map_id)
  if (!is.null(layer_id)) {
    assert_is_string(layer_id)
  }

  gsub("[^a-z0-9]", "", tolower(paste0(map_id, layer_id)))
}

#' Create a view_state
#'
#' @name view_state
#' @param center [`numeric`] | [sf::st_point()]
#'  Center of the viewport on map
#'
#' @param zoom [`numeric`]
#'  Scale = `Math.pow(2, zoom)` on map
#'
#' @param pitch [`numeric`]
#'  Camera angle in degrees (0 is straight down)
#'
#' @param bearing [`numeric`]
#'  Map rotation in degrees (0 means north is up)
#'
#' @param ... additional parameters to pass to view_state | initial_view_state
#'
#' @seealso <https://github.com/uber-archive/viewport-mercator-project/blob/master/docs/api-reference/web-mercator-viewport.md>
#'
#' @export
view_state <- function(center = c(0, 0),
                       zoom = 0,
                       pitch = 0,
                       bearing = 0,
                       ...) {
  props <- c(
    list(
      longitude = center[1],
      latitude = center[2],
      zoom = zoom,
      pitch = pitch,
      bearing = bearing
    ),
    list(...)
  ) %>%
    camel_case_names()

  structure(
    props,
    class = "view_state"
  )
}

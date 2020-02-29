#' Create a view_state
#'
#' @name view_state
#' @param center `{numeric | st_point}`
#'  Center of the viewport on map
#'
#' @param zoom `{numeric}`
#'  Scale = `Math.pow(2, zoom)` on map
#'
#' @param pitch `{numeric}`
#'  Camera angle in degrees (0 is straight down)
#'
#' @param bearing `{numeric}`
#'  Map rotation in degrees (0 means north is up)
#'
#' @seealso \url{https://github.com/uber-archive/viewport-mercator-project/blob/master/docs/api-reference/web-mercator-viewport.md}
#'
#' @export
view_state <- function(center = NULL,
                       zoom = NULL,
                       pitch = NULL,
                       bearing = NULL) {
  props <- list(
    longitude = center[1],
    latitude = center[2],
    zoom = zoom,
    pitch = pitch,
    bearing = bearing
  ) %>%
    Filter(x = ., function(x) !is.null(x))

  structure(
    props,
    class = "view_state"
  )
}

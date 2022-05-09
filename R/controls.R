#' Polygon editor options
#'
#' Options for the polygon editor
#' @name polygon_editor_opts
#' @param mode <`"view"` | `"modify"` | `"polygon"` | `"lasso"`> The polygon editor mode.
#' - `view`: editor is in readonly mode
#' - `modify`: add/move/delete vertices, or move the entire polygon
#' - `polygon`: draw a polygon by clicking each vertex
#' - `lasso`: freehand polygon draw by click-dragging
#' @param polygon <`sfc`> A polygon with which to initialise the editor
#' @export
polygon_editor_opts <- function(mode = "view", polygon = cur_value()) {
  structure(
    list(
      mode = mode,
      polygon = polygon
    ),
    class = "polygon_editor_opts"
  )
}

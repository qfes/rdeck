#' Polygon editor options
#'
#' Options for the polygon editor
#' @name polygon_editor_options
#' @param mode <`"view"` | `"modify"` | `"polygon"` | `"lasso"`> The polygon editor mode.
#' - `view`: editor is in readonly mode
#' - `modify`: add/move/delete vertices, or move the entire polygon
#' - `polygon`: draw a polygon by clicking each vertex
#' - `lasso`: freehand polygon draw by click-dragging
#' @param polygon <`sfc`> A polygon with which to initialise the editor
#' @export
polygon_editor_options <- function(mode = "view", polygon = cur_value()) {
  tidyassert::assert(
    is_cur_value(mode) |
      rlang::is_string(mode) & mode %in% c("view", "modify", "polygon", "lasso")
  )
  tidyassert::assert(
    is_cur_value(polygon) |
      is_sfc(polygon) & sf::st_geometry_type(polygon, FALSE) == "POLYGON"
  )

  structure(
    list(
      mode = mode,
      polygon = polygon
    ),
    class = "polygon_editor_options"
  )
}

is_polygon_editor_options <- function(object) inherits(object, "polygon_editor_options")

as_polygon_editor <- function(object) UseMethod("as_polygon_editor")
as_polygon_editor.default <- function(object) object
as_polygon_editor.NULL <- function(object) NULL
as_polygon_editor.logical <- function(object) if (isTRUE(object)) polygon_editor_options() else NULL

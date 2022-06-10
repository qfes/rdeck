#' Polygon editor options
#'
#' Options for the polygon editor
#' @name editor_options
#' @param mode <`"view"` | `"modify"` | `"polygon"` | `"lasso"`> The polygon editor mode.
#' - `view`: editor is in readonly mode
#' - `modify`: add/move/delete vertices, or move the entire polygon
#' - `polygon`: draw a polygon by clicking each vertex
#' - `lasso`: freehand polygon draw by click-dragging
#' @param features <`sfc`> Features with which to initialise the editor
#' @export
editor_options <- function(mode = "view", features = cur_value()) {
  tidyassert::assert(!rlang::is_null(mode) || is_cur_value(mode))
  tidyassert::assert(rlang::is_string(mode) & mode %in% c("view", "modify", "features", "lasso"))
  tidyassert::assert(!rlang::is_null(features) || is_cur_value(features))
  tidyassert::assert(is_sfc(features) & sf::st_geometry_type(features, FALSE) == "POLYGON")

  structure(
    list(
      mode = mode,
      features = features
    ),
    class = "editor_options"
  )
}

is_editor_options <- function(object) inherits(object, "editor_options")

as_editor_options <- function(object) UseMethod("as_editor_options")
as_editor_options.default <- function(object) object
as_editor_options.NULL <- function(object) NULL
as_editor_options.logical <- function(object) if (isTRUE(object)) editor_options() else NULL

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
editor_options <- function(mode = cur_value(), features = cur_value()) {
  tidyassert::assert(
    is_cur_value(mode) ||
      rlang::is_string(mode) && mode %in% editor_modes(),
    error_message = c(
      "x" = paste("{.arg mode} must be one of ", paste0(editor_modes(), collapse = ", "))
    )
  )

  tidyassert::assert(
    is_cur_value(features) ||
      (is_sf(features) || is_sfc(features)) && is_wgs84(features),
      error_message = c(
        "x" = "{.arg features} must be a {.emph WGS84} {.cls sf/sfc}"
      )
  )

  structure(
    list(
      mode = mode,
      features = features
    ),
    class = "editor_options"
  )
}

editor_modes <- function() c("view", "modify", "polygon", "lasso")

is_editor_options <- function(object) inherits(object, "editor_options")

as_editor_options <- function(object) UseMethod("as_editor_options")
as_editor_options.default <- function(object) object
as_editor_options.NULL <- function(object) NULL
as_editor_options.logical <- function(object) if (isTRUE(object)) editor_options() else NULL

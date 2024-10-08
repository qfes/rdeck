#' Polygon editor options
#'
#' Options for the polygon editor
#' @name editor_options
#' @param mode <`editor-mode`> The polygon editor mode. One of:
#' - `view`: editor is in readonly mode
#' - `select`: select/unselect features
#' - `modify`: add/move/delete vertices
#' - `transform`: move/scale/rotate selected features
#' - `point`: draw points
#' - `linestring`: draw linestrings by clicking each vertex
#' - `polygon`: draw polygons by clicking each vertex
#' - `lasso`: freehand polygon draw by click-dragging
#' @param features <[`wk-geometry`]> Features with which to initialise the editor.
#' Requires CRS [EPSG:4326](http://epsg.io/4326).
#' @export
editor_options <- function(mode = cur_value(), features = cur_value()) {
  tidyassert::assert(
    is_cur_value(mode) || rlang::is_string(mode) && mode %in% editor_modes(),
    error_message = c(
      "x" = paste("{.arg mode} must be one of ", paste0(editor_modes(), collapse = ", "))
    )
  )

  tidyassert::assert(
    is.null(features) || is_cur_value(features) ||
      wk::is_handleable(features) && is_wgs84(features),
    error_message = c(
      "x" = "{.arg features} must be a {.emph WGS84} {.cls wk-geometry}"
    )
  )

  if (inherits(features, "data.frame")) {
    features <- purrr::detect(features, wk::is_handleable)
  }

  structure(
    list(
      mode = mode,
      features = features
    ),
    class = "editor_options"
  )
}


editor_modes <- function() {
  c(
    "view", "select",
    "transform", "modify",
    "point", "linestring", "polygon", "lasso"
  )
}

is_editor_options <- function(object) inherits(object, "editor_options")

as_editor_options <- function(object) UseMethod("as_editor_options")
#' @export
as_editor_options.editor_options <- function(object) object
#' @export
as_editor_options.cur_value <- function(object) object
#' @export
as_editor_options.NULL <- function(object) NULL
#' @export
as_editor_options.logical <- function(object) if (isTRUE(object)) editor_options() else NULL

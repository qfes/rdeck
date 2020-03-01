#' Add a [GridCellLayer](https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/grid-cell-layer.md) deck.gl layer to an [rdeck] map.
#'
#' @name add_grid_cell_layer
#'
#' @param rdeck [`rdeck`]
#'  An [rdeck] map.
#'
#' @inheritParams grid_cell_layer
#' @inheritDotParams grid_cell_layer
#'
#' @returns [`rdeck`]
#'  The [rdeck] map.
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/grid-cell-layer.md}
#'
#' @export
add_grid_cell_layer <- function(rdeck,
                                id = NULL,
                                data = NULL,
                                visible = TRUE,
                                pickable = FALSE,
                                opacity = 1,
                                position_format = "XYZ",
                                color_format = "RGBA",
                                auto_highlight = FALSE,
                                highlight_color = c(0, 0, 128, 128),
                                disk_resolution = 20,
                                vertices = NULL,
                                radius = 1000,
                                angle = 0,
                                offset = c(1, 1),
                                coverage = 1,
                                elevation_scale = 1,
                                line_width_units = "meters",
                                line_width_scale = 1,
                                line_width_min_pixels = 0,
                                line_width_max_pixels = 9007199254740991,
                                extruded = TRUE,
                                wireframe = FALSE,
                                filled = TRUE,
                                stroked = FALSE,
                                get_position = NULL,
                                get_fill_color = NULL,
                                get_line_color = NULL,
                                get_line_width = NULL,
                                get_elevation = NULL,
                                material = TRUE,
                                cell_size = 1000,
                                ...) {
  params <- as.list(match.call())[-(1:2)]
  layer <- do.call(grid_cell_layer, params)

  add_layer(rdeck, layer)
}

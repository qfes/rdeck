#' Add SimpleMeshLayer to an rdeck map.
#'
#' @name add_simple_mesh_layer
#' @param rdeck \`{rdeck}\` an rdeck widget instance
#' @param data `{data.frame | sf}`
#' @param visible `{logical}`
#' @param pickable `{logical}`
#' @param opacity `{numeric}`
#' @param position_format `{"XY" | "XYZ"}`
#' @param color_format `{"RGB" | "RGBA"}`
#' @param auto_highlight `{logical}`
#' @param highlight_color `{integer}`
#' @param mesh `{list}`
#' @param texture `{list}`
#' @param size_scale `{numeric}`
#' @param wireframe `{logical}`
#' @param material `{logical}`
#' @param get_position `{accessor | JS}`
#' @param get_color `{accessor}`
#' @param get_orientation `{accessor}`
#' @param get_scale `{accessor}`
#' @param get_translation `{accessor}`
#' @param get_transform_matrix `{accessor}`
#' @param ... additional layer parameters to pass to deck.gl
#' @returns \`{rdeck}\`
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/simple-mesh-layer.md}
#'
#' @export
add_simple_mesh_layer <- function(rdeck,
                                  data = NULL,
                                  visible = TRUE,
                                  pickable = FALSE,
                                  opacity = 1,
                                  position_format = "XYZ",
                                  color_format = "RGBA",
                                  auto_highlight = FALSE,
                                  highlight_color = c(0, 0, 128, 128),
                                  mesh = NULL,
                                  texture = NULL,
                                  size_scale = 1,
                                  wireframe = FALSE,
                                  material = TRUE,
                                  get_position = NULL,
                                  get_color = NULL,
                                  get_orientation = NULL,
                                  get_scale = NULL,
                                  get_translation = NULL,
                                  get_transform_matrix = NULL,
                                  ...) {
  stopifnot(inherits(rdeck, "rdeck"))

  if (inherits(data, "sf")) {
    get_position <- accessor(as.name(attr(data, "sf_column")), data, columnar = TRUE)
  }
  get_color <- accessor(substitute(get_color), data, columnar = TRUE)
  get_orientation <- accessor(substitute(get_orientation), data, columnar = TRUE)
  get_scale <- accessor(substitute(get_scale), data, columnar = TRUE)
  get_translation <- accessor(substitute(get_translation), data, columnar = TRUE)
  get_transform_matrix <- accessor(substitute(get_transform_matrix), data, columnar = TRUE)

  params <- c(
    list(
      type = "SimpleMeshLayer",
      data = data,
      visible = visible,
      pickable = pickable,
      opacity = opacity,
      position_format = position_format,
      color_format = color_format,
      auto_highlight = auto_highlight,
      highlight_color = highlight_color,
      mesh = mesh,
      texture = texture,
      size_scale = size_scale,
      wireframe = wireframe,
      material = material,
      get_position = get_position,
      get_color = get_color,
      get_orientation = get_orientation,
      get_scale = get_scale,
      get_translation = get_translation,
      get_transform_matrix = get_transform_matrix
    ),
    list(...)
  )

  do.call(layer, params) %>%
    add_layer(rdeck, .)
}

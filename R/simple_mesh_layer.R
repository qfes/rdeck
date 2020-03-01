#' [SimpleMeshLayer](https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/simple-mesh-layer.md) deck.gl layer.
#'
#' @name simple_mesh_layer
#'
#' @param id [`character`]
#'  The id of the layer. Layer ids must be unique per layer `type` for deck.gl
#'  to properly distinguish between them.
#'
#' @param data [`data.frame`] | [`sf::sf`]
#'
#' @param visible [`logical`]
#'
#' @param pickable [`logical`]
#'
#' @param opacity [`numeric`]
#'
#' @param position_format `XY` | `XYZ`
#'
#' @param color_format `RGB` | `RGBA`
#'
#' @param auto_highlight [`logical`]
#'
#' @param highlight_color [`integer`]
#'
#' @param mesh [`list`]
#'
#' @param texture [`list`]
#'
#' @param size_scale [`numeric`]
#'
#' @param wireframe [`logical`]
#'
#' @param material [`logical`]
#'
#' @param get_position accessor | [`htmlwidgets::JS`]
#'
#' @param get_color accessor
#'
#' @param get_orientation accessor
#'
#' @param get_scale accessor
#'
#' @param get_translation accessor
#'
#' @param get_transform_matrix accessor
#'
#' @param ... additional layer parameters to pass to deck.gl.
#'  `snake_case` parameters will be converted to `snakeCase`.
#'
#' @returns `SimpleMeshLayer` & [`layer`]
#'  A [SimpleMeshLayer](https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/simple-mesh-layer.md) layer.
#'  Add to an [rdeck] map via [`add_layer`] or [`rdeck`].
#'
#' @seealso \url{https://github.com/uber/deck.gl/blob/v8.0.16/docs/layers/simple-mesh-layer.md}
#'
#' @export
simple_mesh_layer <- function(id = NULL,
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
  # auto-resolve geometry column
  if (inherits(data, "sf")) {
    get_position <- as.name(attr(data, "sf_column")) %>%
      accessor(data = data, columnar = TRUE)
  }

  get_color <- substitute(get_color) %>%
    accessor(data = data, columnar = TRUE)

  get_orientation <- substitute(get_orientation) %>%
    accessor(data = data, columnar = TRUE)

  get_scale <- substitute(get_scale) %>%
    accessor(data = data, columnar = TRUE)

  get_translation <- substitute(get_translation) %>%
    accessor(data = data, columnar = TRUE)

  get_transform_matrix <- substitute(get_transform_matrix) %>%
    accessor(data = data, columnar = TRUE)

  params <- c(
    list(
      type = "SimpleMeshLayer",
      id = id,
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

  do.call(layer, params)
}

#' @name text_layer
#' @template text_layer
#' @family layers
#' @export
text_layer <- function(id = "TextLayer",
                       data = data.frame(),
                       visible = TRUE,
                       pickable = FALSE,
                       opacity = 1,
                       position_format = "XYZ",
                       color_format = "RGBA",
                       auto_highlight = FALSE,
                       highlight_color = "#00008080",
                       billboard = TRUE,
                       size_scale = 1,
                       size_units = "pixels",
                       size_min_pixels = 0,
                       size_max_pixels = 9007199254740991,
                       background_color = NULL,
                       character_set = " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~",
                       font_family = "Monaco, monospace",
                       font_weight = "normal",
                       line_height = 1,
                       font_settings = NULL,
                       word_break = "word-break",
                       max_width = -1,
                       get_text = text,
                       get_position = position,
                       get_color = "#000000ff",
                       get_size = 32,
                       get_angle = 0,
                       get_text_anchor = "middle",
                       get_alignment_baseline = "center",
                       get_pixel_offset = c(0, 0),
                       ...) {
  arguments <- get_arguments()
  parameters <- c(
    list(type = "TextLayer"),
    get_arguments()
  )
  # auto-resolve geometry
  if (inherits(data, "sf")) {
    parameters$get_position <- as.name(attr(data, "sf_column"))
  }

  do.call(layer, parameters)
}

#' @name add_text_layer
#' @template text_layer
#' @param rdeck `rdeck`
#' @family add_layers
#' @export
add_text_layer <- function(rdeck,
                           id = "TextLayer",
                           data = data.frame(),
                           visible = TRUE,
                           pickable = FALSE,
                           opacity = 1,
                           position_format = "XYZ",
                           color_format = "RGBA",
                           auto_highlight = FALSE,
                           highlight_color = "#00008080",
                           billboard = TRUE,
                           size_scale = 1,
                           size_units = "pixels",
                           size_min_pixels = 0,
                           size_max_pixels = 9007199254740991,
                           background_color = NULL,
                           character_set = " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~",
                           font_family = "Monaco, monospace",
                           font_weight = "normal",
                           line_height = 1,
                           font_settings = NULL,
                           word_break = "word-break",
                           max_width = -1,
                           get_text = text,
                           get_position = position,
                           get_color = "#000000ff",
                           get_size = 32,
                           get_angle = 0,
                           get_text_anchor = "middle",
                           get_alignment_baseline = "center",
                           get_pixel_offset = c(0, 0),
                           ...) {
  parameters <- get_arguments()[-1]
  layer <- do.call(text_layer, parameters)

  add_layer(rdeck, layer)
}

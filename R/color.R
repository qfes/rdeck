#' Color
#'
#' Creates a color scale
#'
#' @name color
#' @param palette
#' The color palette, which also serves as the number of breaks for the
#' color scale.
#'
#' @param scale
#' The color scale function. One of `"quantize", "quantile", "categorical"`
#'
#' @param value
#' The name of the column containing the values that bin color is based on.
#'
#' @param legend `logical` | [legend()]
#'
#' @return `color`
#' @export
color <- function(palette,
                  scale = "quantize",
                  value,
                  legend = TRUE) {
  expr <- substitute(value)
  stopifnot(is.name(expr) || is.character(value) && length(value) == 1)

  structure(
    list(
      range = get_color_range(palette),
      scale = scale,
      value = ifelse(is.name(expr), deparse(expr, backtick = FALSE), value),
      legend = legend
    ),
    class = "color"
  )
}

get_color_range <- function(palette) {
  stopifnot(is.vector(palette) || is.matrix(palette))

  if (is.vector(palette)) {
    return(
      hex_to_rgba(palette) %>% t()
    )
  }

  # transpose if colnames
  if (is.null(colnames(palette))) t(palette) else palette
}

hex_to_rgba <- function(color) {
  stopifnot(is.character(color))

  grDevices::col2rgb(color, alpha = nchar(color) == 9)
}

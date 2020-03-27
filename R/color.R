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

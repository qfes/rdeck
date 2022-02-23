color_gradient <- function(palette) {
  UseMethod("color_gradient")
}

color_gradient.character <- function(palette) {
  assert_rgba(palette)
  color_gradient(function(n) palette)
}

color_gradient.function <- function(palette) {
  # function is a ramp built with scales::colour_ramp
  if (isTRUE(attr(palette, "safe_palette_func"))) return(palette)

  # assume palette takes a length param
  function(x) {
    colors <- suppressWarnings(palette(256))
    ramp <- scales::colour_ramp(colors[!is.na(colors)])
    ramp(x)
  }
}

color_categories <- function(palette) {
  UseMethod("color_categories")
}

color_categories.character <- function(palette) {
  assert_rgba(palette)
  color_categories(scales::manual_pal(palette))
}

color_categories.function <- function(palette) {
  rescale <- function(x, levels) scales::rescale(match(x, levels))

  # function is a ramp built with scales::colour_ramp
  if (isTRUE(attr(palette, "safe_palette_func"))) {
    ramp <- function(x) {
      levels <- get_levels(x)
      palette(rescale(x, levels))
    }
    return(ramp)
  }

  # assume palette takes a length param
  function(x) {
    levels <- get_levels(x)
    colors <- palette(length(levels))
    ramp <- scales::colour_ramp(colors[!is.na(colors)])
    ramp(rescale(x, levels))
  }
}

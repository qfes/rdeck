dependencies <- list(
  htmltools::htmlDependency(
    name = "mapbox-gl",
    version = "1.8.1",
    src = c(href = "https://unpkg.com/mapbox-gl@1.8.1"),
    script = "dist/mapbox-gl.js",
    stylesheet = "dist/mapbox-gl.css"
  ),
  htmltools::htmlDependency(
    name = "h3-js",
    version = "3.6.3",
    src = c(href = "https://unpkg.com/h3-js@3.6.3"),
    script = "dist/h3-js.umd.js",
    stylesheet = NULL
  ),
  htmltools::htmlDependency(
    name = "s2-geometry",
    version = "1.2.10",
    src = c(href = "https://unpkg.com/s2-geometry@1.2.10"),
    script = "src/s2geometry.js",
    stylesheet = NULL
  ),
  htmltools::htmlDependency(
    name = "deck.gl",
    version = "8.1.0",
    src = c(href = "https://unpkg.com/deck.gl@8.1.0"),
    script = "dist.min.js",
    stylesheet = NULL
  ),
  htmltools::htmlDependency(
    name = "d3-array",
    version = "2.4.0",
    src = c(href = "https://unpkg.com/d3-array@2.4.0"),
    script = "dist/d3-array.min.js",
    stylesheet = NULL
  ),
  htmltools::htmlDependency(
    name = "d3-interpolate",
    version = "1.4.0",
    src = c(href = "https://unpkg.com/d3-interpolate@1.4.0"),
    script = "dist/d3-interpolate.min.js",
    stylesheet = NULL
  ),
  htmltools::htmlDependency(
    name = "d3-color",
    version = "1.4.0",
    src = c(href = "https://unpkg.com/d3-color@1.4.0"),
    script = "dist/d3-color.min.js",
    stylesheet = NULL
  ),
  htmltools::htmlDependency(
    name = "d3-scale",
    version = "3.2.1",
    src = c(href = "https://unpkg.com/d3-scale@3.2.1"),
    script = "dist/d3-scale.min.js",
    stylesheet = NULL
  )
)

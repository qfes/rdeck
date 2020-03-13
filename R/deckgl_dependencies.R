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
    version = "8.0.17",
    src = c(href = "https://unpkg.com/deck.gl@8.0.17"),
    script = "dist.min.js",
    stylesheet = NULL
  )
)

deckgl_dependency <-
  htmltools::htmlDependency(
    name = "deck.gl",
    version = "8.0.16",
    src = c(href = "https://unpkg.com/deck.gl@8.0.16"),
    script = "dist.min.js"
  )

mapboxgl_dependency <-
  htmltools::htmlDependency(
    name = "mapbox-gl",
    version = "1.8.0",
    src = c(href = "https://unpkg.com/mapbox-gl@1.8.0"),
    script = "dist/mapbox-gl.js",
    stylesheet = "dist/mapbox-gl.css"
  )

h3_dependency <-
  htmltools::htmlDependency(
    name = "h3-js",
    version = "3.6.3",
    src = c(href = "https://unpkg.com/h3-js@3.6.3"),
    script = ""
  )

s2_dependency <-
  htmltools::htmlDependency(
    name = "s2-geometry",
    version = "1.2.10",
    src = c(href = "https://bundle.run/s2-geometry@1.2.10"),
    script = ""
  )

dependencies <- list(
  mapboxgl_dependency,
  h3_dependency,
  s2_dependency,
  deckgl_dependency
)

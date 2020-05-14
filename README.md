<p align="right">
  <a href="https://github.com/anthonynorth/rdeck/releases/latest">
    <img src="https://img.shields.io/github/v/release/anthonynorth/rdeck?sort=semver&style=flat-square" alt="release">
  </a>
  <a href="https://www.tidyverse.org/lifecycle/#experimental">
    <img src="https://img.shields.io/badge/lifecycle-experimental-orange?style=flat-square" alt="lifecycle" />
  </a>
  <a href="https://travis-ci.com/anthonynorth/rdeck">
    <img src="https://img.shields.io/travis/com/anthonynorth/rdeck?style=flat-square" alt="build">
  </a>
</p>

<h1 align="center">rdeck</h1>

<p align="center">
  <a href="https://github.com/uber/deck.gl">deck.gl</a> widget for R.
</p>

## Installation

```r
remotes::install_github("anthonynorth/rdeck@*release")
```

## Usage

### Scatterplot Layer

```r
library(tidyverse)
library(sf)
library(jsonlite)
library(rdeck)

scatterplot_data <- read_json(
  "https://raw.githubusercontent.com/uber-common/deck.gl-data/master/examples/scatterplot/manhattan.json"
) %>%
  lapply(unlist) %>%
  do.call(rbind, .) %>%
  as_tibble() %>%
  set_names("lon", "lat", "gender") %>%
  st_as_sf(coords = c("lon", "lat"), crs = 4326)

rdeck(
  picking_radius = 5,
  initial_view_state = view_state(
    center = c(-74, 40.76),
    zoom = 11
  )
) %>%
  add_scatterplot_layer(
    data = scatterplot_data,
    radius_scale = 10,
    radius_min_pixels = 0.5,
    # some basic transpilation from R expressions
    get_fill_color = ~ gender == 1 ? c(0, 128, 255):c(255, 0, 128),
    pickable = TRUE,
    tooltip = c(gender, geometry)
  )
```

### Hexagon Layer

```r
library(tidyverse)
library(sf)
library(rdeck)

heatmap_data <- read_csv(
  "https://raw.githubusercontent.com/uber-common/deck.gl-data/master/examples/3d-heatmap/heatmap-data.csv"
) %>%
  filter(!is.na(lng) & !is.na(lat)) %>%
  st_as_sf(coords = c("lng", "lat"), crs = 4326)

rdeck(
  controller = TRUE,
  initial_bounds = st_bbox(heatmap_data),
  initial_view_state = view_state(
    pitch = 30,
    bearing = 45
  )
) %>%
  add_hexagon_layer(
    data = heatmap_data,
    pickable = TRUE,
    elevation_scale = 250,
    elevation_range = c(0, 1000)
  )

```

### Contour Layer

```r
library(tidyverse)
library(sf)
library(jsonlite)
library(rdeck)

contour_data <- read_json(
  "https://raw.githubusercontent.com/uber-common/deck.gl-data/master/examples/screen-grid/ca-transit-stops.json"
) %>%
  lapply(unlist) %>%
  do.call(rbind, .) %>%
  as_tibble() %>%
  st_as_sf(coords = names(.), crs = 4326)

rdeck(
  controller = TRUE,
  initial_bounds = st_bbox(contour_data)
) %>%
  add_contour_layer(
    data = contour_data,
    contours = list(
      list(threshold = 1, color = c(255, 0, 0), strokeWidth = 4),
      list(threshold = 5, color = c(0, 255, 0), strokeWidth = 2),
      list(threshold = c(6, 10), color = c(0, 0, 255, 128))
    )
  )

```

### Arc Layer

```r
library(tidyverse)
library(janitor)
library(sf)
library(jsonlite)
library(rdeck)

as_point <- function(data, lon, lat, crs = 4326) {
  coords <- c(
    deparse(substitute(lon)),
    deparse(substitute(lat))
  )
  data %>%
    st_as_sf(coords = coords, crs = crs) %>%
    st_geometry()
}

arc_data <- read_json(
  "https://raw.githubusercontent.com/uber-common/deck.gl-data/master/website/bart-segments.json"
) %>%
  lapply(unlist) %>%
  do.call(rbind, .) %>%
  as_tibble() %>%
  clean_names() %>%
  mutate_at(vars(matches("coordinates")), as.numeric) %>%
  mutate(
    source_position = as_point(., from_coordinates1, from_coordinates2),
    target_position = as_point(., to_coordinates1, to_coordinates2)
  ) %>%
  select(inbound, outbound, source_position, target_position)

rdeck(
  controller = TRUE,
  initial_view_state = list(
    longitude = -122.4,
    latitude = 37.74,
    zoom = 11,
    maxZoom = 20,
    pitch = 30,
    bearing = 0
  )
) %>%
  add_arc_layer(
    data = arc_data,
    pickable = TRUE,
    get_width = 12,
    width_units = "pixels",
    get_source_position = source_position,
    get_target_position = target_position,
    get_source_color = ~ c(Math.sqrt(inbound), 140, 0),
    get_target_color = ~ c(Math.sqrt(outbound), 140, 0),
    tooltip = c(inbound, outbound)
  )
```

### H3 Hexagon Layer

```r
library(tidyverse)
library(sf)
library(jsonlite)
library(rdeck)

h3_hexagon_data <- read_json(
  "https://raw.githubusercontent.com/uber-common/deck.gl-data/master/website/sf.h3cells.json"
) %>%
  lapply(unlist) %>%
  do.call(rbind, .) %>%
  as_tibble() %>%
  set_names("h3_index", "count") %>%
  mutate(
    count = as.integer(count)
  )

rdeck(
  controller = TRUE,
  initial_view_state = list(
    longitude = -122.4,
    latitude = 37.74,
    zoom = 11,
    maxZoom = 20,
    pitch = 30,
    bearing = 0
  )
) %>%
  add_h3_hexagon_layer(
    data = h3_hexagon_data,
    pickable = TRUE,
    wireframe = FALSE,
    filled = TRUE,
    extruded = TRUE,
    elevation_scale = 20,
    get_hexagon = h3_index,
    get_fill_color = ~ c(255, (1 - count / 500) * 255, 0),
    get_elevation = count,
    tooltip = names(h3_hexagon_data)
  )
```

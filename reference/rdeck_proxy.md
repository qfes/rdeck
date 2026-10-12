# RDeck proxy

Creates an [`rdeck()`](https://qfes.github.io/rdeck/reference/rdeck.md)
interface for asynchronous updates of a pre-rendered rdeck map in Shiny
apps.

All rdeck props can be updated through the proxy (`NULL` values will be
discarded), layers that are added to the proxy (e.g.
`rdeck_proxy %>% add_h3_hexagon_layer()`) will be merged with
pre-rendered rdeck layers.

Layers are merged by their `id`. Matched layers will be updated in
place, new layers will be appended and hence drawn *on top* of all
existing layers. For layer updates, you may omit the `data` prop to
avoid re-serialising unchanged data. All other props will assume their
defaults if omitted.

## Usage

``` r
rdeck_proxy(
  id,
  session = shiny::getDefaultReactiveDomain(),
  map_style = cur_value(),
  theme = cur_value(),
  initial_bounds = cur_value(),
  initial_view_state = cur_value(),
  controller = cur_value(),
  picking_radius = cur_value(),
  use_device_pixels = cur_value(),
  blending_mode = cur_value(),
  layer_selector = cur_value(),
  editor = cur_value(),
  lazy_load = deprecated(),
  ...
)
```

## Arguments

- id:

  \<`string`\> The map id

- session:

  \<`ShinySession`\> The shiny session

- map_style:

  \<`string`\> The mapbox basemap style url. See
  <https://docs.mapbox.com/api/maps/#mapbox-styles>

- theme:

  \<`"kepler"` \| `"light"`\> The widget theme which alters the style of
  the legend and tooltips.

- initial_bounds:

  \<[`rct`](https://paleolimbot.github.io/wk/reference/rct.html)/[`st_bbox`](https://r-spatial.github.io/sf/reference/st_bbox.html)/[`wk-geometry`](https://qfes.github.io/rdeck/reference/wk-geometry.md)\>
  Sets the initial bounds of the map if not `NULL`. Takes priority over
  `initial_view_state`. Accepts a bounding box, or a geometry from which
  a bounding box can be computed. Requires CRS
  [EPSG:4326](http://epsg.io/4326).

- initial_view_state:

  \<[`view_state`](https://qfes.github.io/rdeck/reference/view_state.md)\>
  Defines the map position, zoom, bearing and pitch.

- controller:

  \<`logical`\> If `NULL` or `FALSE`, the map is not interactive.

- picking_radius:

  \<`number`\> Extra pixels around the pointer to include while picking;
  useful when rendering objects that are difficult to hover, e.g. thin
  lines, small points, etc.

- use_device_pixels:

  \<`logical` \| `number`\> Controls the resolution of drawing buffer
  used for rendering.

  - `TRUE`: Resolution is defined by `window.devicePixelRatio`. On
    Retina/HD displays, this resolution is usually twice as big as
    `CSS pixels` resolution.

  - `FALSE`: `CSS pixels` resolution is used for rendering.

  - `number`: Custom ratio (drawing buffer resolution to `CSS pixel`) to
    determine drawing buffer size. A value less than `1` uses resolution
    smaller than `CSS pixels`, improving rendering performance at the
    expense of image quality; a value greater than `1` improves image
    quality at the expense of rendering performance.

- blending_mode:

  \<`"normal"` \| `"additive"` \| `"subtractive"`\> Sets the blending
  mode. Blending modes:

  - `normal`: Normal blending doesn't alter colours of overlapping
    objects.

  - `additive`: Additive blending adds colours of overlapping objects.
    Useful for highlighting dot density on dark maps.

  - `subtractive`: Subtractive blending darkens overlapping objects.
    Useful for highlighting dot density on light maps.

- layer_selector:

  \<`boolean`\> If `TRUE`, the layer selector control will be enabled
  and layers with `visibility_toggle = TRUE` may be toggled. If `FALSE`,
  the layer selector control won't be rendered.

- editor:

  \<`boolean`\|[`editor_options`](https://qfes.github.io/rdeck/reference/editor_options.md)\>
  Whether to render the polygon editor. If `TRUE`, renders with the
  default
  [`editor_options()`](https://qfes.github.io/rdeck/reference/editor_options.md).
  If `FALSE`, the polygon editor is not rendered.

- lazy_load:

  **\[deprecated\]**. Maps are always eagerly rendered.

- ...:

  Additional parameters that will be forwarded to deck.gl javascript
  without validation nor processing. All dots must be named and will be
  `camelCased` when serialised. A warning is raised when dots are used,
  warning class `rdeck_dots_nonempty`.

## Examples

``` r
if (FALSE) { # \dontrun{
library(shiny)
library(dplyr)
library(h3jsr)
library(viridis)

ui <- fillPage(
  rdeckOutput("map", height = "100%"),
  absolutePanel(
    top = 10, left = 10,
    sliderInput("range", "value", 0, 1, c(0, 1), step = 0.1)
  )
)

h3_data <- tibble(
  hexagon = get_res0() %>%
    get_children(res = 3) %>%
    unlist() %>%
    unique(),
  value = runif(length(hexagon))
)

map <- rdeck() %>%
  add_h3_hexagon_layer(
    id = "h3_hexagon",
    name = "hexagons",
    data = h3_data,
    get_fill_color = scale_color_quantize(
      col = value,
      palette = viridis(6, 0.3)
    ),
    pickable = TRUE,
    auto_highlight = TRUE,
    tooltip = c(hexagon, value)
  )

server <- function(input, output, session) {
  output$map <- renderRdeck(map)

  filtered_data <- reactive({
    h3_data %>%
      filter(value >= input$range[1] & value <= input$range[2])
  })

  observe({
    rdeck_proxy("map") %>%
      add_h3_hexagon_layer(
        id = "h3_hexagon",
        name = "hexagons",
        data = filtered_data(),
        get_fill_color = scale_color_quantize(
          col = value,
          palette = cividis(6, 0.3)
        ),
        pickable = TRUE,
        auto_highlight = TRUE,
        tooltip = c(hexagon, value)
      )
  })
}

app <- shinyApp(ui, server)
} # }
```

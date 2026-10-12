# RDeck

Create a Deck.GL map. Rendering the mapbox basemap requires a mapbox
account and [mapbox access
token](https://qfes.github.io/rdeck/reference/mapbox_access_token).

## Usage

``` r
rdeck(
  map_style = mapbox_dark(),
  theme = "kepler",
  initial_bounds = NULL,
  initial_view_state = view_state(center = c(0, 0), zoom = 1),
  controller = TRUE,
  picking_radius = 0,
  use_device_pixels = TRUE,
  blending_mode = "normal",
  layer_selector = TRUE,
  editor = FALSE,
  lazy_load = deprecated(),
  width = NULL,
  height = NULL,
  id = NULL,
  ...
)
```

## Arguments

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

- width:

  \<`number`\> The width of the map canvas.

- height:

  \<`number`\> The height of the map canvas.

- id:

  \<`string`\> The map element id. Not used in shiny applications.

- ...:

  Additional parameters that will be forwarded to deck.gl javascript
  without validation nor processing. All dots must be named and will be
  `camelCased` when serialised. A warning is raised when dots are used,
  warning class `rdeck_dots_nonempty`.

## See also

<https://github.com/visgl/deck.gl/blob/8.7-release/docs/api-reference/core/deck.md>

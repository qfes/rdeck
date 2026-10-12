# Arc Layer

Arc Layer

## Usage

``` r
add_arc_layer(
  rdeck,
  ...,
  id = uuid::UUIDgenerate(),
  name = "ArcLayer",
  group_name = NULL,
  data = NULL,
  visible = TRUE,
  pickable = FALSE,
  opacity = 1,
  wrap_longitude = FALSE,
  position_format = "XY",
  color_format = "RGBA",
  auto_highlight = FALSE,
  highlight_color = "#00008080",
  get_source_position = source_position,
  get_target_position = target_position,
  get_source_color = "#000000ff",
  get_target_color = "#000000ff",
  get_width = 1,
  get_height = 1,
  get_tilt = 0,
  great_circle = FALSE,
  width_units = "pixels",
  width_scale = 1,
  width_min_pixels = 0,
  width_max_pixels = 9007199254740991,
  blending_mode = "normal",
  visibility_toggle = TRUE,
  tooltip = NULL
)

update_arc_layer(
  rdeck,
  ...,
  id,
  name = cur_value(),
  group_name = cur_value(),
  data = cur_value(),
  visible = cur_value(),
  pickable = cur_value(),
  opacity = cur_value(),
  wrap_longitude = cur_value(),
  position_format = cur_value(),
  color_format = cur_value(),
  auto_highlight = cur_value(),
  highlight_color = cur_value(),
  get_source_position = cur_value(),
  get_target_position = cur_value(),
  get_source_color = cur_value(),
  get_target_color = cur_value(),
  get_width = cur_value(),
  get_height = cur_value(),
  get_tilt = cur_value(),
  great_circle = cur_value(),
  width_units = cur_value(),
  width_scale = cur_value(),
  width_min_pixels = cur_value(),
  width_max_pixels = cur_value(),
  blending_mode = cur_value(),
  visibility_toggle = cur_value(),
  tooltip = cur_value()
)
```

## Arguments

- rdeck:

  \<[`rdeck`](https://qfes.github.io/rdeck/reference/rdeck.md) \|
  [`rdeck_proxy`](https://qfes.github.io/rdeck/reference/rdeck_proxy.md)\>
  An rdeck map instance.

- ...:

  Additional parameters that will be forwarded to deck.gl javascript
  without validation nor processing. All dots must be named and will be
  `camelCased` when serialised. A warning is raised when dots are used,
  warning class `rdeck_dots_nonempty`.

- id:

  \<`string`\> The layer's identifier must be unique for among all
  layers of the same type for a map. Defaults to
  [`uuid::UUIDgenerate()`](https://rdrr.io/pkg/uuid/man/UUIDgenerate.html),
  but should be explicitly defined for updatable layers in a shiny
  application.

- name:

  \<`string`\> Identifies the layer on tooltips and legends. It does not
  need to be unique, but should be brief. Defaults to the deck.gl class
  name for the layer.

- group_name:

  \<`string`\> Defines the group that this layer belongs to. Currently
  only effective on the layer selector, if `visibility_toggle = TRUE`.

- data:

  \<`data.frame` \|
  [`sf`](https://r-spatial.github.io/sf/reference/sf.html) \| `string`\>
  The layer's data. Data frames and sf objects will contain all columns
  that are referenced by the layer's accessors. Strings will be
  interpreted as a URL and data will be retrieved dynamically in the
  browser.

- visible:

  \<`boolean`\> Determines whether the layer is visible or not; also
  determines whether any legend elements for the layer will be
  displayed.

- pickable:

  \<`boolean`\> Determines if the layer responds to pointer / touch
  events.

- opacity:

  \<`number`\> Determines the layer's opacity.

- wrap_longitude:

  \<`boolean`\> Normalises geometry longitudes.

- position_format:

  \<`"XY"` \| `"XYZ"`\> Determines whether each coordinate has two (XY)
  or three (XYZ) elements.

- color_format:

  \<`"RGB"` \| `"RGBA"`\> Determines whether the alpha channel of the
  colours will be ignored by accessors, making all colours opaque.

- auto_highlight:

  \<`boolean`\> When `TRUE`, the current object *hovered* by the cursor
  is highlighted by `highlight_color`.

- highlight_color:

  \<[`accessor`](https://qfes.github.io/rdeck/reference/accessor.md) \|
  [`scale`](https://qfes.github.io/rdeck/reference/scale.md) \|
  [`color`](https://qfes.github.io/rdeck/reference/color.md)\> When
  `auto_highlight` and `pickable` are enabled, `highlight_color`
  determines the colour of the currently highlighted object. If a single
  colour value is supplied, that colour will be used to highlight all
  objects in the layer. Per-object highlighting is achieved with a
  colour scale, or a
  [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html)
  column of colours.

- get_source_position:

  \<[`accessor`](https://qfes.github.io/rdeck/reference/accessor.md)\>
  The feature source positions. A `<point/multipoint>`
  [wk-geometry](https://qfes.github.io/rdeck/reference/wk-geometry.md)
  column with CRS [EPSG:4326](http://epsg.io/4326). Supports
  [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html).

- get_target_position:

  \<[`accessor`](https://qfes.github.io/rdeck/reference/accessor.md)\>
  The feature target positions. A `<point/multipoint>`
  [wk-geometry](https://qfes.github.io/rdeck/reference/wk-geometry.md)
  column with CRS [EPSG:4326](http://epsg.io/4326). Supports
  [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html).

- get_source_color:

  \<[`accessor`](https://qfes.github.io/rdeck/reference/accessor.md) \|
  [`scale`](https://qfes.github.io/rdeck/reference/scale.md) \|
  [`color`](https://qfes.github.io/rdeck/reference/color.md)\> The
  colour of the *source end* of the arc. Accepts a single colour value,
  a colour scale, or a
  [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html)
  column of colours.

- get_target_color:

  \<[`accessor`](https://qfes.github.io/rdeck/reference/accessor.md) \|
  [`scale`](https://qfes.github.io/rdeck/reference/scale.md) \|
  [`color`](https://qfes.github.io/rdeck/reference/color.md)\> The
  colour of the *target end* of the arc. Accepts a single colour value,
  a colour scale, or a
  [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html)
  column of colours.

- get_width:

  \<[`accessor`](https://qfes.github.io/rdeck/reference/accessor.md) \|
  [`scale`](https://qfes.github.io/rdeck/reference/scale.md) \|
  `number`\> The width of each object, in units specified by
  `width_scale`. Accepts a single numeric value, a numeric scale, or a
  [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html)
  column of numbers.

- get_height:

  \<[`accessor`](https://qfes.github.io/rdeck/reference/accessor.md) \|
  [`scale`](https://qfes.github.io/rdeck/reference/scale.md) \|
  `number`\> The multiplier of layer of layer height. Accepts a single
  numeric value, a numeric scale, or a
  [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html)
  column of numbers. A value of 0 will make the layer flat.

- get_tilt:

  \<[`accessor`](https://qfes.github.io/rdeck/reference/accessor.md) \|
  `number`\> Tilts the arcs by the specified number of degrees (between
  `c(-90, 90)`). Accepts a single numeric value or a
  [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html)
  column of numbers.

- great_circle:

  \<`boolean`\> If `TRUE`, create the arc along the shortest path on the
  earth surface.

- width_units:

  \<`"pixels"` \| `"common"` \| `"meters"`\> The units of the
  `line_width`.

- width_scale:

  \<`number`\> The scaling multiplier for the width of each line.

- width_min_pixels:

  \<`number`\> The minimum line width in pixels.

- width_max_pixels:

  \<`number`\> The maximum line width in pixels.

- blending_mode:

  \<`"normal"` \| `"additive"` \| `"subtractive"`\> Sets the blending
  mode. Blending modes:

  - `normal`: Normal blending doesn't alter colours of overlapping
    objects.

  - `additive`: Additive blending adds colours of overlapping objects.
    Useful for highlighting dot density on dark maps.

  - `subtractive`: Subtractive blending darkens overlapping objects.
    Useful for highlighting dot density on light maps.

- visibility_toggle:

  \<`boolean`\> Whether this layer will appear in the layer selector.

- tooltip:

  \<[`tooltip`](https://qfes.github.io/rdeck/reference/tooltip.md)\>
  Defines the columns (and their order) that will be displayed in the
  layer tooltip, if `pickable == TRUE`. Supports
  [tidy-select](https://dplyr.tidyverse.org/reference/dplyr_tidy_select.html)
  if a `data` is a `data.frame`. Geometry columns are always removed.

## See also

<https://github.com/visgl/deck.gl/blob/8.7-release/docs/api-reference/layers/arc-layer.md>

Other core-layers:
[`bitmap_layer`](https://qfes.github.io/rdeck/reference/bitmap_layer.md),
[`column_layer`](https://qfes.github.io/rdeck/reference/column_layer.md),
[`geojson_layer`](https://qfes.github.io/rdeck/reference/geojson_layer.md),
[`grid_cell_layer`](https://qfes.github.io/rdeck/reference/grid_cell_layer.md),
[`icon_layer`](https://qfes.github.io/rdeck/reference/icon_layer.md),
[`line_layer`](https://qfes.github.io/rdeck/reference/line_layer.md),
[`path_layer`](https://qfes.github.io/rdeck/reference/path_layer.md),
[`point_cloud_layer`](https://qfes.github.io/rdeck/reference/point_cloud_layer.md),
[`polygon_layer`](https://qfes.github.io/rdeck/reference/polygon_layer.md),
[`scatterplot_layer`](https://qfes.github.io/rdeck/reference/scatterplot_layer.md),
[`solid_polygon_layer`](https://qfes.github.io/rdeck/reference/solid_polygon_layer.md),
[`text_layer`](https://qfes.github.io/rdeck/reference/text_layer.md)

Other layers:
[`bitmap_layer`](https://qfes.github.io/rdeck/reference/bitmap_layer.md),
[`column_layer`](https://qfes.github.io/rdeck/reference/column_layer.md),
[`contour_layer`](https://qfes.github.io/rdeck/reference/contour_layer.md),
[`cpu_grid_layer`](https://qfes.github.io/rdeck/reference/cpu_grid_layer.md),
[`geojson_layer`](https://qfes.github.io/rdeck/reference/geojson_layer.md),
[`gpu_grid_layer`](https://qfes.github.io/rdeck/reference/gpu_grid_layer.md),
[`great_circle_layer`](https://qfes.github.io/rdeck/reference/great_circle_layer.md),
[`grid_cell_layer`](https://qfes.github.io/rdeck/reference/grid_cell_layer.md),
[`grid_layer`](https://qfes.github.io/rdeck/reference/grid_layer.md),
[`h3_cluster_layer`](https://qfes.github.io/rdeck/reference/h3_cluster_layer.md),
[`h3_hexagon_layer`](https://qfes.github.io/rdeck/reference/h3_hexagon_layer.md),
[`heatmap_layer`](https://qfes.github.io/rdeck/reference/heatmap_layer.md),
[`hexagon_layer`](https://qfes.github.io/rdeck/reference/hexagon_layer.md),
[`icon_layer`](https://qfes.github.io/rdeck/reference/icon_layer.md),
[`line_layer`](https://qfes.github.io/rdeck/reference/line_layer.md),
[`mvt_layer`](https://qfes.github.io/rdeck/reference/mvt_layer.md),
[`path_layer`](https://qfes.github.io/rdeck/reference/path_layer.md),
[`point_cloud_layer`](https://qfes.github.io/rdeck/reference/point_cloud_layer.md),
[`polygon_layer`](https://qfes.github.io/rdeck/reference/polygon_layer.md),
[`quadkey_layer`](https://qfes.github.io/rdeck/reference/quadkey_layer.md),
[`s2_layer`](https://qfes.github.io/rdeck/reference/s2_layer.md),
[`scatterplot_layer`](https://qfes.github.io/rdeck/reference/scatterplot_layer.md),
[`scenegraph_layer`](https://qfes.github.io/rdeck/reference/scenegraph_layer.md),
[`screen_grid_layer`](https://qfes.github.io/rdeck/reference/screen_grid_layer.md),
[`simple_mesh_layer`](https://qfes.github.io/rdeck/reference/simple_mesh_layer.md),
[`solid_polygon_layer`](https://qfes.github.io/rdeck/reference/solid_polygon_layer.md),
[`terrain_layer`](https://qfes.github.io/rdeck/reference/terrain_layer.md),
[`text_layer`](https://qfes.github.io/rdeck/reference/text_layer.md),
[`tile_3d_layer`](https://qfes.github.io/rdeck/reference/tile_3d_layer.md),
[`tile_layer`](https://qfes.github.io/rdeck/reference/tile_layer.md),
[`trips_layer`](https://qfes.github.io/rdeck/reference/trips_layer.md)

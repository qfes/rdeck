# GeoJson Layer

GeoJson Layer

## Usage

``` r
add_geojson_layer(
  rdeck,
  ...,
  id = uuid::UUIDgenerate(),
  name = "GeoJsonLayer",
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
  filled = TRUE,
  stroked = TRUE,
  line_width_max_pixels = 9007199254740991,
  line_width_min_pixels = 0,
  line_width_scale = 1,
  line_width_units = "meters",
  point_radius_max_pixels = 9007199254740991,
  point_radius_min_pixels = 0,
  point_radius_scale = 1,
  point_radius_units = "meters",
  point_antialiasing = TRUE,
  point_billboard = FALSE,
  get_fill_color = "#000000ff",
  get_line_color = "#000000ff",
  get_line_width = 1,
  get_point_radius = 1,
  icon_atlas = NULL,
  icon_mapping = list(),
  icon_size_max_pixels = 9007199254740991,
  icon_size_min_pixels = 0,
  icon_size_scale = 1,
  icon_size_units = "pixels",
  icon_alpha_cutoff = 0.05,
  icon_billboard = TRUE,
  get_icon = icon,
  get_icon_angle = 0,
  get_icon_color = "#000000ff",
  get_icon_pixel_offset = c(0, 0),
  get_icon_size = 1,
  text_size_max_pixels = 9007199254740991,
  text_size_min_pixels = 0,
  text_size_scale = 1,
  text_size_units = "pixels",
  text_background = FALSE,
  text_background_padding = c(0, 0, 0, 0),
  text_font_family = "Roboto, Helvetica, Arial, san-serif",
  text_font_weight = "normal",
  text_line_height = 1,
  text_max_width = -1,
  text_outline_color = "#000000ff",
  text_outline_width = 0,
  text_word_break = "break-word",
  text_billboard = TRUE,
  text_font_settings = list(),
  get_text = text,
  get_text_angle = 0,
  get_text_color = "#000000ff",
  get_text_pixel_offset = c(0, 0),
  get_text_size = 32,
  get_text_anchor = "middle",
  get_text_alignment_baseline = "center",
  get_text_background_color = "#ffffffff",
  get_text_border_color = "#000000ff",
  get_text_border_width = 0,
  line_joint_rounded = FALSE,
  line_cap_rounded = FALSE,
  line_miter_limit = 4,
  line_billboard = FALSE,
  extruded = FALSE,
  wireframe = FALSE,
  elevation_scale = 1,
  material = TRUE,
  get_elevation = 1000,
  point_type = "circle",
  blending_mode = "normal",
  visibility_toggle = TRUE,
  tooltip = NULL
)

update_geojson_layer(
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
  filled = cur_value(),
  stroked = cur_value(),
  line_width_max_pixels = cur_value(),
  line_width_min_pixels = cur_value(),
  line_width_scale = cur_value(),
  line_width_units = cur_value(),
  point_radius_max_pixels = cur_value(),
  point_radius_min_pixels = cur_value(),
  point_radius_scale = cur_value(),
  point_radius_units = cur_value(),
  point_antialiasing = cur_value(),
  point_billboard = cur_value(),
  get_fill_color = cur_value(),
  get_line_color = cur_value(),
  get_line_width = cur_value(),
  get_point_radius = cur_value(),
  icon_atlas = cur_value(),
  icon_mapping = cur_value(),
  icon_size_max_pixels = cur_value(),
  icon_size_min_pixels = cur_value(),
  icon_size_scale = cur_value(),
  icon_size_units = cur_value(),
  icon_alpha_cutoff = cur_value(),
  icon_billboard = cur_value(),
  get_icon = cur_value(),
  get_icon_angle = cur_value(),
  get_icon_color = cur_value(),
  get_icon_pixel_offset = cur_value(),
  get_icon_size = cur_value(),
  text_size_max_pixels = cur_value(),
  text_size_min_pixels = cur_value(),
  text_size_scale = cur_value(),
  text_size_units = cur_value(),
  text_background = cur_value(),
  text_background_padding = cur_value(),
  text_font_family = cur_value(),
  text_font_weight = cur_value(),
  text_line_height = cur_value(),
  text_max_width = cur_value(),
  text_outline_color = cur_value(),
  text_outline_width = cur_value(),
  text_word_break = cur_value(),
  text_billboard = cur_value(),
  text_font_settings = cur_value(),
  get_text = cur_value(),
  get_text_angle = cur_value(),
  get_text_color = cur_value(),
  get_text_pixel_offset = cur_value(),
  get_text_size = cur_value(),
  get_text_anchor = cur_value(),
  get_text_alignment_baseline = cur_value(),
  get_text_background_color = cur_value(),
  get_text_border_color = cur_value(),
  get_text_border_width = cur_value(),
  line_joint_rounded = cur_value(),
  line_cap_rounded = cur_value(),
  line_miter_limit = cur_value(),
  line_billboard = cur_value(),
  extruded = cur_value(),
  wireframe = cur_value(),
  elevation_scale = cur_value(),
  material = cur_value(),
  get_elevation = cur_value(),
  point_type = cur_value(),
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

  \<[`sf`](https://r-spatial.github.io/sf/reference/sf.html) \|
  `string`\> The layer's data. Data frames and sf objects will contain
  all columns that are referenced by the layer's accessors. Strings will
  be interpreted as a URL to geojson data that will be retrieved
  dynamically in the browser.

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

- filled:

  \<`boolean`\> If `TRUE`, draw the filled area of each point.

- stroked:

  \<`boolean`\> If `TRUE`, draw an outline around each object.

- line_width_max_pixels:

  \<`number`\> The maximum line width in pixels.

- line_width_min_pixels:

  \<`number`\> The minimum line width in pixels.

- line_width_scale:

  \<`number`\> The line width multiplier.

- line_width_units:

  \<`"pixels"` \| `"common"` \| `"meters"`\> The units of line width.

- point_radius_max_pixels:

  \<`number`\> The maximum radius in pixels.

- point_radius_min_pixels:

  \<`number`\> The minimum radius in pixels.

- point_radius_scale:

  \<`number`\> The radius multiplier for all points.

- point_radius_units:

  \<`"pixels"` \| `"common"` \| `"meters"`\> The units of point radius.

- point_antialiasing:

  \<`boolean`\> If `TRUE`, circles are rendered with smoothed edges.

- point_billboard:

  \<`boolean`\> If `TRUE`, circles always face the camera; if `FALSE`
  circles face up (z).

- get_fill_color:

  \<[`accessor`](https://qfes.github.io/rdeck/reference/accessor.md) \|
  [`scale`](https://qfes.github.io/rdeck/reference/scale.md) \|
  [`color`](https://qfes.github.io/rdeck/reference/color.md)\> The fill
  colour of each object. Accepts a single colour value, a colour scale,
  or a
  [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html)
  column of colours.

- get_line_color:

  \<[`accessor`](https://qfes.github.io/rdeck/reference/accessor.md) \|
  [`scale`](https://qfes.github.io/rdeck/reference/scale.md) \|
  [`color`](https://qfes.github.io/rdeck/reference/color.md)\> The line
  colour of each object. Accepts a single colour value, a colour scale,
  or a
  [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html)
  column of colours.

- get_line_width:

  \<[`accessor`](https://qfes.github.io/rdeck/reference/accessor.md) \|
  [`scale`](https://qfes.github.io/rdeck/reference/scale.md) \|
  `number`\> The outline of the object in units specified by
  `line_width_units`. Accepts a single numeric value, a numeric scale,
  or a
  [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html)
  column of numbers.

- get_point_radius:

  \<[`accessor`](https://qfes.github.io/rdeck/reference/accessor.md) \|
  [`scale`](https://qfes.github.io/rdeck/reference/scale.md) \|
  `number`\> The radius of each point, in units specified by
  `radius_units`. Accepts a single numeric value, a numeric scale, or a
  [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html)
  column of numbers.

- icon_atlas:

  \<`string`\|`array`\> The image sprite containing raster icons. Must
  be either a string which is interpreted as a URL to an image, or an
  image bitmap.

- icon_mapping:

  \<`string`\|`list`\> The image sprite index. Must be either a string
  which is interpreted as a URL to a json document, or a named-list of
  icon descriptors. See
  https://github.com/visgl/deck.gl/blob/master/docs/api-reference/layers/icon-layer.md#iconmapping-objectstring-optional
  for icon descriptor fields.

- icon_size_max_pixels:

  \<`number`\> The maximum icon size in pixels.

- icon_size_min_pixels:

  \<`number`\> The minimum icon size in pixels.

- icon_size_scale:

  \<`number`\> The icon size multiplier.

- icon_size_units:

  \<`"pixels"` \| `"common"` \| `"meters"`\> The units of the icon size
  specified by `get_icon_size`.

- icon_alpha_cutoff:

  \<`number`\> Discard icon pixels whose opacity is below this
  threshold. A discarded pixel would create a "hole" in the icon that is
  not considered part of the object.

- icon_billboard:

  \<`boolean`\> If `TRUE`, the icon always faces the camera, otherwise
  it faces up (z).

- get_icon:

  \<[`accessor`](https://qfes.github.io/rdeck/reference/accessor.md)\>
  The name of the icon for each feature. Icon name must be present in
  the `icon_mapping`.

- get_icon_angle:

  \<[`accessor`](https://qfes.github.io/rdeck/reference/accessor.md) \|
  `number`\> The rotating angle of each icon in degrees. Accepts a
  single numeric value, or a
  [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html)
  column of numbers.

- get_icon_color:

  \<[`accessor`](https://qfes.github.io/rdeck/reference/accessor.md) \|
  [`scale`](https://qfes.github.io/rdeck/reference/scale.md) \|
  [`color`](https://qfes.github.io/rdeck/reference/color.md)\> The
  colour of each icon. Accepts a single colour value, a colour scale, or
  a [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html)
  column of colours.

- get_icon_pixel_offset:

  \<[`accessor`](https://qfes.github.io/rdeck/reference/accessor.md) \|
  `number`\> The pixel offset for each icon. Accepts a single length-2
  `numeric` vector, or a
  [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html)
  list column.

- get_icon_size:

  \<[`accessor`](https://qfes.github.io/rdeck/reference/accessor.md) \|
  [`scale`](https://qfes.github.io/rdeck/reference/scale.md) \|
  `number`\> The size of each icon, in units specified by `size_units`.
  Accepts a single numeric value, a numeric scale, or a
  [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html)
  column of numbers.

- text_size_max_pixels:

  \<`number`\> The maximum text label size in pixels.

- text_size_min_pixels:

  \<`number`\> The minimum text label size in pixels.

- text_size_scale:

  \<`number`\> The text label size multiplier.

- text_size_units:

  \<`"pixels"` \| `"common"` \| `"meters"`\> The units of the text label
  size, specified by `get_text_size`.

- text_background:

  \<`boolean`\> Whether to render background for text labels.

- text_background_padding:

  \<`numeric`\> The text background padding. Must be an array of 2 or 4
  numbers.

- text_font_family:

  \<`string`\> Specifies a prioritised list of one or more font family
  names. See
  [font-family](https://developer.mozilla.org/en-US/docs/Web/CSS/font-family).

- text_font_weight:

  \<`"normal"` \| `"bold"` \| `100:900`\> The font weight. See
  [font-weight](https://developer.mozilla.org/en-US/docs/Web/CSS/font-weight)

- text_line_height:

  \<`number`\> A unitless number that will be multiplied with `get_size`
  to set the line height.

- text_max_width:

  \<`number`\> Used together with `text_word_break` for wrapping text.
  Specifies the width limit to break the text into multiple lines.

- text_outline_color:

  \<[`color`](https://qfes.github.io/rdeck/reference/color.md)\> The
  text outline colour. Requires `text_font_settings$sdf = TRUE`.

- text_outline_width:

  \<`number`\> The text outline width, relative to font size. Requires
  `text_font_settings$sdf = TRUE`.

- text_word_break:

  \<`"break-word"` \| `"break-all"`\> Requires a valid `text_max_width`.

- text_billboard:

  \<`boolean`\> If `TRUE`, the text label always faces the camera,
  otherwise it faces up (z).

- text_font_settings:

  \<`font_settings`\> Advanced options for fine tuning the appearance
  and performance of the generated `font_atlas`.

- get_text:

  \<[`accessor`](https://qfes.github.io/rdeck/reference/accessor.md)\>
  The text value of each text label. Accepts a
  [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html)
  character column of labels.

- get_text_angle:

  \<[`accessor`](https://qfes.github.io/rdeck/reference/accessor.md) \|
  `number`\> The rotating angle of each text label in degrees. Accepts a
  single numeric value, or a
  [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html)
  column of numbers.

- get_text_color:

  \<[`accessor`](https://qfes.github.io/rdeck/reference/accessor.md) \|
  [`scale`](https://qfes.github.io/rdeck/reference/scale.md) \|
  [`color`](https://qfes.github.io/rdeck/reference/color.md)\> The
  colour of each text label. Accepts a single colour value, a colour
  scale, or a
  [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html)
  column of colours.

- get_text_pixel_offset:

  \<[`accessor`](https://qfes.github.io/rdeck/reference/accessor.md) \|
  `number`\> The pixel offset for each text label. Accepts a single
  length-2 `numeric` vector, or a
  [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html)
  list column.

- get_text_size:

  \<[`accessor`](https://qfes.github.io/rdeck/reference/accessor.md) \|
  [`scale`](https://qfes.github.io/rdeck/reference/scale.md) \|
  `number`\> The font size of each text label, in units specified by
  `text_size_units`. Accepts a single numeric value, a numeric scale, or
  a [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html)
  column of numbers.

- get_text_anchor:

  \<[`accessor`](https://qfes.github.io/rdeck/reference/accessor.md) \|
  `"start"` \| `"middle"` \| `"end"`\> The text label anchor. May be a
  single value, or a
  [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html)
  character column.

- get_text_alignment_baseline:

  \<[`accessor`](https://qfes.github.io/rdeck/reference/accessor.md) \|
  `"top"` \| `"center"` \| `"bottom"`\> The text label alignment
  baseline. May be a single value, or a
  [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html)
  character column.

- get_text_background_color:

  \<[`accessor`](https://qfes.github.io/rdeck/reference/accessor.md) \|
  [`scale`](https://qfes.github.io/rdeck/reference/scale.md) \|
  [`color`](https://qfes.github.io/rdeck/reference/color.md)\> The text
  background colour, if `text_background = TRUE`. Accepts a single
  colour value, a colour scale, or a
  [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html)
  column of colours.

- get_text_border_color:

  \<[`accessor`](https://qfes.github.io/rdeck/reference/accessor.md) \|
  [`scale`](https://qfes.github.io/rdeck/reference/scale.md) \|
  [`color`](https://qfes.github.io/rdeck/reference/color.md)\> The text
  background border colour, if `text_background = TRUE`. Accepts a
  single colour value, a colour scale, or a
  [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html)
  column of colours.

- get_text_border_width:

  \<[`accessor`](https://qfes.github.io/rdeck/reference/accessor.md) \|
  [`scale`](https://qfes.github.io/rdeck/reference/scale.md) \|
  `number`\> The text background border width, if
  `text_background = TRUE`. Accepts a single numeric value, a numeric
  scale, or a
  [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html)
  column of numbers.

- line_joint_rounded:

  \<`boolean`\> If `TRUE`, draw round joints; else draw square joints.

- line_cap_rounded:

  \<`boolean`\> If `TRUE`, draw round caps; else draw square caps.

- line_miter_limit:

  number

- line_billboard:

  \<`boolean`\> If `TRUE`, extrude the path in screen space (width
  always faces) the camera; if `FALSE`, the width always faces up (z).

- extruded:

  \<`boolean`\> If `TRUE`, extrude objects along the z-axis; if `FALSE`,
  all objects will be flat.

- wireframe:

  \<`boolean`\> If `TRUE` and `extruded == TRUE`, draw a line wireframe
  of the object. The outline will have horizontal lines closing the top
  and bottom polygons and vertical lines for each vertex of the polygon.

- elevation_scale:

  \<`number`\> The elevation multiplier.

- material:

  \<`boolean`\>

- get_elevation:

  \<[`accessor`](https://qfes.github.io/rdeck/reference/accessor.md) \|
  [`scale`](https://qfes.github.io/rdeck/reference/scale.md) \|
  `number`\> The elevation to extrude each object in the z-axis. Height
  units are in metres. Accepts a single numeric value, a numeric scale,
  or a
  [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html)
  column of numbers.

- point_type:

  \<`"circle"`\|`"icon"`\|`"text"`\|combination\> Determines how to
  render point and multipoint features. May be one of:

  - `"circle"`

  - `"icon"`

  - `"text"`

  Or a combination, separated by `"+"`, e.g. `"circle+text"`.

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

<https://github.com/visgl/deck.gl/blob/8.7-release/docs/api-reference/layers/geojson-layer.md>

Other core-layers:
[`arc_layer`](https://qfes.github.io/rdeck/reference/arc_layer.md),
[`bitmap_layer`](https://qfes.github.io/rdeck/reference/bitmap_layer.md),
[`column_layer`](https://qfes.github.io/rdeck/reference/column_layer.md),
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
[`arc_layer`](https://qfes.github.io/rdeck/reference/arc_layer.md),
[`bitmap_layer`](https://qfes.github.io/rdeck/reference/bitmap_layer.md),
[`column_layer`](https://qfes.github.io/rdeck/reference/column_layer.md),
[`contour_layer`](https://qfes.github.io/rdeck/reference/contour_layer.md),
[`cpu_grid_layer`](https://qfes.github.io/rdeck/reference/cpu_grid_layer.md),
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

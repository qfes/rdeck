#' Arc Layer
#'
#' @name arc_layer
#' @inherit layer_props
#' @eval deckgl_docs("layers", "arc-layer")
#' @family core-layers
#' @family layers
NULL

#' Bitmap Layer
#'
#' @name bitmap_layer
#' @inherit layer_props
#' @param image The image to display. Either a string interpreted as a URL or Data URL,
#' or an array raster image.
#' @param desaturate number
#' @param transparent_color color
#' @param tint_color color
#' @eval deckgl_docs("layers", "bitmap-layer")
#' @family core-layers
#' @family layers
NULL

#' Icon Layer
#'
#' @name icon_layer
#' @inherit layer_props
#' @param icon_atlas object
#' @param icon_mapping object
#' @param billboard <`logical`> If `TRUE`, the text label always faces the camera, otherwise it
#' faces up (z).
#' @param alpha_cutoff number
#' @param get_icon <[`accessor`]>
#' @param get_size <[`accessor`] | [`scale`] | `numeric`> The icon size of each text label,
#' in units specified by `size_units`.
#' Accepts a single numeric value, a numeric scale, or a
#' [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html) column of numbers.
#' @param get_angle <[`accessor`] | `numeric`> The rotating angle of each icon in degrees.
#' Accepts a single numeric value, or a
#' [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html) column of numbers.
#' @eval deckgl_docs("layers", "icon-layer")
#' @family core-layers
#' @family layers
NULL

#' Line Layer
#'
#' @name line_layer
#' @inherit layer_props
#' @eval deckgl_docs("layers", "line-layer")
#' @family core-layers
#' @family layers
NULL

#' Point Cloud Layer
#'
#' @name point_cloud_layer
#' @inherit layer_props
#' @param get_normal <[`accessor`]>
#' @eval deckgl_docs("layers", "point-cloud-layer")
#' @family core-layers
#' @family layers
NULL

#' Scatterplot Layer
#'
#' @name scatterplot_layer
#' @inherit layer_props
#' @param radius_units <`"pixels"` | `"meters"`> The units of point radius.
#' @param radius_scale number
#' @param radius_min_pixels number
#' @param radius_max_pixels number
#' @eval deckgl_docs("layers", "scatterplot-layer")
#' @family core-layers
#' @family layers
NULL

#' Grid Cell Layer
#'
#' @name grid_cell_layer
#' @inherit layer_props
#' @eval deckgl_docs("layers", "grid-cell-layer")
#' @family core-layers
#' @family layers
NULL

#' Column Layer
#'
#' @name column_layer
#' @inherit layer_props
#' @param radius <`numeric`> The radius of the column in metres.
#' @param line_width_units <`"pixels"` | `"meters"`> The units of outline width.
#' Applied when `extruded = FALSE` and `stroked = TRUE`.
#' @eval deckgl_docs("layers", "column-layer")
#' @family core-layers
#' @family layers
NULL

#' Path Layer
#'
#' @name path_layer
#' @inherit layer_props
#' @eval deckgl_docs("layers", "path-layer")
#' @family core-layers
#' @family layers
NULL

#' Polygon Layer
#'
#' @name polygon_layer
#' @inherit layer_props
#' @eval deckgl_docs("layers", "polygon-layer")
#' @family core-layers
#' @family layers
NULL

#' Solid Polygon Layer
#'
#' @name solid_polygon_layer
#' @inherit layer_props
#' @eval deckgl_docs("layers", "solid-polygon-layer")
#' @family core-layers
#' @family layers
NULL

#' GeoJson Layer
#'
#' @name geojson_layer
#' @inheritParams layer_props
#' @param data sf
#' @eval deckgl_docs("layers", "geojson-layer")
#' @family core-layers
#' @family layers
NULL

#' Text Layer
#'
#' @name text_layer
#' @inherit layer_props
#' @param billboard <`logical`> If `TRUE`, the text label always faces the camera, otherwise it
#' faces up (z).
#' @param background_color color
#' @param font_family unknown
#' @param font_weight unknown
#' @param line_height number
#' @param font_settings object
#' @param word_break unknown
#' @param max_width number
#' @param get_text <[`accessor`]>
#' @param get_size <[`accessor`] | [`scale`] | `numeric`> The font size of each text label,
#' in units specified by `size_units`.
#' Accepts a single numeric value, a numeric scale, or a
#' [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html) column of numbers.
#' @param get_angle <[`accessor`] | `numeric`> The rotating angle of each icon in degrees.
#' Accepts a single numeric value, or a
#' [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html) column of numbers.
#' @param get_text_anchor <[`accessor`]>
#' @param get_alignment_baseline <[`accessor`]>
#' @eval deckgl_docs("layers", "text-layer")
#' @family core-layers
#' @family layers
NULL

#' Screen Grid Layer
#'
#' @name screen_grid_layer
#' @inherit layer_props
#' @param cell_size_pixels number
#' @param cell_margin_pixels number
#' @eval deckgl_docs("aggregation-layers", "screen-grid-layer")
#' @family aggregation-layers
#' @family layers
NULL

#' CPU Grid Layer
#'
#' @name cpu_grid_layer
#' @inherit layer_props
#' @eval deckgl_docs("aggregation-layers", "cpu-grid-layer")
#' @family aggregation-layers
#' @family layers
NULL

#' Hexagon Layer
#'
#' @name hexagon_layer
#' @inherit layer_props
#' @param radius <`numeric`> The radius of the hexagon bin in metres.
#' @param hexagon_aggregator function
#' @eval deckgl_docs("aggregation-layers", "hexagon-layer")
#' @family aggregation-layers
#' @family layers
NULL

#' Contour Layer
#'
#' @name contour_layer
#' @inherit layer_props
#' @param contours array
#' @param z_offset number
#' @eval deckgl_docs("aggregation-layers", "contour-layer")
#' @family aggregation-layers
#' @family layers
NULL

#' Grid Layer
#'
#' @name grid_layer
#' @inherit layer_props
#' @eval deckgl_docs("aggregation-layers", "grid-layer")
#' @family aggregation-layers
#' @family layers
NULL

#' GPU Grid Layer
#'
#' @name gpu_grid_layer
#' @inherit layer_props
#' @eval deckgl_docs("aggregation-layers", "gpu-grid-layer")
#' @family aggregation-layers
#' @family layers
NULL

#' Heatmap Layer
#'
#' @name heatmap_layer
#' @inherit layer_props
#' @param intensity number
#' @param radius_pixels number
#' @param threshold number
#' @eval deckgl_docs("aggregation-layers", "heatmap-layer")
#' @family aggregation-layers
#' @family layers
NULL

#' Great Circle Layer
#'
#' @name great_circle_layer
#' @inherit layer_props
#' @eval deckgl_docs("geo-layers", "great-circle-layer")
#' @family geo-layers
#' @family layers
NULL

#' S2 Layer
#'
#' @name s2_layer
#' @inherit layer_props
#' @param get_s2_token <[`accessor`]>
#' @eval deckgl_docs("geo-layers", "s2-layer")
#' @family geo-layers
#' @family layers
NULL

#' H3 Cluster Layer
#'
#' @name h3_cluster_layer
#' @inherit layer_props
#' @param get_hexagons <[`accessor`]>
#' @eval deckgl_docs("geo-layers", "h3-cluster-layer")
#' @family geo-layers
#' @family layers
NULL

#' H3 Hexagon Layer
#'
#' @name h3_hexagon_layer
#' @inherit layer_props
#' @param high_precision <`logical`>
#' @param center_hexagon unknown
#' @param get_hexagon <[`accessor`]>
#' @eval deckgl_docs("geo-layers", "h3-hexagon-layer")
#' @family geo-layers
#' @family layers
NULL

#' Tile Layer
#'
#' @name tile_layer
#' @inherit layer_props
#' @eval deckgl_docs("geo-layers", "tile-layer")
#' @family geo-layers
#' @family layers
NULL

#' Trips Layer
#'
#' @name trips_layer
#' @inherit layer_props
#' @param trail_length number
#' @param current_time number
#' @param get_timestamps <[`accessor`]>
#' @eval deckgl_docs("geo-layers", "trips-layer")
#' @family geo-layers
#' @family layers
NULL

#' Tile 3D Layer
#'
#' @name tile_3d_layer
#' @inherit layer_props
#' @param get_point_color <[`accessor`] | [`scale`] | [`color`]> The colour of each object.
#' Accepts a single colour value, a colour scale, or a
#' [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html) column of colours.
#' @param load_options object
#' @param loader object
#' @eval deckgl_docs("geo-layers", "tile3d-layer")
#' @family geo-layers
#' @family layers
NULL

#' Terrain Layer
#'
#' @name terrain_layer
#' @inherit layer_props
#' @param elevation_data url
#' @param mesh_max_error number
#' @param bounds <`bbox`> A sf::st_bbox() object with CRS [EPSG:4326](http://epsg.io/4326). Must be supplied hen using
#' non-tiled elevation data.
#' @param color color
#' @param elevation_decoder object
#' @param worker_url string
#' @eval deckgl_docs("geo-layers", "terrain-layer")
#' @family geo-layers
#' @family layers
NULL

#' MVT Layer
#'
#' @name mvt_layer
#' @inherit layer_props
#' @param unique_id_property string
#' @param highlighted_feature_id unknown
#' @eval deckgl_docs("geo-layers", "mvt-layer")
#' @family geo-layers
#' @family layers
NULL

#' Simple Mesh Layer
#'
#' @name simple_mesh_layer
#' @inherit layer_props
#' @param mesh object
#' @eval deckgl_docs("mesh-layers", "simple-mesh-layer")
#' @family mesh-layers
#' @family layers
NULL

#' Scenegraph Layer
#'
#' @name scenegraph_layer
#' @inherit layer_props
#' @param scenegraph object
#' @param get_scene function
#' @param get_animator function
#' @eval deckgl_docs("mesh-layers", "scenegraph-layer")
#' @family mesh-layers
#' @family layers
NULL


#' @title layer_props
#' @name layer_props
#' @rdname _layer_props
#' @param rdeck <[`rdeck`] | [`rdeck_proxy`]> An rdeck map instance.
#' @param ... Additional parameters that will be forwarded to deck.gl javascript without
#' validation nor processing. All dots must be named and will be `camelCased` when serialised.
#' Layers will raise a warning when dots are used, warning class `rdeck_dots_nonempty`.
#' @param id <`string`> The layer's identifier must be unique for among all layers of the same
#' type for a map. Defaults to [uuid::UUIDgenerate()], but should be explicitly defined for
#' updatable layers in a shiny application.
#' @param name <`string`> Identifies the layer on tooltips and legends. It does
#' not need to be unique, but should be brief. Defaults to the deck.gl class name for the layer.
#' @param tooltip <[`tooltip`]> Defines the columns (and their order) that will be displayed in
#' the layer tooltip, if `pickable = TRUE`. Supports <[`tidy-select`][dplyr::dplyr_tidy_select]>
#' if a `data` is a `data.frame`. `sfc` columns are always removed.
#' @param data <`data.frame` | `sf` | `string`> The layer's data. Data frames will contain all
#' columns that are referenced by the layer's accessors. Strings will be interpreted as a URL and
#' data will be retrieved dynamically in the browser.
#' @param visible <`logical`> Determines whether the layer is visible or not; also determines
#' whether any legend elements for the layer will be displayed.
#' @param pickable <`logical`> Determines if the layer responds to pointer / touch events.
#' @param opacity <`numeric`> Determines the layer's opacity.
#' @param position_format <`"XY"` | `"XYZ"`> Determines whether each coordinate has two (XY)
#' or three (XYZ) elements.
#' @param color_format <`"RGB"` | `"RGBA"`> Determines whether the alpha channel of the colours
#' will be ignored by accessors, making all colours opaque.
#' @param auto_highlight <`logical`> When `TRUE`, the current object _hovered_ by the cursor is
#' highlighted by `highlight_color`.
#' @param highlight_color <[`accessor`] | [`scale`] | [`color`]> When `auto_highlight` and
#' `pickable` are enabled, `highlight_color` determines the colour of the currently
#' highlighted object. If a single colour value is supplied, that colour will be used to
#' highlight all objects in the layer. Per-object highlighting is achieved with a colour scale,
#' or a [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html) column of colours.
#' @param get_source_position <[`accessor`]> The source position geometry column, an
#' `sfc_POINT` column with CRS [EPSG:4326](http://epsg.io/4326). Supports
#' [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html).
#' @param get_target_position <[`accessor`]> The target position geometry column, an
#' `sfc_POINT` column with CRS [EPSG:4326](http://epsg.io/4326). Supports
#' [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html).
#' @param get_source_color <[`accessor`] | [`scale`] | [`color`]> The colour of the
#' _source end_ of the arc.
#' Accepts a single colour value, a colour scale, or a
#' [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html) column of colours.
#' @param get_target_color <[`accessor`] | [`scale`] | [`color`]> The colour of the
#' _target end_ of the arc.
#' Accepts a single colour value, a colour scale, or a
#' [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html) column of colours.
#' @param get_width <[`accessor`] | [`scale`] | `numeric`> The width of each object, in units
#' specified by `width_scale`.
#' Accepts a single numeric value, a numeric scale, or a
#' [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html) column of numbers.
#' @param get_height <[`accessor`] | [`scale`] | `numeric`> The multiplier of layer of
#' layer height.
#' Accepts a single numeric value, a numeric scale, or a
#' [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html) column of numbers.
#' A value of 0 will make the layer flat.
#' @param get_tilt <[`accessor`] | `numeric`> Tilts the arcs by the specified number of
#' degrees (between `c(-90, 90)`).
#' Accepts a single numeric value or a
#' [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html) column of numbers.
#' @param great_circle <`logical`> If `TRUE`, create the arc along the shortest path on the
#' earth surface.
#' @param width_units <`"pixels"` | `"meters"`> The units of the `line_width`.
#' @param width_scale <`numeric`> The scaling multiplier for the width of each line.
#' @param width_min_pixels <`numeric`> The minimum line width in pixels.
#' @param width_max_pixels <`numeric`> The maximum line width in pixels.
#' @param bounds <`bbox`> A sf::st_bbox() object with CRS [EPSG:4326](http://epsg.io/4326).
#' @param billboard <`logical`> If `TRUE`, extrude the path in screen space (width always faces)
#' the camera; if `FALSE`, the width always faces up (z).
#' @param size_scale <`numeric`> The size multiplier.
#' @param size_units <`"pixels"` | `"meters"`> The units of the size specified by
#' `get_size`.
#' @param size_min_pixels <`numeric`> The minimum size in pixels.
#' @param size_max_pixels <`numeric`> The maximum size in pixels.
#' @param get_position <[`accessor`]> The position geometry column, an
#' `sfc_POINT` column with CRS [EPSG:4326](http://epsg.io/4326). Supports
#' [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html).
#' @param get_color <[`accessor`] | [`scale`] | [`color`]> The colour of each object.
#' Accepts a single colour value, a colour scale, or a
#' [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html) column of colours.
#' @param get_pixel_offset <[`accessor`] | `numeric`>
#' @param point_size <`numeric`> The radius of all points in units specified
#' by `size_units`.
#' @param material <`logical`>
#' @param line_width_units <`"pixels"` | `"meters"`> The units of line width.
#' @param line_width_scale <`numeric`> The line width multiplier.
#' @param line_width_min_pixels <`numeric`> The minimum line width in pixels.
#' @param line_width_max_pixels <`numeric`> The maximum line width in pixels.
#' @param stroked <`logical`> If `TRUE`, draw an outline around each object.
#' @param filled <`logical`> If `TRUE`, draw the filled area of each point.
#' @param get_radius <[`accessor`] | [`scale`] | `numeric`> The radius of each point, in units
#' specified by `radius_units`.
#' Accepts a single numeric value, a numeric scale, or a
#' [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html) column of numbers.
#' @param get_fill_color <[`accessor`] | [`scale`] | [`color`]> The fill colour of each object.
#' Accepts a single colour value, a colour scale, or a
#' [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html) column of colours.
#' @param get_line_color <[`accessor`] | [`scale`] | [`color`]> The line colour of each object.
#' Accepts a single colour value, a colour scale, or a
#' [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html) column of colours.
#' @param get_line_width <[`accessor`] | [`scale`] | `numeric`> The outline of the object
#' in units specified by `line_width_units`.
#' Accepts a single numeric value, a numeric scale, or a
#' [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html) column of numbers.
#' @param disk_resolution <`numeric`> The number of sides to render the disk as. The disk
#' is a regular polygon that fits inside the given `radius`. A higher resolution will yield
#' a smoother look close-up, but also need more resources to render.
#' @param vertices `matrix` Replace the default geometry (regular polygon that fits inside the
#' unit circle) with a custom one. The length of the array must be at least `disk_resolution`.
#' Each vertex is a row `c(x, y)` that is the offset from the instance position, relative
#' to the radius.
#' @param radius <`numeric`> The radius of the object in metres.
#' @param angle <`numeric`> The disk rotation, counter-clockwise in radians.
#' @param offset <`numeric`> The disk offset from the position, relative to the radius.
#' @param coverage <`numeric`> Radius multiplier, between 0 - 1. The radius of each disk is
#' calculated by `coverage * radius`.
#' @param elevation_scale <`numeric`> The elevation multiplier.
#' @param extruded <`logical`> If `TRUE`, extrude objects along the z-axis; if `FALSE`, all
#' objects will be flat.
#' @param wireframe <`logical`> If `TRUE` and `extruded = TRUE`, draw a line wireframe of the
#' object. The outline will have horizontal lines closing the top and bottom polygons and
#' vertical lines for each vertex of the polygon.
#' @param get_elevation <[`accessor`] | [`scale`] | `numeric`> The elevation to extrude each
#' object in the z-axis. Height units are in metres.
#' Accepts a single numeric value, a numeric scale, or a
#' [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html) column of numbers.
#' @param cell_size <`numeric`> The size of each cell in metres.
#' @param rounded <`logical`> The type of joint. If `TRUE`, draw round joints, else draw mitre
#' joints.
#' @param miter_limit <`numeric`> The maximum extent of a joint in ratio to the stroke width.
#' Only applicable if `rounded = FALSE`.
#' @param get_path <[`accessor`]> The path geometry column, an
#' `sfc_LINESTRING` column with CRS [EPSG:4326](http://epsg.io/4326). Supports
#' [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html).
#' @param line_joint_rounded <`logical`>
#' @param line_miter_limit number
#' @param get_polygon <[`accessor`]> The polygon geometry column, an
#' `sfc_POLYGON` column with CRS [EPSG:4326](http://epsg.io/4326). Supports
#' [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html).
#' @param point_radius_units <`"pixels"` | `"meters"`> The units of point radius.
#' @param point_radius_scale <`numeric`> The radius multiplier for all points.
#' @param point_radius_min_pixels <`numeric`> The minimum radius in pixels.
#' @param point_radius_max_pixels <`numeric`> The maximum radius in pixels.
#' @param color_domain <`numeric`> The colour scale domain, default is set to the range
#' of aggregated weights in each bin.
#' @param color_range <[`color`]> The colour palette.
#' `color_domain` is divided into `length(color_range)` equal segments, each mapped to
#' one color in `color_range`.
#' @param get_weight <[`accessor`] | [`scale`] | `numeric`> The weight of each object.
#' Accepts a single numeric value, a numeric scale, or a
#' [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html) column of numbers.
#' @param gpu_aggregation <`logical`> If `TRUE`, aggregation is performed on GPU if supported.
#' Requires `WebGL2`.
#' @param aggregation <`"SUM"` | `"MEAN"` | `"MIN"` | `"MAX"`> Defines the aggregation function.
#' @param get_color_value <[`JS`][htmlwidgets::JS]> After data objects are aggregated into bins,
#' this accessor is called on each bin to get the value that its colour is based on. If supplied,
#' this will override the effect of `get_color_weight` and `color_aggregation` props.
#' See deck.gl docs for details.
#' @param get_color_weight <[`accessor`] | [`scale`] | `numeric`> The weight of each object used
#' to calculate the colour value for a bin.
#' Accepts a single numeric value, a numeric scale, or a
#' [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html) column of numbers.
#' @param color_aggregation <`"SUM"` | `"MEAN"` | `"MIN"` | `"MAX"`>  Operation used to
#' aggregate data values/weights to calculate a bin's colour.
#' @param lower_percentile <`numeric`> Between `0` and `100`. Filter bins and re-calculate colour
#' by `lower_percentile`. Cells with `value < lower_percentile` will be hidden.
#' @param upper_percentile <`numeric`> Between `0` and `100`. Filter bins and re-calculate colour
#' by `upper_percentile`. Cells with `value < upper_percentile` will be hidden.
#' @param color_scale_type <`"quantize"` | `"linear"` | `"quantile"` | `"ordinal"`> The scaling
#' function used to determine the colour of a the grid cell.
#' @param elevation_domain <`numeric`> The elevation scale input domain. Defaults to the range
#' of the aggregated weights in each bin.
#' @param elevation_range <`numeric`> The elevation scale output range.
#' @param get_elevation_value <[`JS`][htmlwidgets::JS]> After data objects are aggregated into
#' bins, this accessor is called on each bin to get the value that its elevation is based on.
#' If supplied, this will override the effect of `get_elevation_weight` and
#' `elevation_aggregation` props.
#' See deck.gl docs for details.
#' @param get_elevation_weight <[`accessor`] | [`scale`] | `numeric> The weight of each object used
#' to calculate the elevation value for a bin.
#' Accepts a single numeric value, a numeric scale, or a
#' [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html) column of numbers.
#' @param elevation_aggregation <`"SUM"` | `"MEAN"` | `"MIN"` | `"MAX"`> Operation used to
#' aggregate data values/weights to calculate a bin's elevation value.
#' @param elevation_lower_percentile <`numeric`> Between `0` and `100`. Filter bins and
#' re-calculate elevation by `elevation_lower_percentile`.
#' Cells with `value < elevation_lower_percentile` will be hidden.
#' @param elevation_upper_percentile <`numeric`> Between `0` and `100`. Filter bins and
#' re-calculate elevation by `elevation_upper_percentile`.
#' Cells with `value < elevation_upper_percentile` will be hidden.
#' @param elevation_scale_type <`"quantize"` | `"linear"` | `"quantile"` | `"ordinal"`> The scaling
#' function used to determine the elevation of a the grid cell.
#' @param get_tile_data <[`JS`][htmlwidgets::JS]> retrieves the data of each tile.
#' See deck.gl [TileLayer](https://deck.gl/docs/api-reference/geo-layers/tile-layer#gettiledata).
#' @param extent <`c(min_x, min_y, max_x, max_y)`> Tiles in this bounding box
#'   will be rendered at `min_zoom`, when zoomed out below `min_zoom`.
#' @param tile_size <`number`> A power of 2 that is the pixel dimensions of the tile.
#' @param max_zoom <`number`> Tiles above this zoom level are not shown. Defaults to `NULL`.
#' @param min_zoom <`number`> Tiles below this zoom level are not shown. Defaults to `0`.
#' @param max_cache_size <`number`> Maximum number of tiles that can be cached. Defaults to
#' 5x the number of tiles in current viewport.
#' @param max_cache_byte_size <`number`> Maximum memory used for caching tiles.
#' @param refinement_strategy <`"best-available"` | `"no-overlap"` | `"never"`> How the tile
#' layer refines visibility of tiles. Defaults to `"best-available"`.
#' @param z_range <`c(min, max)`> Array representing the range of heights in the tile.
#' @param max_requests <`number`> Maximum number of concurrent HTTP
#'   requests across all specified tile provider domains. If a negative number is
#'   supplied no throttling occurs (HTTP/2 only).
#' @param texture not yet supported.
#' @param get_orientation <[`accessor`]> not yet supported.
#' @param get_scale <[`accessor`]> not yet supported.
#' @param get_translation <[`accessor`]> not yet supported.
#' @param get_transform_matrix <[`accessor`]> not yet supported.
NULL

deckgl_docs <- function(module, name) {
  version <- "v8.3.11"
  url <- file.path(
    "https://github.com/visgl/deck.gl/blob",
    version,
    "docs/api-reference",
    module,
    paste0(name, ".md"),
    fsep = "/"
  )

  paste0("@seealso <", url, ">")
}

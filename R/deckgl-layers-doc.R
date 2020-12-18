#' Arc Layer
#'
#' @name arc_layer
#' @inherit layer_props
#' @eval deckgl_docs("layers", "arc-layer")
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
#' @family layers
NULL

#' Icon Layer
#'
#' @name icon_layer
#' @inherit layer_props
#' @param icon_atlas object
#' @param icon_mapping object
#' @param alpha_cutoff number
#' @param get_icon <[`accessor`]>
#' @eval deckgl_docs("layers", "icon-layer")
#' @family layers
NULL

#' Line Layer
#'
#' @name line_layer
#' @inherit layer_props
#' @eval deckgl_docs("layers", "line-layer")
#' @family layers
NULL

#' Point Cloud Layer
#'
#' @name point_cloud_layer
#' @inherit layer_props
#' @param get_normal <[`accessor`]>
#' @eval deckgl_docs("layers", "point-cloud-layer")
#' @family layers
NULL

#' Scatterplot Layer
#'
#' @name scatterplot_layer
#' @inherit layer_props
#' @param radius_units unknown
#' @param radius_scale number
#' @param radius_min_pixels number
#' @param radius_max_pixels number
#' @eval deckgl_docs("layers", "scatterplot-layer")
#' @family layers
NULL

#' Grid Cell Layer
#'
#' @name grid_cell_layer
#' @inherit layer_props
#' @eval deckgl_docs("layers", "grid-cell-layer")
#' @family layers
NULL

#' Column Layer
#'
#' @name column_layer
#' @inherit layer_props
#' @eval deckgl_docs("layers", "column-layer")
#' @family layers
NULL

#' Path Layer
#'
#' @name path_layer
#' @inherit layer_props
#' @eval deckgl_docs("layers", "path-layer")
#' @family layers
NULL

#' Polygon Layer
#'
#' @name polygon_layer
#' @inherit layer_props
#' @eval deckgl_docs("layers", "polygon-layer")
#' @family layers
NULL

#' Solid Polygon Layer
#'
#' @name solid_polygon_layer
#' @inherit layer_props
#' @eval deckgl_docs("layers", "solid-polygon-layer")
#' @family layers
NULL

#' GeoJson Layer
#'
#' @name geojson_layer
#' @param data sf
#' @eval deckgl_docs("layers", "geojson-layer")
#' @family layers
NULL

#' Text Layer
#'
#' @name text_layer
#' @inherit layer_props
#' @param background_color color
#' @param font_family unknown
#' @param font_weight unknown
#' @param line_height number
#' @param font_settings object
#' @param word_break unknown
#' @param max_width number
#' @param get_text <[`accessor`]>
#' @param get_text_anchor <[`accessor`]>
#' @param get_alignment_baseline <[`accessor`]>
#' @eval deckgl_docs("layers", "text-layer")
#' @family layers
NULL

#' Screen Grid Layer
#'
#' @name screen_grid_layer
#' @inherit layer_props
#' @param cell_size_pixels number
#' @param cell_margin_pixels number
#' @eval deckgl_docs("aggregation-layers", "screen-grid-layer")
#' @family layers
#' @family aggregation-layers
NULL

#' CPU Grid Layer
#'
#' @name cpu_grid_layer
#' @inherit layer_props
#' @eval deckgl_docs("aggregation-layers", "cpu-grid-layer")
#' @family layers
#' @family aggregation-layers
NULL

#' Hexagon Layer
#'
#' @name hexagon_layer
#' @inherit layer_props
#' @param hexagon_aggregator function
#' @eval deckgl_docs("aggregation-layers", "hexagon-layer")
#' @family layers
#' @family aggregation-layers
NULL

#' Contour Layer
#'
#' @name contour_layer
#' @inherit layer_props
#' @param contours array
#' @param z_offset number
#' @eval deckgl_docs("aggregation-layers", "contour-layer")
#' @family layers
#' @family aggregation-layers
NULL

#' Grid Layer
#'
#' @name grid_layer
#' @inherit layer_props
#' @eval deckgl_docs("aggregation-layers", "grid-layer")
#' @family layers
#' @family aggregation-layers
NULL

#' GPU Grid Layer
#'
#' @name gpu_grid_layer
#' @inherit layer_props
#' @eval deckgl_docs("aggregation-layers", "gpu-grid-layer")
#' @family layers
#' @family aggregation-layers
NULL

#' Heatmap Layer
#'
#' @name heatmap_layer
#' @inherit layer_props
#' @param intensity number
#' @param radius_pixels number
#' @param threshold number
#' @eval deckgl_docs("aggregation-layers", "heatmap-layer")
#' @family layers
#' @family aggregation-layers
NULL

#' Great Circle Layer
#'
#' @name great_circle_layer
#' @inherit layer_props
#' @eval deckgl_docs("geo-layers", "great-circle-layer")
#' @family layers
#' @family geo-layers
NULL

#' S2 Layer
#'
#' @name s2_layer
#' @inherit layer_props
#' @param get_s2_token <[`accessor`]>
#' @eval deckgl_docs("geo-layers", "s2-layer")
#' @family layers
#' @family geo-layers
NULL

#' H3 Cluster Layer
#'
#' @name h3_cluster_layer
#' @inherit layer_props
#' @param get_hexagons <[`accessor`]>
#' @eval deckgl_docs("geo-layers", "h3-cluster-layer")
#' @family layers
#' @family geo-layers
NULL

#' H3 Hexagon Layer
#'
#' @name h3_hexagon_layer
#' @inherit layer_props
#' @param high_precision <`logical`>
#' @param center_hexagon unknown
#' @param get_hexagon <[`accessor`]>
#' @eval deckgl_docs("geo-layers", "h3-hexagon-layer")
#' @family layers
#' @family geo-layers
NULL

#' Tile Layer
#'
#' @name tile_layer
#' @inherit layer_props
#' @eval deckgl_docs("geo-layers", "tile-layer")
#' @family layers
#' @family geo-layers
NULL

#' Trips Layer
#'
#' @name trips_layer
#' @inherit layer_props
#' @param trail_length number
#' @param current_time number
#' @param get_timestamps <[`accessor`]>
#' @eval deckgl_docs("geo-layers", "trips-layer")
#' @family layers
#' @family geo-layers
NULL

#' Tile 3D Layer
#'
#' @name tile_3d_layer
#' @inherit layer_props
#' @param get_point_color array
#' @param load_options object
#' @param loader object
#' @eval deckgl_docs("geo-layers", "tile3d-layer")
#' @family layers
#' @family geo-layers
NULL

#' Terrain Layer
#'
#' @name terrain_layer
#' @inherit layer_props
#' @param elevation_data url
#' @param mesh_max_error number
#' @param color color
#' @param elevation_decoder object
#' @param worker_url string
#' @eval deckgl_docs("geo-layers", "terrain-layer")
#' @family layers
#' @family geo-layers
NULL

#' MVT Layer
#'
#' @name mvt_layer
#' @inherit layer_props
#' @param unique_id_property string
#' @param highlighted_feature_id unknown
#' @eval deckgl_docs("geo-layers", "mvt-layer")
#' @family layers
#' @family geo-layers
NULL

#' Simple Mesh Layer
#'
#' @name simple_mesh_layer
#' @inherit layer_props
#' @param mesh object
#' @eval deckgl_docs("mesh-layers", "simple-mesh-layer")
#' @family layers
#' @family mesh-layers
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
NULL


#' @title layer_props
#' @name layer_props
#' @rdname _layer_props
#' @param ... Additional parameters that will be forwarded to deck.gl javascript without
#' validation nor processing. All dots must be named and will be `camelCased` when serialised.
#' Layers will raise a warning when dots are used, warning class `rdeck_dots_nonempty`.
#' @param id <`string`> The layer's identifier must be unique for among all layers of the same
#' type for a map. Defaults to [uuid::UUIDgenerate()], but should be explicitly defined for
#' updatable layers in a shiny application.
#' @param name <`string`> Identifies the layer on tooltips and legends. It does
#' not need to be unique, but should be brief. Defaults to the deck.gl class name for the layer.
#' @param tooltip <[`tooltip`]> Defines the columns (and their order) that will be displayed in
#' the layer tooltip, if `pickable = TRUE`.
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
#' highlight all objects in the layer. Per-object highlighting is achieved with an `accessor`
#' resolving a column in `data`, or a `scale` to transform a column into a colour.
#' @param get_source_position <[`accessor`]> The source position geometry column, an
#' `sfc_POINT` column with CRS EPSG:4326. Supports
#' <[`tidy-eval`](https://dplyr.tidyverse.org/articles/programming.html)>.
#' @param get_target_position <[`accessor`]> The target position geometry column, an
#' `sfc_POINT` column with CRS EPSG:4326. Supports
#' <[`tidy-eval`](https://dplyr.tidyverse.org/articles/programming.html)>.
#' @param get_source_color <[`accessor`] | [`scale`] | [`color`]> The colour of the
#' _source end_ of the arc. Accepts a single colour value, a
#' <[`tidy-eval`](https://dplyr.tidyverse.org/articles/programming.html)> column of
#' colours or a scale function.
#' @param get_target_color <[`accessor`] | [`scale`] | [`color`]> The colour of the
#' _target end_ of the arc. Accepts a single colour value, a
#' <[`tidy-eval`](https://dplyr.tidyverse.org/articles/programming.html)> column of
#' colours or a scale function.
#' @param get_width <[`accessor`]>
#' @param get_height <[`accessor`]>
#' @param get_tilt <[`accessor`]>
#' @param great_circle <`logical`>
#' @param width_units unknown
#' @param width_scale number
#' @param width_min_pixels number
#' @param width_max_pixels number
#' @param bounds array
#' @param size_scale number
#' @param billboard <`logical`>
#' @param size_units unknown
#' @param size_min_pixels number
#' @param size_max_pixels number
#' @param get_position <[`accessor`]>
#' @param get_color <[`accessor`]>
#' @param get_size <[`accessor`]>
#' @param get_angle <[`accessor`]>
#' @param get_pixel_offset <[`accessor`]>
#' @param point_size number
#' @param material <`logical`>
#' @param line_width_units unknown
#' @param line_width_scale number
#' @param line_width_min_pixels number
#' @param line_width_max_pixels number
#' @param stroked <`logical`>
#' @param filled <`logical`>
#' @param get_radius <[`accessor`]>
#' @param get_fill_color <[`accessor`]>
#' @param get_line_color <[`accessor`]>
#' @param get_line_width <[`accessor`]>
#' @param disk_resolution number
#' @param vertices unknown
#' @param radius number
#' @param angle number
#' @param offset array
#' @param coverage number
#' @param elevation_scale number
#' @param extruded <`logical`>
#' @param wireframe <`logical`>
#' @param get_elevation <[`accessor`]>
#' @param cell_size number
#' @param rounded <`logical`>
#' @param miter_limit number
#' @param get_path <[`accessor`]>
#' @param line_joint_rounded <`logical`>
#' @param line_miter_limit number
#' @param get_polygon <[`accessor`]>
#' @param point_radius_units unknown
#' @param point_radius_scale number
#' @param point_radius_min_pixels number
#' @param point_radius_max_pixels number
#' @param color_domain unknown
#' @param color_range array
#' @param get_weight <[`accessor`]>
#' @param gpu_aggregation <`logical`>
#' @param aggregation unknown
#' @param get_color_value unknown
#' @param get_color_weight <[`accessor`]>
#' @param color_aggregation unknown
#' @param lower_percentile number
#' @param upper_percentile number
#' @param color_scale_type unknown
#' @param elevation_domain unknown
#' @param elevation_range array
#' @param get_elevation_value unknown
#' @param get_elevation_weight <[`accessor`]>
#' @param elevation_aggregation unknown
#' @param elevation_lower_percentile number
#' @param elevation_upper_percentile number
#' @param elevation_scale_type unknown
#' @param grid_aggregator function
#' @param get_tile_data function
#' @param extent array
#' @param tile_size number
#' @param max_zoom unknown
#' @param min_zoom number
#' @param max_cache_size unknown
#' @param max_cache_byte_size unknown
#' @param refinement_strategy unknown
#' @param z_range unknown
#' @param max_requests <number> The maximiun number of concurrent HTTP
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

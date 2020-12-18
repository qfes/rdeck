#' ArcLayer
#'
#' @name arc_layer
#' @inherit layer
#' @param get_source_position <[`accessor`]>
#' @param get_target_position
#' @param get_source_color
#' @param get_target_color
#' @param get_width
#' @param get_height
#' @param get_tilt
#' @param great_circle
#' @param width_units
#' @param width_scale
#' @param width_min_pixels
#' @param width_max_pixels
#' @eval deckgl_docs("layers", "arc-layer")
#' @family layers
NULL

#' BitmapLayer
#'
#' @name bitmap_layer
#' @inherit layer
#' @param image The image to display. Either a string interpreted as a URL or Data URL,
#' or an array raster image.
#' @param bounds
#' @param desaturate
#' @param transparent_color
#' @param tint_color
#' @eval deckgl_docs("layers", "bitmap-layer")
#' @family layers
NULL

#' IconLayer
#'
#' @name icon_layer
#' @inherit layer
#' @param icon_atlas
#' @param icon_mapping
#' @param size_scale
#' @param billboard
#' @param size_units
#' @param size_min_pixels
#' @param size_max_pixels
#' @param alpha_cutoff
#' @param get_position
#' @param get_icon
#' @param get_color
#' @param get_size
#' @param get_angle
#' @param get_pixel_offset
#' @eval deckgl_docs("layers", "icon-layer")
#' @family layers
NULL

#' LineLayer
#'
#' @name line_layer
#' @inherit layer
#' @param get_source_position
#' @param get_target_position
#' @param get_color
#' @param get_width
#' @param width_units
#' @param width_scale
#' @param width_min_pixels
#' @param width_max_pixels
#' @eval deckgl_docs("layers", "line-layer")
#' @family layers
NULL

#' PointCloudLayer
#'
#' @name point_cloud_layer
#' @inherit layer
#' @param size_units
#' @param point_size
#' @param get_position
#' @param get_normal
#' @param get_color
#' @param material
#' @eval deckgl_docs("layers", "point-cloud-layer")
#' @family layers
NULL

#' ScatterplotLayer
#'
#' @name scatterplot_layer
#' @inherit layer
#' @param radius_units
#' @param radius_scale
#' @param radius_min_pixels
#' @param radius_max_pixels
#' @param line_width_units
#' @param line_width_scale
#' @param line_width_min_pixels
#' @param line_width_max_pixels
#' @param stroked
#' @param filled
#' @param get_position
#' @param get_radius
#' @param get_fill_color
#' @param get_line_color
#' @param get_line_width
#' @eval deckgl_docs("layers", "scatterplot-layer")
#' @family layers
NULL

#' GridCellLayer
#'
#' @name grid_cell_layer
#' @inherit column_layer
#' @param cell_size
#' @eval deckgl_docs("layers", "grid-cell-layer")
#' @family layers
NULL

#' ColumnLayer
#'
#' @name column_layer
#' @inherit layer
#' @param disk_resolution
#' @param vertices
#' @param radius
#' @param angle
#' @param offset
#' @param coverage
#' @param elevation_scale
#' @param line_width_units
#' @param line_width_scale
#' @param line_width_min_pixels
#' @param line_width_max_pixels
#' @param extruded
#' @param wireframe
#' @param filled
#' @param stroked
#' @param get_position
#' @param get_fill_color
#' @param get_line_color
#' @param get_line_width
#' @param get_elevation
#' @param material
#' @eval deckgl_docs("layers", "column-layer")
#' @family layers
NULL

#' PathLayer
#'
#' @name path_layer
#' @inherit layer
#' @param width_units
#' @param width_scale
#' @param width_min_pixels
#' @param width_max_pixels
#' @param rounded
#' @param miter_limit
#' @param billboard
#' @param get_path
#' @param get_color
#' @param get_width
#' @eval deckgl_docs("layers", "path-layer")
#' @family layers
NULL

#' PolygonLayer
#'
#' @name polygon_layer
#' @inherit solid_polygon_layer
#' @param stroked
#' @param line_width_units
#' @param line_width_scale
#' @param line_width_min_pixels
#' @param line_width_max_pixels
#' @param line_joint_rounded
#' @param line_miter_limit
#' @param get_line_width
#' @eval deckgl_docs("layers", "polygon-layer")
#' @family layers
NULL

#' SolidPolygonLayer
#'
#' @name solid_polygon_layer
#' @inherit layer
#' @param filled
#' @param extruded
#' @param wireframe
#' @param elevation_scale
#' @param get_polygon
#' @param get_elevation
#' @param get_fill_color
#' @param get_line_color
#' @param material
#' @eval deckgl_docs("layers", "solid-polygon-layer")
#' @family layers
NULL

#' GeoJsonLayer
#'
#' @name geojson_layer
#' @inherit polygon_layer
#' @inherit scatterplot_layer
#' @param data sf
#' @param point_radius_units
#' @param point_radius_scale
#' @param point_radius_min_pixels
#' @param point_radius_max_pixels
#' @eval deckgl_docs("layers", "geojson-layer")
#' @family layers
NULL

#' TextLayer
#'
#' @name text_layer
#' @inherit icon_layer
#' @param background_color
#' @param font_family
#' @param font_weight
#' @param line_height
#' @param font_settings
#' @param word_break
#' @param max_width
#' @param get_text
#' @param get_text_anchor
#' @param get_alignment_baseline
#' @eval deckgl_docs("layers", "text-layer")
#' @family layers
NULL

#' ScreenGridLayer
#'
#' @name screen_grid_layer
#' @inherit grid_aggregation_layer
#' @param cell_size_pixels
#' @param cell_margin_pixels
#' @param color_domain
#' @param color_range
#' @param get_position
#' @param get_weight
#' @param gpu_aggregation
#' @param aggregation
#' @eval deckgl_docs("aggregation-layers", "screen-grid-layer")
#' @family layers
NULL

#' CPUGridLayer
#'
#' @name cpu_grid_layer
#' @inherit aggregation_layer
#' @param grid_aggregator
#' @param cell_size
#' @param coverage
#' @param get_position
#' @param extruded
#' @param material
#' @eval deckgl_docs("aggregation-layers", "cpu-grid-layer")
#' @family layers
NULL

#' HexagonLayer
#'
#' @name hexagon_layer
#' @inherit column_layer
#' @inherit aggregation_layer
#' @param hexagon_aggregator
#' @eval deckgl_docs("aggregation-layers", "hexagon-layer")
#' @family layers
NULL

#' ContourLayer
#'
#' @name contour_layer
#' @inherit grid_aggregation_layer
#' @param cell_size
#' @param get_position
#' @param get_weight
#' @param gpu_aggregation
#' @param aggregation
#' @param contours
#' @param z_offset
#' @eval deckgl_docs("aggregation-layers", "contour-layer")
#' @family layers
NULL

#' GridLayer
#'
#' @name grid_layer
#' @inherit layer
#' @param color_domain
#' @param color_range
#' @param get_color_weight
#' @param color_aggregation
#' @param elevation_domain
#' @param elevation_range
#' @param get_elevation_weight
#' @param elevation_aggregation
#' @param elevation_scale
#' @param cell_size
#' @param coverage
#' @param get_position
#' @param extruded
#' @param material
#' @param get_color_value
#' @param lower_percentile
#' @param upper_percentile
#' @param color_scale_type
#' @param get_elevation_value
#' @param elevation_lower_percentile
#' @param elevation_upper_percentile
#' @param elevation_scale_type
#' @param grid_aggregator
#' @param gpu_aggregation
#' @eval deckgl_docs("aggregation-layers", "grid-layer")
#' @family layers
NULL

#' GPUGridLayer
#'
#' @name gpu_grid_layer
#' @inherit grid_aggregation_layer
#' @param color_domain
#' @param color_range
#' @param get_color_weight
#' @param color_aggregation
#' @param elevation_domain
#' @param elevation_range
#' @param get_elevation_weight
#' @param elevation_aggregation
#' @param elevation_scale
#' @param cell_size
#' @param coverage
#' @param get_position
#' @param extruded
#' @param material
#' @eval deckgl_docs("aggregation-layers", "gpu-grid-layer")
#' @family layers
NULL

#' HeatmapLayer
#'
#' @name heatmap_layer
#' @inherit aggregation_layer
#' @param get_position
#' @param get_weight
#' @param intensity
#' @param radius_pixels
#' @param color_range
#' @param threshold
#' @param color_domain
#' @eval deckgl_docs("aggregation-layers", "heatmap-layer")
#' @family layers
NULL

#' GreatCircleLayer
#'
#' @name great_circle_layer
#' @inherit arc_layer
#' @eval deckgl_docs("geo-layers", "great-circle-layer")
#' @family layers
NULL

#' S2Layer
#'
#' @name s2_layer
#' @inherit layer
#' @param get_s2_token
#' @eval deckgl_docs("geo-layers", "s2-layer")
#' @family layers
NULL

#' H3ClusterLayer
#'
#' @name h3_cluster_layer
#' @inherit h3_hexagon_layer
#' @param get_hexagons
#' @eval deckgl_docs("geo-layers", "h3-cluster-layer")
#' @family layers
NULL

#' H3HexagonLayer
#'
#' @name h3_hexagon_layer
#' @inherit polygon_layer
#' @param high_precision
#' @param coverage
#' @param center_hexagon
#' @param get_hexagon
#' @eval deckgl_docs("geo-layers", "h3-hexagon-layer")
#' @family layers
NULL

#' TileLayer
#'
#' @name tile_layer
#' @inherit layer
#' @param get_tile_data
#' @param extent
#' @param tile_size
#' @param max_zoom
#' @param min_zoom
#' @param max_cache_size
#' @param max_cache_byte_size
#' @param refinement_strategy
#' @param z_range
#' @param max_requests
#' @eval deckgl_docs("geo-layers", "tile-layer")
#' @family layers
NULL

#' TripsLayer
#'
#' @name trips_layer
#' @inherit path_layer
#' @param trail_length
#' @param current_time
#' @param get_timestamps
#' @eval deckgl_docs("geo-layers", "trips-layer")
#' @family layers
NULL

#' Tile3DLayer
#'
#' @name tile_3d_layer
#' @inherit layer
#' @param get_point_color
#' @param point_size
#' @param load_options
#' @param loader
#' @eval deckgl_docs("geo-layers", "tile3d-layer")
#' @family layers
NULL

#' TerrainLayer
#'
#' @name terrain_layer
#' @inherit tile_layer
#' @inherit simple_mesh_layer
#' @param elevation_data
#' @param texture
#' @param mesh_max_error
#' @param bounds
#' @param color
#' @param elevation_decoder
#' @param worker_url
#' @eval deckgl_docs("geo-layers", "terrain-layer")
#' @family layers
NULL

#' MVTLayer
#'
#' @name mvt_layer
#' @inherit tile_layer
#' @inherit geojson_layer
#' @param data a url
#' @param unique_id_property
#' @param highlighted_feature_id
#' @eval deckgl_docs("geo-layers", "mvt-layer")
#' @family layers
NULL

#' SimpleMeshLayer
#'
#' @name simple_mesh_layer
#' @inherit layer
#' @param mesh
#' @param texture
#' @param size_scale
#' @param wireframe
#' @param material
#' @param get_position
#' @param get_color
#' @param get_orientation
#' @param get_scale
#' @param get_translation
#' @param get_transform_matrix
#' @eval deckgl_docs("mesh-layers", "simple-mesh-layer")
#' @family layers
NULL

#' ScenegraphLayer
#'
#' @name scenegraph_layer
#' @inherit layer
#' @param scenegraph
#' @param get_scene
#' @param get_animator
#' @param size_scale
#' @param size_min_pixels
#' @param size_max_pixels
#' @param get_position
#' @param get_color
#' @param get_orientation
#' @param get_scale
#' @param get_translation
#' @param get_transform_matrix
#' @eval deckgl_docs("mesh-layers", "scenegraph-layer")
#' @family layers
NULL


#' @title layer
#' @name layer
#' @rdname _layer
#' @param id
#' @param name
#' @param data
#' @param visible
#' @param opacity
#' @param position_format
#' @param color_format
#' @param auto_highlight
#' @param highlight_color
NULL

#' @title aggregation_layer
#' @name aggregation_layer
#' @rdname _aggregation_layer
#' @param color_domain
#' @param color_range
#' @param get_color_value
#' @param get_color_weight
#' @param color_aggregation
#' @param lower_percentile
#' @param upper_percentile
#' @param color_scale_type
#' @param elevation_domain
#' @param elevation_range
#' @param get_elevation_value
#' @param get_elevation_weight
#' @param elevation_aggregation
#' @param elevation_lower_percentile
#' @param elevation_upper_percentile
#' @param elevation_scale_type
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

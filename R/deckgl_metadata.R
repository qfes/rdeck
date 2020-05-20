core_layers <- c(
  "ArcLayer",
  "BitmapLayer",
  "IconLayer",
  "LineLayer",
  "PointCloudLayer",
  "ScatterplotLayer",
  "ColumnLayer",
  "GridCellLayer",
  "PathLayer",
  "PolygonLayer",
  "GeoJsonLayer",
  "TextLayer",
  "SolidPolygonLayer"
)

aggregation_layers <- c(
  "ScreenGridLayer",
  "CPUGridLayer",
  "HexagonLayer",
  "ContourLayer",
  "GridLayer",
  "GPUGridLayer",
  "HeatmapLayer"
)

geo_layers <- c(
  "GreatCircleLayer",
  "S2Layer",
  "TileLayer",
  "TripsLayer",
  "H3ClusterLayer",
  "H3HexagonLayer",
  "Tile3DLayer",
  "TerrainLayer",
  "MVTLayer"
)

mesh_layers <- c(
  "SimpleMeshLayer",
  "ScenegraphLayer"
)

layers <- c(
  core_layers,
  aggregation_layers,
  geo_layers,
  mesh_layers
)

geometry_accessors <- c(
  "get_path",
  "getPath",
  "get_polygon",
  "getPolygon",
  "get_position",
  "getPosition",
  "get_source_position",
  "getSourcePosition",
  "get_target_position",
  "getTargetPosition"
)

geo_accessors <- c(
  "get_hexagon",
  "getHexagon",
  "get_hexagons",
  "getHexagons",
  "get_s2_token",
  "getS2Token"
)

scalable_accessors <- c(
  "get_color",
  "getColor",
  "get_color_weight",
  "getColorWeight",
  "get_elevation",
  "getElevation",
  "get_elevation_weight",
  "getElevationWeight",
  "get_fill_color",
  "getFillColor",
  "get_height",
  "getHeight",
  "get_line_color",
  "getLineColor",
  "get_line_width",
  "getLineWidth",
  "get_radius",
  "getRadius",
  "get_size",
  "getSize",
  "get_source_color",
  "getSourceColor",
  "get_target_color",
  "getTargetColor",
  "get_weight",
  "getWeight",
  "get_width",
  "getWidth"
)

accessors <- c(
  geometry_accessors,
  geo_accessors,
  scalable_accessors,
  "get_alignment_baseline",
  "getAlignmentBaseline",
  "get_angle",
  "getAngle",
  "get_color_value",
  "getColorValue",
  "get_elevation_value",
  "getElevationValue",
  "get_icon",
  "getIcon",
  "get_normal",
  "getNormal",
  "get_orientation",
  "getOrientation",
  "get_pixel_offset",
  "getPixelOffset",
  "get_scale",
  "getScale",
  "get_text",
  "getText",
  "get_text_anchor",
  "getTextAnchor",
  "get_tilt",
  "getTilt",
  "get_timestamps",
  "getTimestamps",
  "get_transform_matrix",
  "getTransformMatrix",
  "get_translation",
  "getTranslation"
)

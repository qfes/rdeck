% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/deckgl-layers.R, R/doc-deckgl-layers.R
\name{point_cloud_layer}
\alias{point_cloud_layer}
\alias{add_point_cloud_layer}
\alias{update_point_cloud_layer}
\title{Point Cloud Layer}
\usage{
add_point_cloud_layer(
  rdeck,
  ...,
  id = uuid::UUIDgenerate(),
  name = "PointCloudLayer",
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
  size_units = "pixels",
  point_size = 10,
  get_position = position,
  get_normal = c(0, 0, 1),
  get_color = "#000000ff",
  material = TRUE,
  blending_mode = "normal",
  visibility_toggle = TRUE,
  tooltip = NULL
)

update_point_cloud_layer(
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
  size_units = cur_value(),
  point_size = cur_value(),
  get_position = cur_value(),
  get_normal = cur_value(),
  get_color = cur_value(),
  material = cur_value(),
  blending_mode = cur_value(),
  visibility_toggle = cur_value(),
  tooltip = cur_value()
)
}
\arguments{
\item{rdeck}{<\code{\link{rdeck}} | \code{\link{rdeck_proxy}}> An rdeck map instance.}

\item{...}{Additional parameters that will be forwarded to deck.gl javascript without
validation nor processing. All dots must be named and will be \code{camelCased} when serialised.
A warning is raised when dots are used, warning class \code{rdeck_dots_nonempty}.}

\item{id}{<\code{string}> The layer's identifier must be unique for among all layers of the same
type for a map. Defaults to \code{\link[uuid:UUIDgenerate]{uuid::UUIDgenerate()}}, but should be explicitly defined for
updatable layers in a shiny application.}

\item{name}{<\code{string}> Identifies the layer on tooltips and legends. It does
not need to be unique, but should be brief. Defaults to the deck.gl class name for the layer.}

\item{group_name}{<\code{string}> Defines the group that this layer belongs to. Currently only
effective on the layer selector, if \code{visibility_toggle = TRUE}.}

\item{data}{<\code{data.frame} | \code{\link[sf:sf]{sf}} | \code{string}> The layer's data. Data frames and
sf objects will contain all columns that are referenced by the layer's accessors. Strings
will be interpreted as a URL and data will be retrieved dynamically in the browser.}

\item{visible}{<\code{boolean}> Determines whether the layer is visible or not; also determines
whether any legend elements for the layer will be displayed.}

\item{pickable}{<\code{boolean}> Determines if the layer responds to pointer / touch events.}

\item{opacity}{<\code{number}> Determines the layer's opacity.}

\item{wrap_longitude}{<\code{boolean}> Normalises geometry longitudes.}

\item{position_format}{<\code{"XY"} | \code{"XYZ"}> Determines whether each coordinate has two (XY)
or three (XYZ) elements.}

\item{color_format}{<\code{"RGB"} | \code{"RGBA"}> Determines whether the alpha channel of the colours
will be ignored by accessors, making all colours opaque.}

\item{auto_highlight}{<\code{boolean}> When \code{TRUE}, the current object \emph{hovered} by the cursor is
highlighted by \code{highlight_color}.}

\item{highlight_color}{<\code{\link{accessor}} | \code{\link{scale}} | \code{\link{color}}> When \code{auto_highlight} and
\code{pickable} are enabled, \code{highlight_color} determines the colour of the currently
highlighted object. If a single colour value is supplied, that colour will be used to
highlight all objects in the layer. Per-object highlighting is achieved with a colour scale,
or a \href{https://dplyr.tidyverse.org/articles/programming.html}{tidy-eval} column of colours.}

\item{size_units}{<\code{"pixels"} | \code{"common"} | \code{"meters"}> The units of the size specified by
\code{get_size}.}

\item{point_size}{<\code{number}> The radius of all points in units specified
by \code{size_units}.}

\item{get_position}{<\code{\link{accessor}}> The feature positions. A
\verb{<point/multipoint>} \link{wk-geometry} column with CRS \href{http://epsg.io/4326}{EPSG:4326}.
Supports \href{https://dplyr.tidyverse.org/articles/programming.html}{tidy-eval}.}

\item{get_normal}{<\code{\link{accessor}} | \code{numeric}> The normal of each object, in \code{c(nx, ny, nz)}.
Accepts a length-3 numeric vector, or a
\href{https://dplyr.tidyverse.org/articles/programming.html}{tidy-eval} 3-column matrix column.}

\item{get_color}{<\code{\link{accessor}} | \code{\link{scale}} | \code{\link{color}}> The colour of each object.
Accepts a single colour value, a colour scale, or a
\href{https://dplyr.tidyverse.org/articles/programming.html}{tidy-eval} column of colours.}

\item{material}{<\code{boolean}>}

\item{blending_mode}{<\code{"normal"} | \code{"additive"} | \code{"subtractive"}> Sets the blending mode.
Blending modes:
\itemize{
\item \code{normal}: Normal blending doesn't alter colours of overlapping objects.
\item \code{additive}: Additive blending adds colours of overlapping objects. Useful for highlighting
dot density on dark maps.
\item \code{subtractive}: Subtractive blending darkens overlapping objects. Useful for highlighting
dot density on light maps.
}}

\item{visibility_toggle}{<\code{boolean}> Whether this layer will appear in the layer selector.}

\item{tooltip}{<\code{\link{tooltip}}> Defines the columns (and their order) that will be displayed in
the layer tooltip, if \code{pickable == TRUE}.
Supports \href{https://dplyr.tidyverse.org/reference/dplyr_tidy_select.html}{tidy-select} if a
\code{data} is a \code{data.frame}. Geometry columns are always removed.}
}
\description{
Point Cloud Layer
}
\seealso{
\url{https://github.com/visgl/deck.gl/blob/8.7-release/docs/api-reference/layers/point-cloud-layer.md}

Other core-layers: 
\code{\link{arc_layer}},
\code{\link{bitmap_layer}},
\code{\link{column_layer}},
\code{\link{geojson_layer}},
\code{\link{grid_cell_layer}},
\code{\link{icon_layer}},
\code{\link{line_layer}},
\code{\link{path_layer}},
\code{\link{polygon_layer}},
\code{\link{scatterplot_layer}},
\code{\link{solid_polygon_layer}},
\code{\link{text_layer}}

Other layers: 
\code{\link{arc_layer}},
\code{\link{bitmap_layer}},
\code{\link{column_layer}},
\code{\link{contour_layer}},
\code{\link{cpu_grid_layer}},
\code{\link{geojson_layer}},
\code{\link{gpu_grid_layer}},
\code{\link{great_circle_layer}},
\code{\link{grid_cell_layer}},
\code{\link{grid_layer}},
\code{\link{h3_cluster_layer}},
\code{\link{h3_hexagon_layer}},
\code{\link{heatmap_layer}},
\code{\link{hexagon_layer}},
\code{\link{icon_layer}},
\code{\link{line_layer}},
\code{\link{mvt_layer}},
\code{\link{path_layer}},
\code{\link{polygon_layer}},
\code{\link{quadkey_layer}},
\code{\link{s2_layer}},
\code{\link{scatterplot_layer}},
\code{\link{scenegraph_layer}},
\code{\link{screen_grid_layer}},
\code{\link{simple_mesh_layer}},
\code{\link{solid_polygon_layer}},
\code{\link{terrain_layer}},
\code{\link{text_layer}},
\code{\link{tile_3d_layer}},
\code{\link{tile_layer}},
\code{\link{trips_layer}}
}
\concept{core-layers}
\concept{layers}

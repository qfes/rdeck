% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/shiny.R
\name{rdeck_proxy}
\alias{rdeck_proxy}
\title{RDeck proxy}
\usage{
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
}
\arguments{
\item{id}{<\code{string}> The map id}

\item{session}{<\code{ShinySession}> The shiny session}

\item{map_style}{<\code{string}> The mapbox basemap style url.
See \url{https://docs.mapbox.com/api/maps/#mapbox-styles}}

\item{theme}{<\code{"kepler"} | \code{"light"}> The widget theme which alters the style of the
legend and tooltips.}

\item{initial_bounds}{<\code{\link[wk:rct]{rct}}/\code{\link[sf:st_bbox]{st_bbox}}/\code{\link{wk-geometry}}>
Sets the initial bounds of the map if not \code{NULL}. Takes priority over \code{initial_view_state}.
Accepts a bounding box, or a geometry from which a bounding box can be computed. Requires
CRS \href{http://epsg.io/4326}{EPSG:4326}.}

\item{initial_view_state}{<\code{\link{view_state}}> Defines the map position, zoom, bearing and pitch.}

\item{controller}{<\code{logical}> If \code{NULL} or \code{FALSE}, the map is not interactive.}

\item{picking_radius}{<\code{number}> Extra pixels around the pointer to include while picking;
useful when rendering objects that are difficult to hover, e.g. thin lines, small points, etc.}

\item{use_device_pixels}{<\code{logical} | \code{number}> Controls the resolution of drawing buffer used
for rendering.
\itemize{
\item \code{TRUE}: Resolution is defined by \code{window.devicePixelRatio}. On Retina/HD displays, this
resolution is usually twice as big as \verb{CSS pixels} resolution.
\item \code{FALSE}: \verb{CSS pixels} resolution is used for rendering.
\item \code{number}: Custom ratio (drawing buffer resolution to \verb{CSS pixel}) to determine drawing
buffer size. A value less than \code{1} uses resolution smaller than \verb{CSS pixels}, improving
rendering performance at the expense of image quality; a value greater than \code{1} improves
image quality at the expense of rendering performance.
}}

\item{blending_mode}{<\code{"normal"} | \code{"additive"} | \code{"subtractive"}> Sets the blending mode.
Blending modes:
\itemize{
\item \code{normal}: Normal blending doesn't alter colours of overlapping objects.
\item \code{additive}: Additive blending adds colours of overlapping objects. Useful for highlighting
dot density on dark maps.
\item \code{subtractive}: Subtractive blending darkens overlapping objects. Useful for highlighting
dot density on light maps.
}}

\item{layer_selector}{<\code{boolean}> If \code{TRUE}, the layer selector control will be enabled
and layers with \code{visibility_toggle = TRUE} may be toggled. If \code{FALSE}, the layer selector control
won't be rendered.}

\item{editor}{<\code{boolean}|\code{\link{editor_options}}> Whether to render the polygon editor.
If \code{TRUE}, renders with the default \code{\link[=editor_options]{editor_options()}}. If \code{FALSE}, the polygon editor
is not rendered.}

\item{lazy_load}{\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#deprecated}{\figure{lifecycle-deprecated.svg}{options: alt='[Deprecated]'}}}{\strong{[Deprecated]}}. Maps are always eagerly rendered.}

\item{...}{Additional parameters that will be forwarded to deck.gl javascript without
validation nor processing. All dots must be named and will be \code{camelCased} when serialised.
A warning is raised when dots are used, warning class \code{rdeck_dots_nonempty}.}
}
\description{
Creates an \code{\link[=rdeck]{rdeck()}} interface for asynchronous updates of a pre-rendered rdeck map
in Shiny apps.

All rdeck props can be updated through the proxy (\code{NULL} values will be discarded),
layers that are added to the proxy (e.g. \code{rdeck_proxy \%>\% add_h3_hexagon_layer()})
will be merged with pre-rendered rdeck layers.

Layers are merged by their \code{id}. Matched layers will be updated in place, new layers
will be appended and hence drawn \emph{on top} of all existing layers. For layer updates, you
may omit the \code{data} prop to avoid re-serialising unchanged data. All other props will
assume their defaults if omitted.
}
\examples{
\dontrun{
library(shiny)
library(dplyr)
library(h3jsr)
library(viridis)

ui <- fillPage(
  rdeckOutput("map", height = "100\%"),
  absolutePanel(
    top = 10, left = 10,
    sliderInput("range", "value", 0, 1, c(0, 1), step = 0.1)
  )
)

h3_data <- tibble(
  hexagon = get_res0() \%>\%
    get_children(res = 3) \%>\%
    unlist() \%>\%
    unique(),
  value = runif(length(hexagon))
)

map <- rdeck() \%>\%
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
    h3_data \%>\%
      filter(value >= input$range[1] & value <= input$range[2])
  })

  observe({
    rdeck_proxy("map") \%>\%
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
}
}

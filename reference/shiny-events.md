# Shiny events data

Utilities for retrieving map event data in a shiny application.

## Usage

``` r
get_view_bounds(rdeck, session = shiny::getDefaultReactiveDomain())

get_view_state(rdeck, session = shiny::getDefaultReactiveDomain())

get_clicked_coordinates(rdeck, session = shiny::getDefaultReactiveDomain())

get_clicked_layer(rdeck, session = shiny::getDefaultReactiveDomain())

get_clicked_object(rdeck, session = shiny::getDefaultReactiveDomain())

get_edited_features(rdeck, session = shiny::getDefaultReactiveDomain())
```

## Arguments

- rdeck:

  \<`rdeck_proxy` \| `string`\> the map, or map id

- session:

  \<`ShinySession`\> the shiny session

## Functions

- `get_view_bounds()`: Get the current map bounding box

- `get_view_state()`: Get the map view state

- `get_clicked_coordinates()`: Get the last clicked coordinates

- `get_clicked_layer()`: Get the last clicked layer (or NULL)

- `get_clicked_object()`: Get the last clicked object (or NULL)

- `get_edited_features()`: Get the edited features

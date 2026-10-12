# Introduction to rdeck

[rdeck](https://qfes.github.io/rdeck) lets you use R to describe
interactive WebGL maps built with Uber’s [deck.gl](https://deck.gl)
framework and [mapbox](https://www.mapbox.com/) base maps.

These maps can smoothly render data interactively on a much larger scale
than html/svg frameworks like Leaflet. Visually appealing 3D and
lighting effects are also possible, thanks to WebGL rendering.

[rdeck](https://qfes.github.io/rdeck) maps consist of a basemap
(requires a mapbox account) and 0 or more layers. Basemaps are defined
via the `rdeck(map_style)` parameter, which is any valid mapbox style
identifier, e.g. `"mapbox://styles/mapbox/dark-v10"`. The basemap can be
disabled with `rdeck(map_style = NULL)`.

Layers are added to an [rdeck](https://qfes.github.io/rdeck) map by
calling one of the *add layer* methods on an rdeck instance.
e.g. `rdeck() %>% add_scatterplot_layer()`. The order in which layers
are added determines their z-index; each layer added to the map will
appear *on top* of all previously added layers.

Every layer can be created with their defaults, however layers without
data are almost useless as they will be empty. All layer arguments
(other than `rdeck`) must be named.

Some examples follow.

## Packages

These packages are required for the following examples. With exception
of `RcppSimdJson`, these packages will be frequently used in creating
[rdeck](https://qfes.github.io/rdeck) maps.

``` r

library(rdeck)
library(dplyr)
library(sf)
library(viridis)
# loading deck.gl example data
library(RcppSimdJson)
```

## Loading example data

In this example, we create a simple scatterplot layer using the
[manhattan example
data](https://raw.githubusercontent.com/visgl/deck.gl-data/master/examples/scatterplot/manhattan.json)
from deck.gl. This data can be used directly from the URL, however this
is not typical usage of [rdeck](https://qfes.github.io/rdeck), so first
we’ll load this data into a data frame.

``` r

url <- file.path(
  "https://raw.githubusercontent.com/visgl/deck.gl-data/master",
  "examples/scatterplot/manhattan.json",
  fsep = "/"
)
manhattan_data <- fload(url) %>%
  as_tibble(.name_repair = ~ c("lon", "lat", "species")) %>%
  mutate(
    position = sfc_point(lon, lat),
    species = as.factor(species),
    species_name = if_else(species == 1, "dog", "cat")
  )
```

The manhattan data we have loaded. Our scatterplot layer will make use
of the `position` column to define the centre of each rendered point,
and the `species` column to change the point colours and sizes. `lon`
and `lat` aren’t used in any of the layer parameters, so they won’t be
serialised.

    #> # A tibble: 13,987 × 5
    #>      lon   lat species             position species_name
    #>    <dbl> <dbl> <fct>            <POINT [°]> <chr>       
    #>  1 -74.0  40.7 2       (-73.98602 40.73074) cat         
    #>  2 -74.0  40.7 1       (-73.98429 40.72947) dog         
    #>  3 -74.0  40.7 1       (-73.98775 40.73202) dog         
    #>  4 -74.0  40.7 2       (-73.98689 40.73011) cat         
    #>  5 -74.0  40.7 2       (-73.98516 40.72883) cat         
    #>  6 -74.0  40.7 1       (-73.98818 40.72979) dog         
    #>  7 -74.0  40.7 1       (-73.98646 40.73106) dog         
    #>  8 -74.0  40.7 1        (-73.98386 40.7317) dog         
    #>  9 -74.0  40.7 1       (-73.98559 40.73042) dog         
    #> 10 -74.0  40.7 2       (-73.98883 40.73058) cat         
    #> # ℹ 13,977 more rows

## Scatterplot map

Here we create a simple scatterplot map with a dark vector basemap and
[`cividis()`](https://sjmgarnier.github.io/viridisLite/reference/viridis.html)
colour scale for the scatterplot layer.

The scatterplot points are *scaled* by the `species` categories found in
the data (which in this dataset are `dog` and `cat`); this colour scale
generates a categorical legend.

Point density is highlighted with `additive` blending, making dense
areas appear brighter.

All points have the same radius of `30 metres`, with a minimum of
`0.5 pixels` (to prevent them from disappearing at low zooms).

Hovered points will become brighter — by using a similar colour scale as
`get_fill_color` — and will render a tooltip containing the `species`
category from the data.

``` r

rdeck(
  map_style = mapbox_dark(),
  # set the bounds of the map to include all of the manhattan data
  initial_bounds = st_bbox(manhattan_data$position),
  # add a 2 pixel buffer to each point, making it easier to hover
  picking_radius = 2
) %>%
  add_scatterplot_layer(
    name = "manhattan_animals",
    data = manhattan_data,
    # the coloumn in manhattan_data which contains the location of each point
    get_position = position,
    # a categorical colour scale, using the species column and a cividis colour palette
    get_fill_color = scale_color_category(
      col = species,
      palette = cividis(2)
    ),
    # the radius of each point (default 1 metre) is scaled by 30
    radius_scale = 30,
    radius_min_pixels = 0.5,
    # highlight dot density
    blending_mode = "additive",
    # interactivity
    pickable = TRUE,
    auto_highlight = TRUE,
    # per-species highlight colour
    highlight_color = scale_color_category(
      col = species,
      palette = c("#0060e6", "#fff399"),
      legend = FALSE
    ),
    tooltip = c(species, species_name)
  )
#> Warning in mapbox_access_token(): ! Assertion failed: length(tokens) == 0
#> ! No mapbox access token found, mapbox basemap won't be shown.
#> ℹ Set mapbox token with one of:
#> • option `options(rdeck.mapbox_access_token = <token>)`
#> • environment variable `MAPBOX_ACCESS_TOKEN = <token>`
#> • environment variable `MAPBOX_TOKEN = <token>`
#>   
#> ℹ See <https://docs.mapbox.com/help/glossary/access-token>
```

## Grouping points

In the following example, we group all points by `species_name` so that
we can highlight all points of a given species at once.

``` r

manhattan_data_grouped <- manhattan_data %>%
  group_by(species_name) %>%
  summarise(
    position = st_union(position),
    count = n(),
    .groups = "drop"
  )
```

Our grouped data:

    #> # A tibble: 2 × 3
    #>   species_name                                                    position count
    #>   <chr>                                                   <MULTIPOINT [°]> <int>
    #> 1 cat          ((-73.99674 40.76856), (-73.99555 40.76893), (-74.00115 40…  7554
    #> 2 dog          ((-73.99592 40.7739), (-73.99528 40.77207), (-73.99829 40.…  6433

The following map is almost identical to the previous map, we have
replaced the `data` parameter, the scales to use the `species_name` and
the `tooltip` to include the new column, `count`.

``` r

rdeck(
  map_style = mapbox_dark(),
  # set the bounds of the map to include all of the manhattan data
  initial_bounds = st_bbox(manhattan_data_grouped$position),
  # add a 2 pixel buffer to each point, making it easier to hover
  picking_radius = 2
) %>%
  add_scatterplot_layer(
    name = "manhattan_animals",
    data = manhattan_data_grouped,
    # the coloumn in manhattan_data which contains the location of each point
    get_position = position,
    # a categorical colour scale, using the species column and a cividis colour palette
    get_fill_color = scale_color_category(
      col = species_name,
      palette = cividis(2)
    ),
    # the radius of each point (default 1 metre) is scaled by 30
    radius_scale = 30,
    radius_min_pixels = 0.5,
    # highlight dot density
    blending_mode = "additive",
    # interactivity
    pickable = TRUE,
    auto_highlight = TRUE,
    # per-species highlight colour
    highlight_color = scale_color_category(
      col = species_name,
      palette = c("#0060e6", "#fff399"),
      legend = FALSE
    ),
    tooltip = everything()
  )
#> Warning in mapbox_access_token(): ! Assertion failed: length(tokens) == 0
#> ! No mapbox access token found, mapbox basemap won't be shown.
#> ℹ Set mapbox token with one of:
#> • option `options(rdeck.mapbox_access_token = <token>)`
#> • environment variable `MAPBOX_ACCESS_TOKEN = <token>`
#> • environment variable `MAPBOX_TOKEN = <token>`
#>   
#> ℹ See <https://docs.mapbox.com/help/glossary/access-token>
```

## Scaling additional parameters

We are able to scale many parameters on each layer. In the following
example, we additionally scale the radius by the count of
`species_name`.

``` r

rdeck(
  map_style = mapbox_dark(),
  # set the bounds of the map to include all of the manhattan data
  initial_bounds = st_bbox(manhattan_data_grouped$position),
  # add a 2 pixel buffer to each point, making it easier to hover
  picking_radius = 2
) %>%
  add_scatterplot_layer(
    name = "manhattan_animals",
    data = manhattan_data_grouped,
    # the coloumn in manhattan_data which contains the location of each point
    get_position = position,
    # a categorical colour scale, using the species column and a cividis colour palette
    get_fill_color = scale_color_category(
      col = species_name,
      palette = cividis(2)
    ),
    # we only have 2 groups, so this scale is equivalent to a categorical scale with the
    # same parameters
    get_radius = scale_linear(
      col = count,
      range = sqrt(1:2)
    ),
    # the radius of each point is scaled by 30
    radius_scale = 30,
    radius_min_pixels = 0.5,
    # highlight dot density
    blending_mode = "additive",
    # interactivity
    pickable = TRUE,
    auto_highlight = TRUE,
    # per-species highlight colour
    highlight_color = scale_color_category(
      col = species_name,
      palette = c("#0060e6", "#fff399"),
      legend = FALSE
    ),
    tooltip = everything()
  )
#> Warning in mapbox_access_token(): ! Assertion failed: length(tokens) == 0
#> ! No mapbox access token found, mapbox basemap won't be shown.
#> ℹ Set mapbox token with one of:
#> • option `options(rdeck.mapbox_access_token = <token>)`
#> • environment variable `MAPBOX_ACCESS_TOKEN = <token>`
#> • environment variable `MAPBOX_TOKEN = <token>`
#>   
#> ℹ See <https://docs.mapbox.com/help/glossary/access-token>
```

## High-level layers

This example code is repetitive, copy-pasta that will inevitably result
in maintenance problems, as well as increased developer effort.

Generally when creating maps, we will encapsulate the creation of one or
more layers in a function. Similar to creating functions to encapsulate
tidy-methods, the use of curly-curly is needed here for any parameters
that accept an `accessor` parameter.

The only rule in creating a layer function is that the function takes an
rdeck map as a parameter (typically first parameter) and that map must
be returned; this makes the function chainable.

In the following example, we parameterise the data, fill palette,
highlight palette, and *get radius* (which will require curl-curly) for
our original scatterplot layer.

``` r

add_manhattan_layer <- function(rdeck, manhattan_data,
                                fill_palette, highlight_palette, get_radius) {
  rdeck %>%
    add_scatterplot_layer(
      name = "manhattan_animals",
      data = manhattan_data,
      get_position = position,
      get_fill_color = scale_color_category(
        col = species_name,
        palette = fill_palette
      ),
      # we need curly-curly for get_radius
      get_radius = {{ get_radius }},
      radius_scale = 30,
      radius_min_pixels = 0.5,
      blending_mode = "additive",
      pickable = TRUE,
      auto_highlight = TRUE,
      highlight_color = scale_color_category(
        col = species_name,
        palette = highlight_palette,
        legend = FALSE
      ),
      tooltip = everything()
    )
}
```

Usage of our new function is like adding any other layer, just now that
it is opinionated and isn’t limited to adding a single layer.

``` r

rdeck(
  map_style = mapbox_dark(),
  # set the bounds of the map to include all of the manhattan data
  initial_bounds = st_bbox(manhattan_data$position),
  # add a 2 pixel buffer to each point, making it easier to hover
  picking_radius = 2
) %>%
  add_manhattan_layer(
    manhattan_data = manhattan_data_grouped,
    fill_palette = viridis(2, alpha = 0.7),
    highlight_palette = viridis(2),
    get_radius = scale_category(
      col = species_name,
      # swap the levels order, dogs are now bigger
      levels = c("cat", "dog"),
      range = c(1, sqrt(3))
    )
  )
#> Warning in mapbox_access_token(): ! Assertion failed: length(tokens) == 0
#> ! No mapbox access token found, mapbox basemap won't be shown.
#> ℹ Set mapbox token with one of:
#> • option `options(rdeck.mapbox_access_token = <token>)`
#> • environment variable `MAPBOX_ACCESS_TOKEN = <token>`
#> • environment variable `MAPBOX_TOKEN = <token>`
#>   
#> ℹ See <https://docs.mapbox.com/help/glossary/access-token>
```

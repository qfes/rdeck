# rdeck

[deck.gl](https://github.com/visgl/deck.gl) widget for R.

  
  

[![documentation](https://user-images.githubusercontent.com/391385/102683609-fceff080-421d-11eb-9b97-2889c683f03f.png)](https://qfes.github.io/rdeck)

## Installation

``` r

# install latest release
remotes::install_github("qfes/rdeck@*release")
# or install development version
remotes::install_github("qfes/rdeck")
```

## Mapbox access token

A [Mapbox account](https://account.mapbox.com/auth/signup) and [mapbox
access token](https://docs.mapbox.com/help/glossary/access-token) is
required for Mapbox basemaps, with or without the Mapbox data service.
See
[`mapbox_access_token`](https://qfes.github.io/rdeck/reference/mapbox_access_token.html)
for usage.

## Similar work

[rdeck](https://qfes.github.io/rdeck) draws much inspiration from
[`kepler.gl`](https://github.com/keplergl/kepler.gl) and
[`{mapdeck}`](https://github.com/SymbolixAU/mapdeck).
[rdeck](https://qfes.github.io/rdeck)’s design choices make it
convenient for use in static reports, and certain Shiny usecases that
are highly performant.

Some notable differences to
[mapdeck](https://symbolixau.github.io/mapdeck/articles/mapdeck.html):

- [rmarkdown](https://github.com/rstudio/rmarkdown) HTML reports made
  with [rdeck](https://qfes.github.io/rdeck) are typically an order of
  magnitude smaller in file size than
  [mapdeck](https://symbolixau.github.io/mapdeck/articles/mapdeck.html).
  Thanks to:
  - column-major data storage
  - client-side visual attributes scaling
  - client-side tooltip formatting
  - automatic filtering of data that is not used in the map
- Tidy evaluation is supported for column specifications.
- Extensive validation of layer properties in R is preferred, rather
  than throwing errors in the browser.
- [ggplot2](https://ggplot2.tidyverse.org) style `scale_` functions that
  perform common layer data transformations and automatically generate
  [legends](https://qfes.github.io/rdeck/reference/scale.html#legend)
  with appropriate untransformed tick marks.
  - e.g. `scale_color_power`, `scale_color_log` etc.
- Automatic creation of formatted
  [tooltips](https://qfes.github.io/rdeck/reference/tooltip.html)
- Choice of light or dark themes for tooltips and legends.
- Auto-generated interface from JS source
  - every deck.gl layer is supported to some degree
  - every layer property is a snake_case version of the camelCase
    deck.gl counterpart.
- Users can orchestrate browser-side map layer updates with Shiny,
  allowing for extremely performant reactivity.
  - Traditional Shiny interactivity using whole datasets is also
    possible, and is slightly slower than
    [mapdeck](https://symbolixau.github.io/mapdeck/articles/mapdeck.html)
    at present.

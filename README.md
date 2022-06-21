<p align="right">
  <a href="https://github.com/qfes/rdeck/releases/latest">
    <img src="https://img.shields.io/github/v/release/qfes/rdeck?include_prereleases&logo=github&sort=semver" alt="release" />
  </a>
  <img src="https://img.shields.io/github/r-package/v/qfes/rdeck?label=latest&logo=r" alt="latest" />
  <a href="https://github.com/visgl/deck.gl">
    <img src="https://img.shields.io/github/package-json/dependency-version/qfes/rdeck/deck.gl" alt="deck.gl" />
  </a>
  <a href="https://github.com/mapbox/mapbox-gl-js">
    <img src="https://img.shields.io/github/package-json/dependency-version/qfes/rdeck/mapbox-gl" alt="mapbox-gl" />
  </a>
  <a href="https://www.tidyverse.org/lifecycle/#experimental">
    <img src="https://img.shields.io/badge/lifecycle-experimental-orange" alt="lifecycle" />
  </a>
  <a href="https://github.com/qfes/rdeck/actions">
    <img src="https://github.com/qfes/rdeck/workflows/R-CMD-check/badge.svg" alt="R build status">
  </a>
</p>

<h1 align="center">
  rdeck
  <a href="https://qfes.github.io/rdeck">
    <img src="man/figures/logo.png" align="right" height="139">
  </a>
</h1>
<p align="center">
  <a href="https://github.com/visgl/deck.gl">deck.gl</a> widget for R. 
</p>

<!-- spacer -->
<br /><br />

[![documentation](https://user-images.githubusercontent.com/391385/102683609-fceff080-421d-11eb-9b97-2889c683f03f.png)](https://qfes.github.io/rdeck)

## Installation

```r
# install latest release
remotes::install_github("qfes/rdeck@*release")
# or install development version
remotes::install_github("qfes/rdeck")
```

## Mapbox access token
A [Mapbox account](https://account.mapbox.com/auth/signup) and 
[mapbox access token](https://docs.mapbox.com/help/glossary/access-token) 
is required for Mapbox basemaps, with or without the Mapbox data service. 
See [`mapbox_access_token`](https://qfes.github.io/rdeck/reference/mapbox_access_token.html) for usage.

## Similar work

`{rdeck}` draws much inspiration from [`kepler.gl`](https://github.com/keplergl/kepler.gl) and 
[`{mapdeck}`](https://github.com/SymbolixAU/mapdeck). `{rdeck}`'s design choices make it convenient 
for use in static reports, and certain Shiny usecases that are highly performant.

Some notable differences to `{mapdeck}`:

* `{rmarkdown}` HTML reports made with `{rdeck}` are typically an order of magnitude smaller in file size than `{mapdeck}`. Thanks to: 
  - column-major data storage
  - client-side visual attributes scaling
  - client-side tooltip formatting
  - automatic filtering of data that is not used in the map
* Tidy evaluation is supported for column specifications.
* Extensive validation of layer properties in R is preferred, rather than throwing errors in the browser.
* `{ggplot2}` style `scale_` functions that perform common layer data transformations and automatically generate [legends](https://qfes.github.io/rdeck/reference/scale.html#legend) with appropriate untransformed tick marks.
  - e.g. `scale_color_power`, `scale_color_log` etc.
* Automatic creation of formatted [tooltips](https://qfes.github.io/rdeck/reference/tooltip.html)
* Choice of light or dark themes for tooltips and legends.
* Auto-generated interface from JS source
  - every deck.gl layer is supported to some degree
  - every layer property is a snake_case version of the camelCase deck.gl counterpart.
* Users can orchestrate browser-side map layer updates with Shiny, allowing for extremely performant reactivity.
  - Traditional Shiny interactivity using whole datasets is also possible, and is slightly slower than `{mapdeck}` at present.

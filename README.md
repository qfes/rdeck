<p align="right">
  <a href="https://github.com/anthonynorth/rdeck/releases/latest">
    <img src="https://img.shields.io/github/v/release/anthonynorth/rdeck?sort=semver" alt="release">
  </a>
  <a href="https://www.tidyverse.org/lifecycle/#experimental">
    <img src="https://img.shields.io/badge/lifecycle-experimental-orange" alt="lifecycle" />
  </a>
  <a href="https://github.com/anthonynorth/rdeck/actions">
    <img src="https://github.com/anthonynorth/rdeck/workflows/R-CMD-check/badge.svg" alt="R build status">
  </a>
</p>

<h1 align="center">rdeck</h1>
<p align="center">
  <a href="https://github.com/uber/deck.gl">deck.gl</a> widget for R.
</p>

[![documentation](https://user-images.githubusercontent.com/391385/102683609-fceff080-421d-11eb-9b97-2889c683f03f.png)](https://anthonynorth.github.io/rdeck)

## Installation

```r
# install latest release
remotes::install_github("anthonynorth/rdeck@*release")
# or install development version
remotes::install_github("anthonynorth/rdeck")
```

## Similar work

`{rdeck}` draws much inspiration from [`{mapdeck}`](https://github.com/SymbolixAU/mapdeck/). `{rdeck}`'s design choices make it convenient for use in static reports, and certain Shiny usecases that are highly performant.

Some notable differences:

* `{rmarkdown}` HTML reports made with `{rdeck}` are typically an order of magnitude smaller in file size than `{mapdeck}`.  
  - Thanks to column-major data storage, and automatic filtering of data that is not used in the map.
* Tidy evaluation is supported for column specifications.
* Extensive validation of layer properties in R is preferred, rather than throwing errors in the browser.
* `{ggplot2}` style `scale_` functions that perform common layer data transformations and automatically generate legends with appropriate untransformed tick marks.
  - e.g. `scale_color_power`, `scale_color_log` etc.
* Users can orchestrate browser-side map layer updates with Shiny, allowing for extremely performant reactivity.
  - Traditional Shiny interactivity using whole datasets is also possible, and is slightly slower than `{mapdeck}` at present.

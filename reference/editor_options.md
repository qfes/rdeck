# Polygon editor options

Options for the polygon editor

## Usage

``` r
editor_options(mode = cur_value(), features = cur_value())
```

## Arguments

- mode:

  \<`editor-mode`\> The polygon editor mode. One of:

  - `view`: editor is in readonly mode

  - `select`: select/unselect features

  - `modify`: add/move/delete vertices

  - `transform`: move/scale/rotate selected features

  - `point`: draw points

  - `linestring`: draw linestrings by clicking each vertex

  - `polygon`: draw polygons by clicking each vertex

  - `lasso`: freehand polygon draw by click-dragging

- features:

  \<[`wk-geometry`](https://qfes.github.io/rdeck/reference/wk-geometry.md)\>
  Features with which to initialise the editor. Requires CRS
  [EPSG:4326](http://epsg.io/4326).

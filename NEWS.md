# rdeck 0.3.0

Version 0.3.0 is an almost complete rewrite. Changes of note:

- Add support for layers:
  - TileLayer (raster tiles)
  - MVTLayer
  - BitmapLayer (local images)
  - TripsLayer (animation)
- Add categorical & threshold scales
- Add tidy-select legend support
- Add extensive layer validation
- Add legend tick customisation
- Add light theme
- Add kepler.gl layer blending modes
- Add support for data loaded in browser, via url
- Add Shiny support
- Replace default layer `id` parameter with `uuid::UUIDgenerate()`
- Add `name` parameter to layers which is used in tooltips and legends
- Fix / rewrite legend component
- Fix multi-geometry picking / highlighting
- Fix GeoJsonLayer
- Move `mapbox_api_access_token` parameter to option / environment variable
- Remove unused data on serialisation

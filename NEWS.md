# rdeck 0.5.0

- Add centering, diverging scales (#82)
- Add snapshot util (#77)
- Add feature editor (#75)
- Rewrite client api (#73)
- Deprecate lazy loading (#71)
- Support integerish data in category scales (#64)

# rdeck 0.4.0

- Add layer partial updaters for shiny
- Add map view state & layer click events for shiny (#57)
- Remove auto-sfc column resolution from sf data (#50)
- Add identity scale (#62)
- Add symlog scale
- Scale enhancements (#56)
  - Generators for palette, range, breaks
  - Palette & range interpolation
  - Refactor quantile & quantize scales
- Add QuadKeyLayer
- Fix: multi-polygon auto-highlight (#42)
- Fix: javascript dependencies colliding with other widgets (#37)
- Fix: remove aggregation layer tooltips (#34)
- Add widget javascript api for extensions (#29)
- Add layer selector (#28)
- Add map lazy loading (#27)

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

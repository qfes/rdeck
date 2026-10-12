# Prop Type: WK Geometry

Geometry vectors are parsed with
[`wk::wk_handle()`](https://paleolimbot.github.io/wk/reference/wk_handle.html).
All geometry formats that {wk} supports directly are available to use in
{rdeck} layers. You may also use geometry formats which {wk} doesn't
directly support, provided a *loaded* package defines a {wk} *reader*
(i.e.
[`wk::wk_handle()`](https://paleolimbot.github.io/wk/reference/wk_handle.html)
S3 method) for the geometry type.

Geometry formats supported by {wk} (always supported):

- [`wk::wkb()`](https://paleolimbot.github.io/wk/reference/wkb.html)

- [`wk::wkt()`](https://paleolimbot.github.io/wk/reference/wkt.html)

- [`wk::xy()`](https://paleolimbot.github.io/wk/reference/xy.html) (`m`
  dimension is always ignored)

- [`wk::crc()`](https://paleolimbot.github.io/wk/reference/crc.html)

- [`wk::grd()`](https://paleolimbot.github.io/wk/reference/grd.html)

- [`wk::rct()`](https://paleolimbot.github.io/wk/reference/rct.html)

- [`sf::st_sfc()`](https://r-spatial.github.io/sf/reference/sfc.html)

Geometry formats supported by other packages (not dependencies of
{rdeck}):

- [`s2::s2_geography()`](https://r-spatial.github.io/s2/reference/as_s2_geography.html)

- `geos::geos_geometry()`

- Others?

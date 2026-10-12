# Tile json

Intended for use as the `data` parameter of
[`mvt_layer()`](https://qfes.github.io/rdeck/reference/mvt_layer.md).
Creates a tile json url from a tileset_id and tile_service. Tile service
defaults to `getOption("rdeck.tile_service") %||% "mapbox"`.

The created url will be fetched and parsed with
[`jsonlite::fromJSON()`](https://jeroen.r-universe.dev/jsonlite/reference/fromJSON.html).

## Usage

``` r
tile_json(tileset_id, tile_service = NULL)
```

## Arguments

- tileset_id:

  \<`string`\> The tileset_id, may be one of the following

  - a tileset identifier, e.g. "mapbox.mapbox-streets-v8"

  - a tileset identifier.json, e.g. "mapbox.mapbox-streets-v8.json"

  - a url, e.g. "mapbox://mapbox.mapbox-streets-v8", or
    "https://mytileserver/tileset"

  `tile_service` is unused if a url is supplied.

- tile_service:

  \<`string`\> The tile service name, defaults to
  \`getOption("rdeck.tile_service") %\|\|% "mapbox".

## Note

Authentication via
[`mapbox_access_token()`](https://qfes.github.io/rdeck/reference/mapbox_access_token.md)
occurs when `tile_service = "mapbox"`, or `tileset_id` uses the mapbox
scheme (i.e. mapbox://).

## Examples

``` r
if (FALSE) { # \dontrun{
tile_json("mapbox.mapbox-streets-v8", "mapbox")
tile_json("mapbox.mapbox-streets-v8.json", "mapbox")
tile_json("mapbox://mapbox.mapbox-streets-v8")
tile_json("mapbox://mapbox.mapbox-streets-v8.json")
tile_json("https://mytileserver/tileset.json")
tile_json("tileset.json", "https://mytileserver")
} # }
```

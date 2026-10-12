# Mapbox access token

A mapbox access token is required for rendering the mapbox basemap
(regardless of tiles used) and mapbox services (tiles). To use a
basemap, you need to register for a [mapbox
account](https://account.mapbox.com/auth/signup). Mapbox has a generous
free tier.

Each rdeck map *rendered* equates to a [map load for
web](https://www.mapbox.com/pricing/#maploads).

## Usage

``` r
mapbox_access_token()
```

## Details

The mapbox token is read from the following locations (in order):

- `getOption("rdeck.mapbox_access_token")`

- `Sys.getenv("MAPBOX_ACCESS_TOKEN")`

- `Sys.getenv("MAPBOX_TOKEN")`

## See also

<https://docs.mapbox.com/help/glossary/access-token>

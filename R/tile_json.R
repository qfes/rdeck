#' Tile json
#'
#' @description
#' Intended for use as the `data` parameter of [mvt_layer()]. Creates a tile json url
#' from a tileset_id and tile_service. Tile service defaults to
#' `getOption("rdeck.tile_service") %||% "mapbox"`.
#'
#' The created url will be fetched and parsed with [jsonlite::fromJSON()].
#'
#' @note
#' Authentication via [mapbox_access_token()] occurs when `tile_service = "mapbox"`,
#' or `tileset_id` uses the mapbox scheme (i.e. mapbox://).
#'
#' @examples
#' \dontrun{
#' tile_json("mapbox.mapbox-streets-v8", "mapbox")
#' tile_json("mapbox.mapbox-streets-v8.json", "mapbox")
#' tile_json("mapbox://mapbox.mapbox-streets-v8")
#' tile_json("mapbox://mapbox.mapbox-streets-v8.json")
#' tile_json("https://mytileserver/tileset.json")
#' tile_json("tileset.json", "https://mytileserver")
#' }
#'
#' @name tile_json
#' @param tileset_id <`string`> The tileset_id, may be one of the following
#' - a tileset identifier, e.g. "mapbox.mapbox-streets-v8"
#' - a tileset identifier.json, e.g. "mapbox.mapbox-streets-v8.json"
#' - a url, e.g. "mapbox://mapbox.mapbox-streets-v8", or "https://mytileserver/tileset"
#'
#' `tile_service` is unused if a url is supplied.
#' @param tile_service <`string`> The tile service name, defaults to
#' `getOption("rdeck.tile_service") %||% "mapbox".
#'
#' @export
tile_json <- function(tileset_id, tile_service = NULL) {
  tidyassert::assert(rlang::is_string(tileset_id))
  tidyassert::assert(is.null(tile_service) | rlang::is_string(tile_service))

  cls <- get_tileservice_class(tileset_id, tile_service %||% tile_service())

  UseMethod("tile_json", cls)
}

#' @export
tile_json.NULL <- function(tileset_id, tile_service = NULL) {
  new_tile_json(tileset_id)
}

#' @export
tile_json.character <- function(tileset_id, tile_service = NULL) {
  tileset_id <- gsub("(\\.json$)", "", tileset_id)
  url <- file.path(
    tile_service %||% tile_service(),
    paste0(tileset_id, ".json"),
    fsep = "/"
  )

  new_tile_json(url)
}

#' @export
tile_json.mapbox <- function(tileset_id, tile_service = NULL) {
  # strip mapbox protocol and .json
  tileset_id <- gsub("(^mapbox://)|(\\.json$)", "", tileset_id)
  url <- urltools::param_set(
    file.path(
      "https://api.mapbox.com/v4",
      paste0(tileset_id, ".json?secure"),
      fsep = "/"
    ),
    "access_token",
    mapbox_access_token()
  )

  new_tile_json(url)
}

is_mapbox <- function(x) "mapbox" %in% c(x, urltools::scheme(x))

get_tileservice_class <- function(tileset_id, tile_service) {
  if (is_absolute_url(tileset_id) && !is_mapbox(tileset_id)) {
    return(NULL)
  }

  if (is_mapbox(c(tileset_id, tile_service))) {
    return(as_class("mapbox"))
  }

  if (is_absolute_url(tile_service)) {
    return(character())
  }

  as_class(tile_service)
}

fetch_tile_json <- function(url) {
  with_rdeck_errors(
    jsonlite::fromJSON(url, simplifyDataFrame = FALSE),
    error_message = paste0("Error fetching tilejson from <", url, ">"),
    call = rlang::caller_call()
  )
}

new_tile_json <- function(url) {
  tilejson <- fetch_tile_json(url)
  structure(
    mutate(
      tilejson,
      fields = get_tilejson_fields(.env$tilejson)
    ),
    class = "tile_json"
  )
}

is_tile_json <- function(object) inherits(object, "tile_json")

#' @autoglobal
#' @noRd
get_tilejson_fields <- function(tilejson) {
  # get fields dataframe for tilejson layer
  get_fields <- function(layer) {
    dplyr::bind_cols(
      layer = layer$id,
      field = names(layer$fields)
    )
  }

  # get attributes dataframe for tilestats layer
  get_attrs <- function(layer) {
    dplyr::bind_cols(
      layer = layer$layer,
      dplyr::bind_rows(
        lapply(
          layer$attributes,
          function(attr) mutate(attr, values = if (exists("values")) list(values))
        )
      )
    )
  }

  tilejson_fields <- dplyr::bind_rows(
    lapply(tilejson$vector_layers, get_fields)
  )

  # could be empty, ensure schema
  tilestats_schema <- dplyr::tibble(
    layer = character(),
    attribute = character(),
    type = character(),
    values = list(),
    min = numeric(),
    max = numeric()
  )

  tilestats_fields <- dplyr::bind_rows(
    tilestats_schema,
    lapply(tilejson$tilestats$layers, get_attrs)
  )

  dplyr::left_join(
    tilejson_fields,
    tilestats_fields,
    by = c("layer", "field" = "attribute")
  )
}

#' @autoglobal
#' @noRd
get_tilejson_field <- function(tilejson, field, layers = NULL) {
  dplyr::filter(
    tilejson$fields,
    field == !!field,
    is.null(layers) | layer %in% layers
  )
}

has_tilejson_field <- function(tilejson, field, layers = NULL) {
  nrow(get_tilejson_field(tilejson, field, layers)) != 0
}

#' MVT URL
#'
#' `r lifecycle::badge("deprecated")`
#' Please url [tile_json()] instead
#'
#' @name mvt_url
#' @param tileset_id A mapbox tileset identifier of the form:
#'
#' - `mapbox.mapbox-streets-v8`, or
#' - `mapbox://mapbox.mapbox-streets-v8`
#'
#' @keywords internal
#' @export
mvt_url <- function(tileset_id) {
  lifecycle::deprecate_warn("0.4.0", "mvt_url()", "tile_json()")

  mvt_endpoint <- "https://api.mapbox.com/v4"
  xyz_template <- "{z}/{x}/{y}.vector.pbf"
  id <- sub("mapbox://", "", tileset_id)

  file.path(mvt_endpoint, id, xyz_template, fsep = "/") %>%
    urltools::param_set("access_token", mapbox_access_token())
}

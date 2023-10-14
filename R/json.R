#' As JSON
#'
#' Serialise object as JSON
#'
#' @keywords internal
#' @noRd
as_json <- function(object, ...) {
  UseMethod("as_json")
}

# identity: a convenient hack for safely calling as_json on anything
as_json.default <- function(object, ...) object

as_json.layer <- function(object, ...) {
  cols <- get_used_colnames(object)
  is_geojson <- inherits(object, "GeoJsonLayer")
  dims <- tolower(object$position_format)

  layer <- purrr::discard(object, is_cur_value)

  if (is_dataframe(layer$data) && !is_geojson) {
    layer$data <- add_class(layer$data, "layer_data")
  }

  # convert image blobs to png
  layer <- purrr::map_at(
    layer,
    c("image", "icon_atlas"),
    function(x) if (inherits(x, "array")) as_png(x) else x
  )

  json_stringify(
    lapply(layer, function(x) as_json(x, cols = cols, dims = dims)),
    camel_case = TRUE,
    auto_unbox = TRUE
  )
}

as_json.PathLayer <- function(object, ...) {
  if (is_dataframe(object$data)) {
    object$`_pathType` <- "open"
  }

  NextMethod()
}

as_json.SolidPolygonLayer <- function(object, ...) {
  if (is_dataframe(object$data)) {
    object$`_normalize` <- FALSE
    object$`_windingOrder` <- "CCW"
  }

  NextMethod()
}

as_json.PolygonLayer <- as_json.SolidPolygonLayer

as_json.deck_props <- function(object, ...) {
  deck_props <- select(object, -where(is_cur_value))

  json_stringify(
    lapply(deck_props, function(p) as_json(p)),
    camel_case = TRUE,
    auto_unbox = TRUE
  )
}

as_json.map_props <- function(object, ...) {
  json_stringify(
    select(object, -where(is_cur_value)),
    camel_case = TRUE,
    auto_unbox = TRUE
  )
}

#' @autoglobal
#' @noRd
as_json.rdeck_data <- function(object, ...) {
  rdeck_data <- mutate(
    object,
    across(-tidyselect::any_of("layers"), as_json)
  )

  if (length(rdeck_data$layers) != 0) {
    rdeck_data <- mutate(
      rdeck_data,
      layers = lapply(layers, function(layer) as_json(layer))
    )
  }

  json_stringify(
    select(rdeck_data, -where(is_cur_value)),
    camel_case = TRUE,
    auto_unbox = TRUE
  )
}

as_json.view_state <- function(object, ...) {
  json_stringify(
    object,
    camel_case = TRUE,
    auto_unbox = TRUE,
    digits = 6
  )
}

as_json.bbox <- function(object, ...) {
  json_stringify(object, digits = 6)
}

#' @autoglobal
#' @noRd
as_json.editor_options <- function(object, ...) {
  options <- mutate(select(object, -where(is_cur_value)))

  # features to geojson
  if (rlang::has_name(options, "features")) {
    rlang::check_installed("geojsonsf")

    options <- mutate(
      options,
      geojson = geojsonsf::sf_geojson(
        sf::st_sf(features %??% sf::st_sfc()),
        simplify = FALSE,
        digits = 6L
      )
    )

    options <- select(options, -features)
  }

  json_stringify(
    options,
    camel_case = TRUE,
    auto_unbox = TRUE
  )
}

as_json.accessor <- function(object, ...) {
  json_stringify(
    mutate(object, type = "accessor"),
    camel_case = TRUE,
    auto_unbox = TRUE
  )
}

#' @autoglobal
#' @noRd
as_json.scale <- function(object, ...) {
  compiled_scale <- mutate(
    compile(object),
    type = jsonlite::unbox("accessor"),
    across(
      -tidyselect::any_of(c("domain", "palette", "range", "ticks")),
      jsonlite::unbox
    )
  )

  # FIXME: rename scale -> scaleType in typescript
  # FIXME: preserve original na / unknown field name
  compiled_scale <- rename(
    compiled_scale,
    scale = scale_type,
    unknown = tidyselect::any_of(c("na_color", "na_value", "unmapped_color", "unmapped_value")),
    unknown_tick = tidyselect::any_of("unmapped_tick")
  )

  json_stringify(
    compiled_scale,
    camel_case = TRUE,
    digits = 15,
    use_signif = TRUE
  )
}

#' @autoglobal
#' @noRd
as_json.tooltip <- function(object, ...) {
  tooltip <- mutate(
    object,
    data_type = jsonlite::unbox(data_type),
    # unbox cols only if logical
    across(cols & where(is.logical), jsonlite::unbox)
  )

  json_stringify(tooltip, camel_case = TRUE)
}

as_json.tile_json <- function(object, ...) {
  tilejson <- select(
    object,
    -tidyselect::any_of(c(
      "tilestats",
      "vector_layers",
      "fields",
      "generator",
      "generator_options"
    ))
  )

  json_stringify(tilejson, auto_unbox = TRUE, digits = 6)
}

as_json.layer_data <- function(object, cols, dims, ...) {
  # drop unused cols
  data <- purrr::keep_at(
    vctrs::new_data_frame(unclass(object)),
    cols
  )

  geom_cols <- names(purrr::keep(data, wk::is_handleable))

  # reshape for deck.gl
  compiled <- deckgl_table(data, dims)
  compiled$length <- jsonlite::unbox(compiled$length)

  # 6-digit precision for all sf cols
  compiled$columns <- purrr::map_at(
    compiled$columns,
    geom_cols,
    json_stringify,
    digits = 6L
  )

  json_stringify(compiled, use_signif = TRUE)
}

#' @autoglobal
#' @noRd
as_json.sf <- function(object, cols = tidyselect::everything(), ...) {
  cols <- c(cols, attr(object, "sf_column", TRUE))
  data <- purrr::keep_at(object, cols)

  rlang::check_installed("geojsonsf")
  geojsonsf::sf_geojson(data, simplify = FALSE, digits = 6L)
}

as_json.png <- function(object) paste0("data:image/png;base64,", jsonlite::base64_enc(object))

# json serialise
json_stringify <- function(object,
                           camel_case = FALSE,
                           null = "null",
                           digits = 15,
                           use_signif = FALSE,
                           POSIXt = "ISO8601",
                           force = TRUE,
                           json_verbatim = TRUE,
                           ...) {
  if (camel_case) {
    names(object) <- to_camel_case(names(object))
  }

  jsonlite::toJSON(
    object,
    null = null,
    digits = digits,
    POSIXt = POSIXt,
    force = force,
    json_verbatim = json_verbatim,
    ...
  )
}

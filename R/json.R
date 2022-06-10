#' As JSON
#'
#' Serialise object as JSON
#'
#' @keywords internal
#' @noRd
as_json <- function(object) {
  UseMethod("as_json")
}

# identity: a convenient hack for safely calling as_json on anything
as_json.default <- function(object) object

as_json.layer <- function(object) {
  compiled_layer <- select(compile(object), -where(is_cur_value))

  json_stringify(
    lapply(compiled_layer, function(p) as_json(p)),
    camel_case = TRUE,
    auto_unbox = TRUE
  )
}

as_json.deck_props <- function(object) {
  deck_props <- select(object, -where(is_cur_value))

  json_stringify(
    lapply(deck_props, function(p) as_json(p)),
    camel_case = TRUE,
    auto_unbox = TRUE
  )
}

as_json.map_props <- function(object) {
  json_stringify(
    select(object, -where(is_cur_value)),
    camel_case = TRUE,
    auto_unbox = TRUE
  )
}

#' @autoglobal
#' @noRd
as_json.rdeck_data <- function(object) {
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

  # FIXME: rename polygon_editor -> editor
  if (!is.null(rdeck_data$polygon_editor)) {
    rdeck_data <- rename(rdeck_data, editor = polygon_editor)
  }

  json_stringify(
    select(rdeck_data, -where(is_cur_value)),
    camel_case = TRUE,
    auto_unbox = TRUE
  )
}

as_json.view_state <- function(object) {
  json_stringify(
    object,
    camel_case = TRUE,
    auto_unbox = TRUE,
    digits = 6
  )
}

as_json.bbox <- function(object) {
  json_stringify(object, digits = 6)
}

as_json.polygon_editor_options <- function(object) {
  options <- mutate(
    select(object, -where(is_cur_value)),
    across(
      tidyselect::any_of("polygon"),
      function(sfc) geojsonsf::sf_geojson(sf::st_sf(sfc), simplify = FALSE)
    )
  )

  json_stringify(
    options,
    camel_case = TRUE,
    auto_unbox = TRUE,
    digits = 6
  )
}

as_json.accessor <- function(object) {
  json_stringify(
    mutate(object, type = "accessor"),
    camel_case = TRUE,
    auto_unbox = TRUE
  )
}

#' @autoglobal
#' @noRd
as_json.scale <- function(object) {
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
as_json.tooltip <- function(object) {
  tooltip <- mutate(
    object,
    data_type = jsonlite::unbox(data_type),
    # unbox cols only if logical
    across(cols & where(is.logical), jsonlite::unbox)
  )

  json_stringify(tooltip, camel_case = TRUE)
}

as_json.tile_json <- function(object) {
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

#' @autoglobal
#' @noRd
as_json.layer_table <- function(object) {
  table <- mutate(
    object,
    length = jsonlite::unbox(length),
    geometry = lapply(geometry, jsonlite::unbox)
  )

  # FIXME: separate geometry cols from frame
  coord_cols <- names(object$geometry)
  table$frame <- mutate(
    table$frame,
    across(tidyselect::any_of(.env$coord_cols), json_stringify, digits = 6)
  )

  json_stringify(
    table,
    camel_case = TRUE,
    digits = 15,
    use_signif = TRUE
  )
}

as_json.sf <- function(object) geojsonsf::sf_geojson(object, digits = 6)

as_json.png <- function(object) {
  paste0(
    "data:image/png;base64,",
    base64enc::base64encode(object)
  )
}

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

to_camel_case <- function(string) {
  # preserve _ prefix
  prefix <- ifelse(startsWith(string, "_"), "_", "")
  snakecase::to_lower_camel_case(string, prefix = prefix)
}

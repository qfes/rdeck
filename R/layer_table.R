#' Deckgl table
#'
#' @description
#' Builds a deck.gl columnar table with flattened geometries and interleaved
#' coordinates.
#'
#' @details
#' If `object` contains only simple geometries, the output is a simple object
#' containing a length and a map of arrays holding `object` vectors.
#'
#' When `object` contains multi-geometries, the output is run-length encoded
#' with flattened geometries. This format is decoded into a flattened deck.gl
#' columnar table in javascript. The decoded table contains a feature
#' identifier which is used in multi-geometry highlighting.
#'
#' Why flatten geometries and run-length encode non-geometries vectors?
#' Deck.gl layers require primitive geometries (e.g points, lines, polygons),
#' so geometries must be flattened prior to being passed to layers. We flatten
#' geometries in R because it's faster to serialise and it's faster to render.
#'
#' Run-length encoding serves two purposes:
#' - Avoids serialising redundant data
#' - Is reversible, allowing for multi-geometry highlighting of flat data
#'
#' @note
#' Features containing empty geometries (geometries with no coordinates) are
#' not serialised.
#'
#' @noRd
#' @keywords internal
deckgl_table <- function(object, dims = "xy", ...) {
  # avoid sf & grouped_df sticky behaviour
  data <- vctrs::new_data_frame(unclass(object))
  geom_cols <- purrr::keep(data, wk::is_handleable)
  other_cols <- purrr::discard(data, wk::is_handleable)

  geom_coords <- lapply(geom_cols, function(x) xy_coords(x))
  # deckgl flattened coords
  flat_geoms <- lapply(geom_coords, function(x) deckgl_geom(x, dims))

  # TODO: check all geometry vectors have equal number of primitive geometries per feature

  # how many primitive geoms per feature
  feature_sizes <- if (length(geom_cols) != 0) {
    wk_primitive_count(geom_coords[[1]])
  }

  # drop rows with empty geometries
  if (!is.null(feature_sizes) && nrow(feature_sizes) != nrow(data)) {
    other_cols <- vctrs::vec_slice(other_cols, feature_sizes$feature_id)
  }

  n_features <- sum(feature_sizes$n_geom %||% nrow(data))
  list(
    # number of features
    length = jsonlite::unbox(n_features),
    # rle-lengths
    lengths = if (max(feature_sizes$n_geom, 0L) > 1L) feature_sizes$n_geom,
    columns = c(unclass(flat_geoms), unclass(other_cols))
  )
}


#' Deckgl geom
#'
#' @description
#' Constructs flattened geometries with interleaved coordinates.
#'
#' Interleaved coordinate geometries is a deck.gl supported format. It is
#' smaller, faster to serialise and faster to render than geojson-like nested
#' coordinates.
#'
#' @details
#' Flat deck.gl geometries represent POINTS, LINESTRINGS and _simple_ POLYGON
#' features identically: A vector of interleaved coordinates.
#'
#' Examples:
#'   POINT Z (1 2 3) -> [1, 2, 3]
#'   LINESTRING (1 1, 2 2, 3 3) -> [1, 1, 2, 2, 3, 3]
#'   POLYGON ((0 0, 0 1, 1 1, 1 0, 0 0)) -> [0, 0, 1, 0, 1, 1, 0, 1, 0, 0]
#'
#' Complex polygons are the exception; these are represented as an object
#' containing the coordinate vector (named `positions`) and a hole offsets
#' vector (named `holeIndices`). Hole offsets contains the 0-indexed start
#' location of each `hole` in `positions`.
#'
#' Example complex polygon:
#'   POLYGON ((0 0, 0 10, 10 10, 10 0, 0 0), (2 2, 2 8, 8 8, 8 2, 2 2)) ->
#'   {
#'     positions: [
#'       0, 0, 10, 0, 10, 10, 0, 10, 0, 0,
#'       2, 2, 2, 8, 8, 8, 8, 2, 2, 2
#'     ],
#'     holeIndices: [10]
#'   }
#'
#' @note
#' Deck.gl requires primitive geometries. Multi-part collections aren't
#' preserved here and must be handled in [deckgl_table()].
#'
#' @noRd
#' @keywords internal
deckgl_geom <- function(coords, dims = "xy", ...) {
  geom_runs <- vec_runs(coords$part_id)

  # optimised path for all length = 1 geometries
  # row-major matrix is equivalent to, but
  # simpler and faster to serialise than a list of coords
  if (max(geom_runs$size, 0L) <= 1L) {
    return(stack_xy(coords$xy, dims))
  }

  coord_size <- 2L + (dims == "xyz" || dims == "XYZ")
  # array of flat interleaved coordinates
  coords_lst <- vctrs::vec_chop(
    interleave_xy(coords$xy, dims),
    sizes = coord_size * geom_runs$size
  )

  # any polygons?
  if (max(coords$ring_id) == 0L) {
    return(coords_lst)
  }

  # size and location of each ring, including non-polygon features
  ring_runs <- vec_runs(coords[, c("part_id", "ring_id")])
  # points, lines and simple polygons will all have run-size = 1
  n_holes <- vctrs::vec_run_sizes(coords$part_id[ring_runs$loc]) - 1L

  # any complex polygons?
  if (max(n_holes) == 0L) {
    return(coords_lst)
  }

  # complex polygons: deck.gl expects an object containing
  # - positions: interleaved xy[z] coordinates
  # - holeIndices: 0-indexed positions offset to start of each hole

  # position offsets to each hole
  ring_offsets <- ring_runs$loc - rep.int(geom_runs$loc, n_holes + 1L)
  holes_lst <- vctrs::vec_chop(
    coord_size * ring_offsets[ring_offsets != 0L],
    sizes = n_holes[n_holes != 0L]
  )

  # replace complex polygons
  coords_lst[n_holes != 0L] <- Map(
    function(p, h) list(positions = p, holeIndices = h),
    coords_lst[n_holes != 0L],
    holes_lst
  )

  coords_lst
}


# get column names used in layer parameters
get_used_colnames <- function(layer) {
  # cannot *easily* know which cols are referenced in js() accessors
  js_props <- select(layer, where(is_js_eval))
  if (!rlang::is_empty(js_props)) {
    rlang::warn(
      c(
        "!" = "Some properties are javascript expressions, cannot safely omit columns",
        rlang::set_names(names(js_props), "*")
      )
    )

    return(TRUE)
  }

  # any accessors with cur_value() -> unsafe to subset layer
  missing_accessors <- select(layer, maybe_accessor() & where(is_cur_value))
  if (!rlang::is_empty(missing_accessors)) {
    rlang::warn(
      c(
        "!" = "Some accessors are `cur_value()`, cannot safely omit columns from output",
        rlang::set_names(names(missing_accessors), "*")
      )
    )

    return(TRUE)
  }

  tooltip <- layer$tooltip
  tooltip_cols <- if (isTRUE(layer$pickable) && is_tooltip(tooltip)) tooltip$cols

  accessors <- select(unclass(layer), where(is_accessor), where(is_scale))
  accessor_cols <- vcapply(accessors, purrr::pluck, "col")

  unique(c(accessor_cols, tooltip_cols))
}

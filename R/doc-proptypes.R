#' Prop Type: Accessor
#'
#' @description
#' Accessors map `data` columns to visual representations, primarily:
#' - colours: `fill`, `line`, `highlight`
#' - sizes: `radius`, `elevation`, `width`, `height`
#' - geometries `point/multipoint`, `linestring/multilinestring`, `polygon/multipolygon`
#'
#' On the client, an accessor is translated to a javascript function that retrieves the specified
#' column values for each rendered feature. An equivalent R function would look something like
#' `function(data, col, index) data[[index, col]]`.
#'
#' # Tidy-eval
#' Accessors support [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html) expressions.
#' Rules for referencing a column vs. a value from the environment is similar to [dplyr::mutate()],
#' with the main difference being that _all_ names are assumed to be columns of `data`, not falling
#' back to the environment when they're not found.
#'
#' Like [dplyr::mutate()], using string literals to reference columns isn't supported -- this will be
#' interpreted as a literal string. You may reference a column with:
#' - a [`name`][name] (e.g. `my_col`)
#' - a call evaluating [`name`], e.g. [as.name()], [rlang::sym()], etc
#' - by injecting a variable from the environment containing a `name` with `!!my_var`, or `{{myvar}}`
#'
#' Literal expressions -- except calls evaluating a [`name`] or a [`scale`] -- will be interpreted as
#' constant values (e.g. `"#ff0000"`, `1`, `TRUE`, etc.). To use the _value_ of a variable from the
#' environment, use the [injection operators][rlang::topic-inject], e.g. `!!my_constant`.
#'
#' Examples:
#' - `get_fill_color = color`: column accessor, referencing the "color" column
#' - `get_fill_color = "#ff0000"`: a constant value (red)
#' - `get_fill_color = !!color`: injects the value of `color` from the environment; if it's a name
#'   it will be a column with the value of `color` (e.g. color <- as.name("my_color_column"))
#' - `get_fill_color = rlang::sym("my_color")`: column accessor, referencing "my_color" column
#' - `get_fill_color = scale_color_threshold(color)`: a threshold scale, which transforms the "color"
#'   column
#'
#' # Accessors vs. Scales
#' Some parameters accept either an accessor or a [`scale`]. Scales transform numeric and categorical
#' vectors into colours and numeric values, and optionally render a legend; similar to ggplot scaling
#' aesthetics.
#'
#' An accessor can perform this same task by _manually_ transforming some input into a vector of colours
#' or numbers, but this is worse because:
#' - the transformed output (e.g. a colour vector) must be stored in the data (data bloat)
#' - visual representations aren't data
#' - legend won't be rendered
#'
#' # Accessors vs. Values
#' Some parameters accept either an accessor or a value; `get_radius` is such an example which accepts
#' either a _scalar_ `numeric` value, or an `accessor` to a `numeric` column, or a `numeric` [`scale`].
#' A value can be thought of as accessor where all values in the referenced column are the same
#' (i.e. a constant column), but optimised for file size and render speed.
#'
#' @name accessor
#' @keywords internal
NULL


#' Prop Type: Scale
#'
#' @description
#' Scales transform input data into visual representations, predominantly:
#' - colours: `fill`, `line`, `highlight`
#' - sizes: `radius`, `elevation`, `width`, `height`
#'
#' Transformations are performed in client-side javascript, thus scales have very minimal
#' file-size overhead; what you pay for is the source data being scaled & the scale descriptor
#' (palette, breaks, etc), but you don't pay for the scaled output (e.g. the vector of colours).
#' Many scales can refer to the same column of a dataframe, but the column will only be serialised once.
#'
#' Data retrieved in the browser dynamically can also be scaled, including [mvt_layer()]. All `rdeck`
#' scales (except [scale_quantile()]) support both R dataframes and data fetched in javascript, with the
#' following restrictions:
#' - column validation isn't performed -- missing column / incorrect type may error in javascript, or
#'   result in the `na_color` / `na_value` used for all features
#' - `limits` / `levels` must be explictly defined in the scale -- they cannot be learnt from data
#' - quantile scales technically work, but they require a copy of the data to compute the quantiles
#'
#' # Tidy-eval
#' Columns referenced by a scale support [tidy-eval](https://dplyr.tidyverse.org/articles/programming.html)
#' expressions. The `col` parameter for a scale must be a valid argument to [rlang::ensym()] and follows
#' the same rules. Use the [injection operators][rlang::topic-inject] to pass the value of a name
#' from the environment, e.g. `!!my_column`.
#'
#' # Legend
#' Scales can optionally produce a colour or numeric legend in the client. Numeric legends give
#' context for which visual field is being scaled and by what column; colour legends additionally
#' provide a colour scale and _untransformed_ ticks.
#'
#' Legend ticks can be formatted with a labelling function (e.g. [scales::label_number()]). This function
#' can completely replace the input ticks if you wish; the only constraint is the return value is a character
#' vector of the same length as input _unformatted ticks_.
#'
#' Legends are [kepler.gl](https://kepler.gl) inspired.
#' \if{html}{\out{
#'   <div class="text-center">
#'     <img src="https://user-images.githubusercontent.com/391385/103058278-7b1d1000-45ed-11eb-86d2-7ab594bb32de.png" />
#'   </div>
#' }}
#'
#' # Available scales
#' - [`scale_linear`]
#' - [`scale_power`]
#' - [`scale_log`]
#' - [`scale_symlog`]
#' - [`scale_identity`]
#' - [`scale_threshold`]
#' - [`scale_quantile`]
#' - [`scale_category`]
#' - [`scale_quantize`]
#'
#' @name scale
#' @keywords internal
NULL


#' Prop Type: Tooltip
#'
#' @description
#' If `pickable == TRUE`, tooltip defines which columns (and their order) will be displayed
#' when an object is _hovered_. The tooltip will be displayed as a transposed table (1 row
#' per column) and is styled according to the [rdeck()] `theme`. The tooltip layout is inspired
#' by [kepler.gl](https://kepler.gl).
#'
#' \if{html}{\out{
#'   <div class="text-center">
#'     <img src="https://user-images.githubusercontent.com/391385/103058202-57f26080-45ed-11eb-9131-f09585c1b894.png" />
#'   </div>
#' }}
#'
#' Tooltips support [tidy-select][dplyr::dplyr_tidy_select] expressions (renaming isn't supported and
#' will fail silently) and boolean expressions. Tidy-select support is limited when layer `data` is
#' a URL or `NULL`.
#'
#' Similar to [dplyr::select()], names are interpreted as column / field names. Use the
#' [injection operators][rlang::topic-inject] to pass the value of a name from the environment,
#' e.g. `!!my_column`.
#'
#' # Always supported
#' Tooltips support different arguments depending on the value of the layer `data`, but the following
#' arguments are always supported:
#' - `NULL` | `NA` | `FALSE` -> no tooltip
#' - `TRUE` -> all columns. This will be translated to [tidyselect::everything()] when data
#'   is a data frame or a tile json object
#' - character vector of column names, e.g. `c("foo", "bar")`
#' - a `c()` expression of bare names, e.g. `c(foo, bar)`
#' - a bare name, e.g. `my_col`
#'
#' # Data is a `data.frame` or `tile_json` object
#' When layer `data` is a [data.frame()] or [tile_json()] object, `tooltip` supports
#' [tidy-select][dplyr::dplyr_tidy_select], including selection helpers. The following are some
#' examples of supported expressions:
#' - `c(foo, bar)`
#' - `tidyselect::everything()`
#' - `tidyselect::matches("foo")`,
#' - `-unwanted`
#' - `where(is.character) & matches("foo")`
#' - `1:6`
#'
#' Like [dplyr::select()], referencing non-existent columns results in an error. Use
#' [tidyselect::any_of()] to include columns that may not exist.
#'
#' All geometry columns will be forcibly removed from the tooltip.
#'
#' # Data is a `string` or `NULL`
#' There is no column / field name validation when When layer `data` is a `string` (interpreted as a URL)
#' or `NULL`. Including non-existent names in the tooltip will _not_ cause errors in the client; these columns
#' will be given a value of `null` in the rendered tooltip.
#'
#' @name tooltip
#' @keywords internal
NULL


#' Prop Type: Color
#'
#' Colours are represented by `RGB` or `RGBA` hex strings.
#' Example: `#663399ff` \if{html}{\out{<img width="20" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVQYV2NIM575HwAEZwIytoDTwwAAAABJRU5ErkJggg==" />}}
#'
#' @name color
#' @keywords internal
NULL


#' Prop Type: WK Geometry
#'
#' @description
#' Geometry vectors are parsed with [wk::wk_handle()]. All geometry formats
#' that \{wk\} supports directly are available to use in {rdeck} layers. You may
#' also use geometry formats which \{wk\} doesn't directly support, provided a
#' _loaded_ package defines a \{wk\} _reader_ (i.e. [wk::wk_handle()] S3 method)
#' for the geometry type.
#'
#' Geometry formats supported by \{wk\} (always supported):
#' - [wk::wkb()]
#' - [wk::wkt()]
#' - [wk::xy()] (`m` dimension is always ignored)
#' - [wk::crc()]
#' - [wk::grd()]
#' - [wk::rct()]
#' - [sf::st_sfc()]
#'
#' Geometry formats supported by other packages (not dependencies of \{rdeck\}):
#' - [s2::s2_geography()]
#' - [geos::geos_geometry()]
#' - Others?
#'
#' @name wk-geometry
#' @keywords internal
NULL

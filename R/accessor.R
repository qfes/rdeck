#' Create accessors for deck.gl layers.
#'
#' @name accessor
#' @param expr [`name`] | [`call`] | value
#'  An expression or a value.
#'
#' @param data [`data.frame`]
#'  Each [name] in `expr` that appears in `names(data)` will be converted into
#'  one of the following:
#'    * `data.frame["name"][index]` for `columnar` == [TRUE]
#'    * `data["name"]` else
#'
#' @param columnar [`logical`]
#'  Will the layer data in javascript be a columnar table (an object with array
#'  properties), or an array of objects?
#'
#' @return [`htmlwidgets::JS]` | `eval(expr)`
#'  Either a [htmlwidgets::JS] or evaluated `expr`
#'
#' @noRd
accessor <- function(expr, data = NULL, columnar = TRUE) {
  UseMethod("accessor")
}

accessor.default <- function(expr, ...) {
  eval(expr)
}

accessor.name <- function(expr, data = NULL, columnar = TRUE) {
  names <- names(data)
  if (!(deparse(expr, backtick = FALSE) %in% names)) {
    return(eval(expr))
  }

  lambda <- ifelse(
    columnar,
    "(object, {index, data}) => ",
    "data => "
  )

  name <- visit(expr, names, columnar)
  htmlwidgets::JS(paste0(lambda, deparse(name, backtick = FALSE)))
}

accessor.call <- function(expr, data = NULL, columnar = TRUE) {
  names <- names(data)

  if (!(deparse(expr[[1]]) %in% c("~", "?"))) {
    return(eval(expr))
  }

  lambda <- ifelse(
    columnar,
    "(object, {index, data}) => ",
    "data => "
  )

  call <- visit(expr, names, columnar)
  htmlwidgets::JS(paste0(lambda, deparse(call, backtick = FALSE)))
}

#' Simple expression visitor for translating R into accessors
#'
#' @name visit
#' @param expr [`name`] | [`call`] | value
#'  The expression to visit.
#'
#' @param names [`character`]
#'  Vector of names to expand into either `data.frame[expr][index]`
#'  or `data[expr]`, depending on the value of `columnar` parameter
#'
#' @param columnar [`logical`]
#'  Is the data passed to layers a columnar table, or an array of objects?
#'
#' @return [`htmlwidgets::JS`] | [`name`] | [`call`] | value
#'  Either a [htmlwidgets::JS] instance or the original expression.
#'
#' @noRd
visit <- function(expr, names, columnar = TRUE) {
  if (is.call(expr) && !inherits(expr, "call")) {
    return(visit.call(expr, names, columnar))
  }

  UseMethod("visit")
}

visit.default <- function(expr, ...) {
  expr
}

visit.name <- function(expr, names, columnar) {
  name <- deparse(expr, backtick = FALSE)
  if (name %in% names) {
    ifelse(
      columnar,
      paste0(
        "data.frame[\"", name, "\"][index]"
      ),
      paste0("data.", name)
    ) %>%
      as.name()
  } else {
    expr
  }
}

visit.call <- function(expr, names, columnar) {
  if (expr[[1]] == "~") {
    # rhs of formula
    expr <- expr[[length(expr)]]
  }

  # may no longer be a call
  if (!is.call(expr)) {
    return(visit(expr, names, columnar))
  }

  call_name <- expr[[1]]
  call_args <- as.list(expr)[-1] %>%
    lapply(function(expr) visit(expr, names, columnar))

  new_call <- as.call(c(call_name, call_args))

  # transpile c() into []
  if (new_call[[1]] == "c") {
    name <- deparse(new_call, backtick = FALSE) %>%
      substr(3, nchar(.) - 1) %>%
      paste0("[", ., "]") %>%
      as.name()

    return(name)
  }

  # transpile ternary
  if (new_call[[1]] == "?") {
    # hack into an infix operator
    new_call[1] <- call("%?%")
    name <- deparse(new_call, backtick = FALSE) %>%
      sub("%\\?%", "?", x = .) %>%
      as.name()

    return(name)
  }

  new_call
}

# dplyr-like select for lists
#' @global where
#' @noRd
select <- function(lst, ...) {
  pos <- tidyselect::eval_select(rlang::expr(c(...)), unclass(lst))
  attrs <- purrr::list_modify(attributes(lst), names = names(pos))
  set_mostattributes(lst[pos], attrs)
}

# dplyr-like rename for lists
rename <- function(lst, ...) {
  pos <- tidyselect::eval_rename(rlang::expr(c(...)), unclass(lst))
  names(lst)[pos] <- names(pos)

  lst
}

# dplyr-like mutate for lists
mutate <- function(lst, ...) {
  quos <- rlang::enquos(..., .named = TRUE, .ignore_empty = "all", .check_assign = TRUE)
  nms <- rlang::names2(quos)

  purrr::reduce2(
    nms,
    quos,
    .init = lst,
    function(data, nm, quo) {
      val <- rlang::eval_tidy(quo, data)
      if (!is_across(quo)) set_value(data, nm, val) else purrr::list_modify(data, !!!val)
    }
  )
}

# dplyr-like across, accepts only a single function
across <- function(.cols, .fn, ...) {
  mask <- rlang::caller_env()
  # mask top = bottom
  data <- as.list(mask$.top_env)
  subset <- select(data, {{ .cols }})

  purrr::reduce2(
    names(subset),
    subset,
    .init = subset,
    function(data, nm, col) set_value(data, nm, .fn(col, ...))
  )
}

# is quo an across call
is_across <- function(quo) rlang::quo_is_call(quo) && rlang::call_name(quo) == "across"

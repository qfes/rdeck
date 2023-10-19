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

  mutate_col <- function(data, nm, quo) {
    value <- rlang::eval_tidy(quo, data)

    if (!is_across(quo)) {
      set_value(data, nm, value)
    } else {
      nms <- names(value)
      purrr::reduce2(nms, value, .init = data, set_value)
    }
  }

  purrr::reduce2(nms, quos, .init = lst, mutate_col)
}

# dplyr-like across, accepts only a single function
across <- function(.cols, .fn = NULL, ...) {
  mask <- rlang::caller_env()
  # mask bottom
  data <- as.list(rlang::env_parent(mask))
  subset <- select(data, {{ .cols }})

  fn <- .fn %||% function(col, ...) col

  across_col <- function(data, nm, col) {
    value <- fn(col, ...)

    if (!is.null(value)) {
      set_value(data, nm, value)
    } else {
      # preserve null here to remove in mutate
      set_null(data, nm)
    }
  }

  purrr::reduce2(names(subset), subset, .init = subset, across_col)
}

# is quo an across call
is_across <- function(quo) rlang::quo_is_call(quo) && rlang::call_name(quo) == "across"

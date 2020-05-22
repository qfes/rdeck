camel_case_names <- function(object) {
  names(object) <- snakecase::to_lower_camel_case(names(object))
  object
}

merge_list <- function(list, ...) {
  Reduce(
    function(x, y) utils::modifyList(x, y, keep.null = TRUE),
    list(...),
    list
  )
}

default_character_set <- function() {
  as.raw(32:128) %>% rawToChar()
}

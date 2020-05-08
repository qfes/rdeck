get_layer_arguments <- function() {
  calling_environment <- parent.frame()
  call <- match.call(
    sys.function(-1),
    sys.call(-1)
  )

  # hack: this pattern needs a rethink
  is_accessor <- function(name) name %in% accessors
  eval_name <- function(name) eval(as.name(name), calling_environment)

  arguments <- as.list(call)[-1]

  # eval all args that aren't accessors
  Map(function(arg, name) {
    if (is.name(arg) && !is_accessor(name)) eval_name(name) else arg
  }, arguments, names(arguments))
}

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

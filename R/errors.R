# base rdeck error
with_rdeck_errors <- function(expr, error_message, error_class = NULL, call = rlang::caller_env()) {
  rlang::try_fetch(
    expr,
    error = function(err) {
      rlang::abort(
        error_message,
        class = c(error_class, "rdeck_error"),
        call = call,
        parent = err
      )
    }
  )
}

# layer create / validate error
with_layer_create_errors <- function(expr, call = rlang::caller_env()) {
  with_rdeck_errors(
    expr,
    "Failed to create layer",
    call = call
  )
}

# event data retrieval error
with_event_data_errors <- function(expr, call = rlang::caller_env()) {
  with_rdeck_errors(
    expr,
    "Failed to get event data",
    call = call
  )
}

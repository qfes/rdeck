# Cur value

A sentinel object that represents the current value in the browser. Use
this value to indicate that a map / layer property should remain
unchanged.

Intended for use in shiny applications.

## Usage

``` r
cur_value()
```

## Examples

``` r
if (FALSE) { # \dontrun{
rdeck_proxy("map") %>%
  set_layer_visibility("layer_id", visible = cur_value(), visibility_toggle = TRUE)
} # }
```

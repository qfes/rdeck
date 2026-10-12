# Set layer visibility

Sets a layer's visibility and whether it is *selectable* in the layer
selector. Setting either `visible` or `visibility_toggle` as
[`cur_value()`](https://qfes.github.io/rdeck/reference/cur_value.md)
will have no change in the browser.

## Usage

``` r
set_layer_visibility(
  rdeck,
  id,
  visible = cur_value(),
  visibility_toggle = cur_value()
)
```

## Arguments

- rdeck:

  \<`rdeck_proxy`\> the rdeck proxy object

- id:

  \<`string`\> The layer's identifier must be unique for among all
  layers of the same type for a map. Defaults to
  [`uuid::UUIDgenerate()`](https://rdrr.io/pkg/uuid/man/UUIDgenerate.html),
  but should be explicitly defined for updatable layers in a shiny
  application.

- visible:

  \<`boolean`\> Determines whether the layer is visible or not; also
  determines whether any legend elements for the layer will be
  displayed.

- visibility_toggle:

  \<`boolean`\> Whether this layer will appear in the layer selector.

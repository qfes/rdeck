# Create a view_state

Create a view_state

## Usage

``` r
view_state(center = c(0, 0), zoom = 0, pitch = 0, bearing = 0, ...)
```

## Arguments

- center:

  `numeric` \|
  [`sf::st_point`](https://r-spatial.github.io/sf/reference/st.html)
  Center of the viewport on map

- zoom:

  `numeric` Scale = \\2^{zoom}\\

- pitch:

  `numeric` Camera angle in degrees (0 is straight down)

- bearing:

  `numeric` Map rotation in degrees (0 means north is up)

- ...:

  additional parameters to pass to `view_state` \| `initial_view_state`

## See also

<https://github.com/uber-archive/viewport-mercator-project/blob/master/docs/api-reference/web-mercator-viewport.md>

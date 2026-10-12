# Point vectors

Create point vectors

## Usage

``` r
xy(x = double(), y = double(), crs = wk::wk_crs_longlat())

xyz(x = double(), y = double(), z = double(), crs = wk::wk_crs_longlat())

sfc_point(x = double(), y = double(), z = NULL, crs = wk::wk_crs_longlat())
```

## Arguments

- x:

  \<`double`\> Coordinate x dimension

- y:

  \<`double`\> Coordinate y dimension

- crs:

  A value to be propagated as the CRS for this vector.

- z:

  \<`double`\> Coordinate z dimension

## Value

A vector of coordinate values.

## Functions

- `xy()`: Efficient 2-dimensional point vector

- `xyz()`: Efficient 3-dimensional point vector

- `sfc_point()`: Simple features point vector

## Examples

``` r
xy(1:5, 1:5)
#> <wk_xy[5] with CRS=OGC:CRS84>
#> [1] (1 1) (2 2) (3 3) (4 4) (5 5)
xyz(1:5, 1:5, 1:5)
#> <wk_xyz[5] with CRS=OGC:CRS84>
#> [1] Z (1 1 1) Z (2 2 2) Z (3 3 3) Z (4 4 4) Z (5 5 5)
sfc_point(1:5, 1:5)
#> Geometry set for 5 features 
#> Geometry type: POINT
#> Dimension:     XY
#> Bounding box:  xmin: 1 ymin: 1 xmax: 5 ymax: 5
#> Geodetic CRS:  WGS 84 (CRS84)
#> POINT (1 1)
#> POINT (2 2)
#> POINT (3 3)
#> POINT (4 4)
#> POINT (5 5)
sfc_point(1:5, 1:5, 1:5)
#> Geometry set for 5 features 
#> Geometry type: POINT
#> Dimension:     XYZ
#> Bounding box:  xmin: 1 ymin: 1 xmax: 5 ymax: 5
#> z_range:       zmin: 1 zmax: 5
#> Geodetic CRS:  WGS 84 (CRS84)
#> POINT Z (1 1 1)
#> POINT Z (2 2 2)
#> POINT Z (3 3 3)
#> POINT Z (4 4 4)
#> POINT Z (5 5 5)
```

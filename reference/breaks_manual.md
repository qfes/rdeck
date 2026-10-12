# Breaks manual

Generate a breaks vector with pre-determined threshold values.

## Usage

``` r
breaks_manual(thresholds = 0.5)
```

## Arguments

- thresholds:

  \<`numeric`\> a numeric vector of *ordered*, finite thresholds.

## Details

Wraps `thresholds` in the range of input data (which may be null or
non-finite). Thresholds that fall outside the range of input are omitted
from the output.

## See also

Other breaks:
[`breaks_linear()`](https://qfes.github.io/rdeck/reference/breaks_linear.md),
[`breaks_log()`](https://qfes.github.io/rdeck/reference/breaks_log.md),
[`breaks_power()`](https://qfes.github.io/rdeck/reference/breaks_power.md),
[`breaks_symlog()`](https://qfes.github.io/rdeck/reference/breaks_symlog.md),
[`breaks_trans()`](https://qfes.github.io/rdeck/reference/breaks_trans.md)

## Examples

``` r
breaks_manual(0)(-10:10)
#> [1] -10   0  10
breaks_manual(c(-10, 0, 10))(-10:10)
#> [1] -10   0  10
breaks_manual(-1:1 * 1e6)(NULL)
#> [1]   -Inf -1e+06  0e+00  1e+06    Inf
```

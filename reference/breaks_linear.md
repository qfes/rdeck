# Breaks linear

Generate a breaks vector of size `n` with linearly spaced breaks.

## Usage

``` r
breaks_linear(n = 10)
```

## Arguments

- n:

  \<`int`\> the size of the output vector. Ouput size will be at least
  length-2 for finite input.

## Details

If input range is non-finite, an empty vector is returned.

## See also

Other breaks:
[`breaks_log()`](https://qfes.github.io/rdeck/reference/breaks_log.md),
[`breaks_manual()`](https://qfes.github.io/rdeck/reference/breaks_manual.md),
[`breaks_power()`](https://qfes.github.io/rdeck/reference/breaks_power.md),
[`breaks_symlog()`](https://qfes.github.io/rdeck/reference/breaks_symlog.md),
[`breaks_trans()`](https://qfes.github.io/rdeck/reference/breaks_trans.md)

## Examples

``` r
breaks_linear(5)(-10:10)
#> [1] -10  -5   0   5  10
breaks_linear()(-1:1)
#>  [1] -1.0000000 -0.7777778 -0.5555556 -0.3333333 -0.1111111  0.1111111
#>  [7]  0.3333333  0.5555556  0.7777778  1.0000000
```

# Breaks symlog

Generate a breaks vector of size `n` with log1p
[symlog_trans](https://qfes.github.io/rdeck/reference/symlog_trans.md)
spaced breaks.

## Usage

``` r
breaks_symlog(n = 10)
```

## Arguments

- n:

  \<`int`\> the size of the output vector. Ouput size will be at least
  length-2 for finite input.

## Details

If input range is non-finite, an empty vector is returned.

## See also

Other breaks:
[`breaks_linear()`](https://qfes.github.io/rdeck/reference/breaks_linear.md),
[`breaks_log()`](https://qfes.github.io/rdeck/reference/breaks_log.md),
[`breaks_manual()`](https://qfes.github.io/rdeck/reference/breaks_manual.md),
[`breaks_power()`](https://qfes.github.io/rdeck/reference/breaks_power.md),
[`breaks_trans()`](https://qfes.github.io/rdeck/reference/breaks_trans.md)

## Examples

``` r
breaks_symlog(5)(-10:10)
#> [1] -10.000000  -2.316625   0.000000   2.316625  10.000000
breaks_symlog(5)(0:10)
#> [1]  0.0000000  0.8211603  2.3166248  5.0401054 10.0000000
```

# Breaks log

Generate a breaks vector of size `n` with log
[log_trans](https://qfes.github.io/rdeck/reference/log_trans.md) spaced
breaks.

## Usage

``` r
breaks_log(n = 10, base = exp(1))
```

## Arguments

- n:

  \<`int`\> the size of the output vector. Ouput size will be at least
  length-2 for finite input.

- base:

  \<`number`\> The log base

## Details

Input range must be finite and either be strictly negative or strictly
positive; it must not cross, nor include 0.

If input range is non-finite, an empty vector is returned.

## Note

This function has a different goal to
[scales::breaks_log](https://scales.r-lib.org/reference/breaks_log.html):
it produces evenly spaced log-breaks for use with d3-scale, it doesn't
produce breaks with pretty labels.

## See also

Other breaks:
[`breaks_linear()`](https://qfes.github.io/rdeck/reference/breaks_linear.md),
[`breaks_manual()`](https://qfes.github.io/rdeck/reference/breaks_manual.md),
[`breaks_power()`](https://qfes.github.io/rdeck/reference/breaks_power.md),
[`breaks_symlog()`](https://qfes.github.io/rdeck/reference/breaks_symlog.md),
[`breaks_trans()`](https://qfes.github.io/rdeck/reference/breaks_trans.md)

## Examples

``` r
breaks_log(5)(-10:-1)
#> [1] -10.000000  -5.623413  -3.162278  -1.778279  -1.000000
breaks_log(5)(1:10)
#> [1]  1.000000  1.778279  3.162278  5.623413 10.000000
```

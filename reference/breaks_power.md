# Breaks power

Generate a breaks vector of size `n` with exponentially
[power_trans](https://qfes.github.io/rdeck/reference/power_trans.md)
spaced breaks.

## Usage

``` r
breaks_power(n = 10, exponent = 0.5)
```

## Arguments

- n:

  \<`int`\> the size of the output vector. Ouput size will be at least
  length-2 for finite input.

- exponent:

  \<`number`\> The power exponent

## Details

If input range is non-finite, an empty vector is returned.

## See also

Other breaks:
[`breaks_linear()`](https://qfes.github.io/rdeck/reference/breaks_linear.md),
[`breaks_log()`](https://qfes.github.io/rdeck/reference/breaks_log.md),
[`breaks_manual()`](https://qfes.github.io/rdeck/reference/breaks_manual.md),
[`breaks_symlog()`](https://qfes.github.io/rdeck/reference/breaks_symlog.md),
[`breaks_trans()`](https://qfes.github.io/rdeck/reference/breaks_trans.md)

## Examples

``` r
breaks_power(5)(-10:10)
#> [1] -10.0  -2.5   0.0   2.5  10.0
breaks_power(5, exponent = 1 / 3)(-1:1)
#> [1] -1.000 -0.125  0.000  0.125  1.000
```

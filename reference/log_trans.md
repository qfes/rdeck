# Log transformation

Applies a log transform on the input: `y = log(abs(x), b)`, where:

- `x` is the input vector

- `b` is the log base

## Usage

``` r
log_trans(base = exp(1))
```

## Arguments

- base:

  \<`number`\> The log base

## Details

If `x` is negative, the result is multiplied by -1.

This transform requires that the input range doesn't cross zero.
Transforming an input that crosses 0 will succeed and give predictable
output, but its inverse will not, due to unsigned 0 (i.e. -1 \* log(1)
== log(1)).

## See also

Other transform:
[`power_trans()`](https://qfes.github.io/rdeck/reference/power_trans.md),
[`symlog_trans()`](https://qfes.github.io/rdeck/reference/symlog_trans.md)

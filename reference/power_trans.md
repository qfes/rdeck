# Power transformation

Applies an exponential transform of the input: `y = abs(x)^k`, where:

- `x` is the input vector

- `k` is the exponent

## Usage

``` r
power_trans(exponent = 0.5)
```

## Arguments

- exponent:

  \<`number`\> The power exponent

## Details

If `x` is negative, the result is multiplied by -1.

## See also

Other transform:
[`log_trans()`](https://qfes.github.io/rdeck/reference/log_trans.md),
[`symlog_trans()`](https://qfes.github.io/rdeck/reference/symlog_trans.md)

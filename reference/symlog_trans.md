# SymLog transformation

Applies a log1p transform: `y = log1p(abs(x))`, where:

- `x` is the input vector

## Usage

``` r
symlog_trans()
```

## Details

If `x` is negative, the result is multiplied by -1.

## See also

Other transform:
[`log_trans()`](https://qfes.github.io/rdeck/reference/log_trans.md),
[`power_trans()`](https://qfes.github.io/rdeck/reference/power_trans.md)

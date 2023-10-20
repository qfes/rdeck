  test_that("category unsupported", {
  scale <- scale_color_category(col)
  expect_error(rescale_center(scale), class = "rdeck_error")

  scale <- scale_category(col)
  expect_error(rescale_center(scale), class = "rdeck_error")

  scale <- scale_color_category(col)
  expect_error(rescale_diverge(scale), class = "rdeck_error")

  scale <- scale_category(col)
  expect_error(rescale_diverge(scale), class = "rdeck_error")
})

test_that("rescale_breaks works", {
  linear_scale <- scale_linear(col, limits = -10:10)

  # linear is identity
  expect_equal(rescale_breaks(linear_scale, c(-10, 0, 10)), c(0, 0.5, 1))
  expect_equal(rescale_breaks(linear_scale, 1), 11 / 20)

  # center should be 16, since sqrt(c(9, 25)) == c(3, 5), centre is sqrt(16)
  power_scale <- scale_power(col, limits = 9:25)
  expect_equal(rescale_breaks(power_scale, c(9, 16, 25)), c(0, 0.5, 1))
  expect_equal(rescale_breaks(power_scale, 11), (sqrt(11) - 3) / 2)

  # centre should be 1
  power_scale <- scale_power(col, limits = -9:25)
  expect_equal(rescale_breaks(power_scale, c(-9, 25)), 0:1)
  expect_equal(rescale_breaks(power_scale, 1), 0.5)

  # approximate breaks without an invertible transform
  threshold_scale <- scale_threshold(
    col,
    limits = -10:10,
    breaks = seq.int(-10, 10, length.out = 5)
  )

  expect_equal(rescale_breaks(threshold_scale, 0), 0.5)
  expect_equal(rescale_breaks(threshold_scale, -5), 0.25)
  expect_equal(rescale_breaks(threshold_scale, 5), 0.75)
})

test_that("rescale_piecewise works", {
  x <- seq.int(0, 1, length.out = 5)

  expect_equal(rescale_piecewise(x, 0.5), x)
  expect_equal(rescale_piecewise(x, 0.25), c(0, 0.5, 2 / 3, 5 / 6, 1))
  expect_equal(rescale_piecewise(x, 5 / 6), c(0, 0.15, 0.3, 0.45, 1))

  # mid at either extreme should give 0-0.5, or 0.5-1
  expect_equal(rescale_piecewise(x, 0), 0.5 + 0.5 * x)
  expect_equal(rescale_piecewise(x, 1), 0.5 * x)
})

test_that("rescale_center works", {
  length <- 5
  ramp <- seq.int(0, 1, length.out = length)

  scale <- scale_power(col, limits = -9:25)
  scale_centered <- rescale_center(scale, 1)

  # this should be a noop
  expect_equal(scale_centered$get_range(ramp), scale$get_range(ramp))

  # cuts range in half
  scale_centered <- rescale_center(scale, -9)
  expect_equal(scale_centered$get_range(ramp), seq.int(0.5, 1, length.out = length))

  # cuts range in half
  scale_centered <- rescale_center(scale, 25)
  expect_equal(scale_centered$get_range(ramp), seq.int(0, 0.5, length.out = length))

  # arbitrary midpoint: 0.625 -> 0.5 + 0.5 * (ramp - 0.625) / 0.625
  scale_centered <- rescale_center(scale, 4)
  expect_equal(scale_centered$get_range(ramp), seq.int(0, 0.8, length.out = length))

  # as above, for colour scales
  palette <- c("#ff0000", "#ffffff", "#0000ff")
  palette_ramp <- scales::colour_ramp(palette)

  color_scale <- scale_color_threshold(
    col,
    limits = -9:25,
    breaks = breaks_power(),
    palette = palette
  )
  color_scale_centered <- rescale_center(color_scale, 1)

  # this should be a noop
  expect_equal(color_scale_centered$get_palette(ramp), color_scale$get_palette(ramp))

  # cuts range in half
  color_scale_centered <- rescale_center(color_scale, -9)
  expect_equal(
    color_scale_centered$get_palette(ramp),
    palette_ramp(seq.int(0.5, 1, length.out = length))
  )

  # cuts range in half
  color_scale_centered <- rescale_center(color_scale, 25)
  expect_equal(
    color_scale_centered$get_palette(ramp),
    palette_ramp(seq.int(0, 0.5, length.out = length))
  )

  # arbitrary midpoint: 0.625 -> 0.5 + 0.5 * (ramp - 0.625) / 0.625
  color_scale_centered <- rescale_center(color_scale, 4)
  expect_equal(
    color_scale_centered$get_palette(ramp),
    palette_ramp(seq.int(0, 0.8, length.out = length))
  )
})

test_that("rescale_diverge works", {
  length <- 5
  ramp <- seq.int(0, 1, length.out = length)

  scale <- scale_log(col, limits = c(1, 1e8))
  scale_diverged <- rescale_diverge(scale, 1e4)

  # this should be a noop
  expect_equal(scale_diverged$get_range(ramp), scale$get_range(ramp))

   # cuts range in half
  scale_diverged <- rescale_diverge(scale, 1)
  expect_equal(scale_diverged$get_range(ramp), seq.int(0.5, 1, length.out = length))

  # cuts range in half
  scale_diverged <- rescale_diverge(scale, 1e8)
  expect_equal(scale_diverged$get_range(ramp), seq.int(0, 0.5, length.out = length))

  # arbitrary midpoint, piecewise scale
  scale_diverged <- rescale_diverge(scale, 1e2)
  expect_equal(
    scale_diverged$get_range(ramp),
    c(0, 0.5, 2 / 3, 5 / 6, 1)
  )

   # as above, for colour scales
  palette <- c("#ff0000", "#ffffff", "#0000ff")
  palette_ramp <- scales::colour_ramp(palette)

  color_scale <- scale_color_symlog(
    col,
    limits = c(-expm1(3), expm1(5)),
    palette = palette
  )

  color_scale_diverged <- rescale_diverge(color_scale, expm1(1))

  # this should be a noop
  expect_equal(color_scale_diverged$get_palette(ramp), color_scale$get_palette(ramp))

  # cut in half
  color_scale_diverged <- rescale_diverge(color_scale, -expm1(3))
  expect_equal(
    color_scale_diverged$get_palette(ramp),
    palette_ramp(seq.int(0.5, 1, length.out = length))
  )

  color_scale_diverged <- rescale_diverge(color_scale, expm1(5))
  expect_equal(
    color_scale_diverged$get_palette(ramp),
    palette_ramp(seq.int(0, 0.5, length.out = length))
  )

  # arbitrary mid point, which is 0.25 on the colour ramp
  color_scale_diverged <- rescale_diverge(color_scale, -expm1(1))
  expect_equal(
    color_scale_diverged$get_palette(ramp),
    palette_ramp(c(0, 0.5, 2 / 3, 5 / 6, 1))
  )
})

test_that("rescale_center expands range", {
  numeric_scale <- rescale_center(scale_linear(col, limits = 0:4), -1L)
  expect_equal(
    numeric_scale$get_range(0:4 / 4),
    6:10 / 10
  )

  palette_ramp <- scales::colour_ramp(c("#ff0000", "#ffffff", "#0000ff"))
  color_scale <- rescale_center(scale_color_linear(col, palette, limits = 0:4), -1L)
  expect_equal(
    color_scale$get_palette(0:4 / 4),
    palette_ramp(6:10 / 10)
  )
})

test_that("rescale_diverge expands range", {
  # these are equivalent to rescale_center, since mid is outside range
  numeric_scale <- rescale_diverge(scale_linear(col, limits = 0:4), -1L)
  expect_equal(
    numeric_scale$get_range(0:4 / 4),
    6:10 / 10
  )

  palette_ramp <- scales::colour_ramp(c("#ff0000", "#ffffff", "#0000ff"))
  color_scale <- rescale_diverge(scale_color_linear(col, palette, limits = 0:4), -1L)
  expect_equal(
    color_scale$get_palette(0:4 / 4),
    palette_ramp(6:10 / 10)
  )
})

test_that("rescale_breaks works", {
  # from qfes/rdeck#103
  expect_equal(
    rdeck::scale_linear(foo, limits = 0:1) |>
      rdeck::rescale_center(-1) |>
      generics::compile() |>
      purrr::keep_at(c("domain", "range")),
    list(
      domain = 0:1,
      range = c(0.75, 1)
    )
  )

  expect_equal(
    rdeck::scale_linear(foo, limits = 0:1) |>
      rdeck::rescale_diverge(-1) |>
      generics::compile() |>
      purrr::keep_at(c("domain", "range")),
    list(
      domain = 0:1,
      range = c(0.75, 1)
    )
  )
})

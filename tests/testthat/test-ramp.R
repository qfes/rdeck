test_that("color_gradient interpolates rgba vector", {
  pal <- c("#ff0000", "#ffff00")
  expect_equal(
    color_gradient(pal)(c(0, 0.5, 1)),
    toupper(c("#ff0000", "#ffa100", "#ffff00"))
  )

  pal <- c("#ffffff", "#ffffff00")
  expect_equal(
    color_gradient(pal)(c(0, 0.5, 1)),
    toupper(c("#ffffff", "#ffffff80", "#ffffff00"))
  )

  # no warning
  expect_warning(
    color_gradient(pal)(c(0, 0.5, 1)),
    NA
  )
})

test_that("color_gradient interpolates palette function", {
  pal <- scales::viridis_pal()
  expect_equal(
    color_gradient(pal)(seq.int(0, 1, length.out = 4)),
    # viridis without alpha
    substr(pal(4), 1, 7)
  )

  pal <- scales::brewer_pal(palette = "Dark2")
  expect_equal(
    color_gradient(pal)(seq.int(0, 1, length.out = 8)),
    pal(8)
  )

  expect_equal(
    color_gradient(pal)(seq.int(0, 1, length.out = 10)),
    c(
      "#1B9E77", "#C07327", "#B1686F", "#A362A5", "#DC4780",
      "#7C9E31", "#BFAB0F", "#C99314", "#9A7232", "#666666"
    )
  )

  # no warning
  expect_warning(
    color_gradient(pal)(seq.int(0, 1, length.out = 10)),
    NA
  )
})

test_that("color_gradient preserves scales::colour_ramp", {
  ramp <- scales::colour_ramp(scales::viridis_pal()(6))
  expect_identical(
    color_gradient(ramp),
    ramp
  )
})

test_that("color_categories interpolates if nlevels > rgba vector", {
  pal <- c("#ff0000", "#ffff00")
  expect_equal(
    color_categories(pal)(factor(1:2)),
    toupper(pal)
  )

  # no warning
  expect_warning(
    color_categories(pal)(LETTERS[1:2]),
    NA
  )

  expect_equal(
    # test for warning separately
    suppressWarnings(color_categories(pal)(factor(1:3))),
    toupper(c("#ff0000", "#ffa100", "#ffff00"))
  )

  expect_warning(
    color_categories(pal)(factor(1:3)),
    "maximum of 2 values.*supplied 3"
  )
})

test_that("color_categories interpolates if nlevels > palette function", {
  pal <- scales::manual_pal(scales::viridis_pal()(6))

  expect_equal(
    color_categories(pal)(factor(1:2)),
    # no alpha
    substr(pal(2), 1, 7)
  )

  # no warning
  expect_warning(
    color_categories(pal)(LETTERS[1:2]),
    NA
  )

  expect_equal(
    # test for warning separately
    suppressWarnings(color_categories(pal)(factor(1:10))),
    c(
      "#440154", "#452B70", "#404A88", "#37678C", "#2B828C",
      "#289D87", "#4CB575", "#74CC58", "#B9DC42", "#FDE725"
    )
  )

  expect_warning(
    color_categories(pal)(factor(1:10)),
    "maximum of 6 values.*supplied 10"
  )
})

test_that("color_categories rescales scales::color_ramp", {
  ramp <- scales::colour_ramp(scales::viridis_pal()(6))
  expect_false(identical(color_categories(ramp), ramp))

  expect_equal(
    color_categories(ramp)(1:6),
    ramp(scales::rescale(1:6))
  )

  expect_equal(
    color_categories(ramp)(LETTERS[1:5]),
    ramp(scales::rescale(1:5))
  )
})

test_that("color_categories preserves non-factor input order", {
  lvls <- c("z", "a")

  expect_equal(
    color_categories(c("#000000", "#ffffff"))(lvls),
    c("#000000", "#FFFFFF")
  )

  expect_equal(
    color_categories(scales::manual_pal(c("#000000", "#FFFFFF")))(lvls),
    c("#000000", "#FFFFFF")
  )

  expect_equal(
    color_categories(scales::colour_ramp(c("#000000", "#FFFFFF")))(lvls),
    c("#000000", "#FFFFFF")
  )

  lgls <- c(FALSE, TRUE)
  expect_equal(
    color_categories(c("#000000", "#ffffff"))(lgls),
    c("#000000", "#FFFFFF")
  )

  expect_equal(
    color_categories(scales::manual_pal(c("#000000", "#FFFFFF")))(lgls),
    c("#000000", "#FFFFFF")
  )

  expect_equal(
    color_categories(scales::colour_ramp(c("#000000", "#FFFFFF")))(lgls),
    c("#000000", "#FFFFFF")
  )
})


test_that("number_gradient interpolates sequence", {
  pal <- 1:3
  expect_equal(
    number_gradient(pal)(c(0, 0.25, 0.5, 0.75, 1)),
    c(1, 1.5, 2, 2.5, 3)
  )

  # non-monotonic is ok
  pal <- c(0, 5, 0)
  expect_equal(
    number_gradient(pal)(c(0, 0.25, 0.5, 0.75, 1)),
    c(0, 2.5, 5, 2.5, 0)
  )
})

test_that("number_categories interpolates if nlevels > sequence length", {
  pal <- 1:3
  expect_equal(
    number_categories(pal)(letters[1:3]),
    pal
  )

  # no interpolation, no warning
  expect_warning(
    number_categories(pal)(letters[1:3]),
    NA
  )

  # non-monotonic is ok
  pal <- c(0, 5, 0)
  expect_equal(
    number_categories(pal)(letters[1:3]),
    pal
  )

  pal <- 1:3
  expect_equal(
    # test for warning separately
    suppressWarnings(number_categories(pal)(letters[1:5])),
    c(1, 1.5, 2, 2.5, 3)
  )

  expect_warning(
    number_categories(pal)(factor(1:10)),
    "maximum of 3 values.*supplied 10"
  )

  # non-monotonic is ok
  pal <- c(0, 5, 0)
  expect_equal(
    # test for warning separately
    suppressWarnings(number_categories(pal)(c("z", "y", "x", "w", "v"))),
    c(0, 2.5, 5, 2.5, 0)
  )
})

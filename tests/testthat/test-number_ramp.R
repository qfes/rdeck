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

test_that("breaks_manual includes range / bounds", {
  expect_equal(
    breaks_manual(thresholds = 0.5)(0:1),
    c(0, 0.5, 1)
  )

  expect_equal(
    breaks_manual(thresholds = c(0:2))(0:2),
    0:2
  )
})

test_that("breaks_manual drops oob breaks", {
  expect_equal(
    breaks_manual(thresholds = 0.5)(1:2),
    1:2
  )

  expect_equal(
    breaks_manual(thresholds = 0:5)(2:3),
    2:3
  )

  expect_equal(
    breaks_manual(thresholds = 0:5)(-1:2),
    -1:2
  )

  expect_equal(
    breaks_manual(thresholds = 0:5)(4:6),
    4:6
  )

  expect_equal(
    breaks_manual(thresholds = .Machine$double.eps)(0:1),
    0:1
  )

  expect_equal(
    breaks_manual(thresholds = -.Machine$double.eps)(0:1),
    0:1
  )
})

test_that("breaks_manual returns infinite bounds on empty input", {
  expect_equal(
    breaks_manual(thresholds = 0:5)(NULL),
    c(-Inf, 0:5, Inf)
  )

  expect_equal(
    breaks_manual(thresholds = 0:5)(NA_integer_),
    c(-Inf, 0:5, Inf)
  )

  expect_equal(
    breaks_manual(thresholds = 0:5)(NA_real_),
    c(-Inf, 0:5, Inf)
  )

  expect_equal(
    breaks_manual(thresholds = 0:5)(numeric()),
    c(-Inf, 0:5, Inf)
  )
})

test_that("breaks_trans returns linear breaks in transformed domain", {
  trans <- power_trans(exponent = 0.5)
  expect_equal(
    breaks_trans(n = 4, trans = trans)(1:16),
    c(1, 4, 9, 16)
  )

  trans <- log_trans(base = 2)
  expect_equal(
    breaks_trans(n = 4, trans = trans)(1:8),
    c(1, 2, 4, 8)
  )

  trans <- scales::identity_trans()
  expect_equal(
    breaks_trans(n = 4, trans = trans)(1:10),
    c(1, 4, 7, 10)
  )
})

test_that("breaks_log throws on invalid range", {
  expect_error(
    breaks_log()(-5:0),
    class = "assert_error"
  )

  expect_error(
    breaks_log()(0:5),
    class = "assert_error"
  )

  expect_error(
    breaks_log()(-5:5),
    class = "assert_error"
  )

  expect_error(breaks_log()(-5:-1), NA)
  expect_error(breaks_log()(1:5), NA)
})

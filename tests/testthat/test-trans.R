test_that("power_trans is odd function", {
  trans <- power_trans(exponent = 0.5)
  expect_equal(
    trans$transform(c(-9, -4, -1, 0, 1, 4, 9)),
    -3:3
  )

  trans <- power_trans(exponent = 2)
  expect_equal(
    trans$transform(-3:3),
    c(-9, -4, -1, 0, 1, 4, 9)
  )
})

test_that("power_trans is invertible", {
  trans <- power_trans(exponent = 0.5)
  expect_equal(
    trans$inverse(trans$transform(-1e2:1e2)),
    -1e2:1e2
  )

  trans <- power_trans(exponent = 2)
  expect_equal(
    trans$inverse(trans$transform(-1e2:1e2)),
    -1e2:1e2
  )
})

test_that("log_trans handles negative input", {
  trans <- log_trans(base = 2)
  expect_equal(
    trans$transform(c(-8, -4, -2, 2, 4, 8)),
    c(-3:-1, 1:3)
  )

  trans <- log_trans(base = 10)
  expect_equal(
    trans$transform(c(-1000, -100, -10, 10, 100, 1000)),
    c(-3:-1, 1:3)
  )
})

test_that("log_trans is invertible -- strictly positive or negative", {
  trans <- log_trans()
  expect_equal(
    trans$inverse(trans$transform(-3:-1)),
    -3:-1
  )

  expect_equal(
    trans$inverse(trans$transform(3:1)),
    3:1
  )
})

test_that("log_trans inverse throws if domain crosses 0", {
  trans <- log_trans()
  expect_error(trans$inverse(trans$transform(-5:0)), NA)
  expect_error(trans$inverse(trans$transform(0:5)), NA)
  expect_error(trans$inverse(trans$transform(-5:5)), class = "assert_error")
})

test_that("symlog_trans is invertible", {
  trans <- symlog_trans()
  expect_equal(
    trans$inverse(trans$transform(-1e2:1e2)),
    -1e2:1e2
  )
})

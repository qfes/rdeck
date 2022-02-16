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

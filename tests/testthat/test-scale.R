test_that("scale_quantile works", {
  expect_equal(
    compile(scale_quantile(foo, range = 0:1, data = 0:1, probs = seq.int(0, 1, 0.2))),
    list(
      scale_type = "threshold",
      legend = TRUE,
      col = "foo",
      na_value = 0,
      domain = c(0.2, 0.4, 0.6, 0.8),
      range = c(0, 0.25, 0.5, 0.75, 1),
      scale_by = "foo"
    )
  )
})

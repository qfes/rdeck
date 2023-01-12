test_that("to_camel_case() works", {
  expect_equal(
    to_camel_case(c("data", "position_format", "_normalize", "_winding_order", "_full_3d", "_prefix_suffix_")),
    c("data", "positionFormat", "_normalize", "_windingOrder", "_full3d", "_prefixSuffix_")
  )
})

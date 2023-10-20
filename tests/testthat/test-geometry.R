test_that("wk_is works", {
  expect_true(
    wk_is(wk::xy(1, 1), wk::wk_geometry_type("point"))
  )

  expect_false(
    wk_is(wk::wkt("POINT (1 1)"), wk::wk_geometry_type("polygon"))
  )

  expect_true(
    wk_is(wk::wkt(c("POINT (1 1)", "POLYGON EMPTY")), wk::wk_geometry_type("point"))
  )

  expect_false(
    wk_is(wk::wkt(c("POINT (1 1)", "POLYGON EMPTY")), wk::wk_geometry_type("point"), FALSE)
  )

  expect_true(
    wk_is_point(wk::wkt(c("POINT (1 1)", "MULTIPOINT (1 1)")))
  )

  expect_false(
    wk_is_point(wk::wkt(c("POINT (1 1)", "POLYGON ((1 1))")))
  )

  expect_true(
    wk_is_linestring(wk::wkt(c("LINESTRING (1 1)", "MULTILINESTRING ((1 1))")))
  )

  expect_false(
    wk_is_linestring(wk::wkt(c("LINESTRING (1 1)", "POLYGON ((1 1))")))
  )

  expect_true(
    wk_is_polygon(wk::wkt(c("POLYGON ((1 1))", "MULTIPOLYGON (((1 1)))")))
  )

  expect_false(
    wk_is_polygon(wk::wkt(c("POLYGON ((1 1))", "MULTIPOINT (1 1)")))
  )
})

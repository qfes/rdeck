test_that("editor_options works", {
  # cur_value
  expect_equal(
    editor_options(),
    structure(list(mode = cur_value(), features = cur_value()), class = "editor_options")
  )

  # can set mode, or features, or both
  expect_equal(
    editor_options(mode = "lasso"),
    structure(list(mode = "lasso", features = cur_value()), class = "editor_options")
  )

  expect_equal(
    editor_options(features = wk::wkt("POINT EMPTY", "OGC:CRS84")),
    structure(list(mode = cur_value(), features = wk::wkt("POINT EMPTY", "OGC:CRS84")), class = "editor_options")
  )

  expect_equal(
    editor_options(mode = "transform", features = wk::wkt("POINT (1 1)", "OGC:CRS84")),
    structure(list(mode = "transform", features = wk::wkt("POINT (1 1)", "OGC:CRS84")), class = "editor_options")
  )

  # strips off data frame
  expect_equal(
    editor_options(
      mode = "polygon",
      features = vctrs::data_frame(features = wk::wkt("POLYGON ((1 1))", "OGC:CRS84"))
    ),
    structure(
      list(
        mode = "polygon",
        features = wk::wkt("POLYGON ((1 1))", "OGC:CRS84")
      ),
      class = "editor_options"
    )
  )
})

test_that("as_editor_options works", {
  expect_equal(
    as_editor_options(NULL),
    NULL
  )

  expect_equal(
    as_editor_options(TRUE),
    editor_options()
  )

  expect_equal(
    as_editor_options(FALSE),
    NULL
  )

  expect_equal(
    as_editor_options(cur_value()),
    cur_value()
  )

  expect_equal(
    as_editor_options(editor_options("modify")),
    editor_options("modify")
  )
})

test_that("editor_options json works", {
  expect_equal(
    as_json(editor_options()),
    structure("{}", class = "json")
  )

  expect_equal(
    as_json(editor_options(mode = "lasso")),
    structure('{"mode":"lasso"}', class = "json")
  )

  expect_equal(
    as_json(editor_options(features = wk::wkt("LINESTRING (1 1)", "OGC:CRS84"))),
    structure(
      '{"geojson":{"type":"FeatureCollection","features":[{"type":"Feature","properties":{},"geometry":{"type":"LineString","coordinates":[[1.0,1.0]]}}]}}', # nolint
      class = "json"
    )
  )
})

test_that("deckgl_table works", {
  expect_identical(
    deckgl_table(vctrs::data_frame(foo = 1:10)),
    list(
      length = jsonlite::unbox(10L),
      lengths = NULL,
      columns = list(
        foo = 1:10
      )
    )
  )
})

test_that("deckgl_table drops empty coordinates", {
  layer_data <- vctrs::data_frame(
    geom = wk::wkt(c(
      "POINT (1 1)", "POINT EMPTY", "MULTIPOINT EMPTY",
      "LINESTRING (1 1, 2 2)", "LINESTRING EMPTY", "MULTILINESTRING EMPTY",
      "POLYGON ((1 1, 2 2, 3 3, 1 1))", "POLYGON EMPTY", "MULTIPOLYGON EMPTY",
      "GEOMETRYCOLLECTION EMPTY"
    )),
    foo = 1:10,
    bar = letters[1:10]
  )

  expect_identical(
    deckgl_table(layer_data, "xy"),
    list(
      length = jsonlite::unbox(3L),
      lengths = NULL,
      columns = list(
        geom = list(c(1, 1), c(1, 1, 2, 2), c(1, 1, 2, 2, 3, 3, 1, 1)),
        foo = c(1L, 4L, 7L),
        bar = c("a", "d", "g")
      )
    )
  )
})

test_that("deckgl_table works for points", {
  points <- vctrs::data_frame(
    position = wk::xy(1:10, 1:10),
    foo = "bar"
  )

  expect_identical(
    deckgl_table(points, "xy"),
    list(
      length = jsonlite::unbox(10L),
      lengths = NULL,
      columns = list(
        position = cbind(as.numeric(1:10), as.numeric(1:10)),
        foo = rep.int("bar", 10)
      )
    )
  )

  expect_identical(
    deckgl_table(points, "xyz"),
    list(
      length = jsonlite::unbox(10L),
      lengths = NULL,
      columns = list(
        position = cbind(as.numeric(1:10), as.numeric(1:10), 0),
        foo = rep.int("bar", 10)
      )
    )
  )

  points_z <- vctrs::data_frame(
    position = wk::xyz(1:10, 1:10, 1:10),
    foo = "bar"
  )

  expect_identical(
    deckgl_table(points_z, "xy"),
    list(
      length = jsonlite::unbox(10L),
      lengths = NULL,
      columns = list(
        position = cbind(as.numeric(1:10), as.numeric(1:10)),
        foo = rep.int("bar", 10)
      )
    )
  )

  expect_identical(
    deckgl_table(points_z, "xyz"),
    list(
      length = jsonlite::unbox(10L),
      lengths = NULL,
      columns = list(
        position = cbind(as.numeric(1:10), as.numeric(1:10), as.numeric(1:10)),
        foo = rep.int("bar", 10)
      )
    )
  )
})

test_that("deckgl_table works for multipoints", {
  points <- vctrs::data_frame(
    position = wk::wk_collection(
      wk::xyz(1:10, 1:10, 1:10),
      wk::wk_geometry_type("multipoint"),
      c(rep.int(1, 8), 2, 3)
    ),
    foo = 1:3
  )

  expect_identical(
    deckgl_table(points, "xy"),
    list(
      length = jsonlite::unbox(10L),
      lengths = c(8L, 1L, 1L),
      columns = list(
        position = cbind(as.numeric(1:10), as.numeric(1:10)),
        foo = 1:3
      )
    )
  )

  expect_identical(
    deckgl_table(points, "xyz"),
    list(
      length = jsonlite::unbox(10L),
      lengths = c(8L, 1L, 1L),
      columns = list(
        position = cbind(as.numeric(1:10), as.numeric(1:10), as.numeric(1:10)),
        foo = 1:3
      )
    )
  )
})

test_that("deckgl_table works for point pairs", {
  lines <- vctrs::data_frame(
    start_position = wk::xyz(1:10, 1:10, 1:10),
    end_position = wk::xyz(-(1:10), -(1:10), -(1:10)),
    foo = "bar"
  )

  expect_identical(
    deckgl_table(lines, "xy"),
    list(
      length = jsonlite::unbox(10L),
      lengths = NULL,
      columns = list(
        start_position = cbind(as.numeric(1:10), as.numeric(1:10)),
        end_position = -cbind(as.numeric(1:10), as.numeric(1:10)),
        foo = rep.int("bar", 10)
      )
    )
  )

  expect_identical(
    deckgl_table(lines, "xyz"),
    list(
      length = jsonlite::unbox(10L),
      lengths = NULL,
      columns = list(
        start_position = cbind(as.numeric(1:10), as.numeric(1:10), as.numeric(1:10)),
        end_position = -cbind(as.numeric(1:10), as.numeric(1:10), as.numeric(1:10)),
        foo = rep.int("bar", 10)
      )
    )
  )
})

test_that("deckgl_table works for multipoint pairs", {
  lines <- vctrs::data_frame(
    start_position = wk::wk_collection(
      wk::xyz(1:10, 1:10, 1:10),
      wk::wk_geometry_type("multipoint"),
      c(rep.int(1:3, c(5, 4, 1)))
    ),
    end_position = wk::wk_collection(
      wk::xyz(-(1:10), -(1:10), -(1:10)),
      wk::wk_geometry_type("multipoint"),
      c(rep.int(1:3, c(5, 4, 1)))
    ),
    foo = "bar"
  )

  expect_identical(
    deckgl_table(lines, "xy"),
    list(
      length = jsonlite::unbox(10L),
      lengths = c(5L, 4L, 1L),
      columns = list(
        start_position = cbind(as.numeric(1:10), as.numeric(1:10)),
        end_position = -cbind(as.numeric(1:10), as.numeric(1:10)),
        foo = rep.int("bar", 3)
      )
    )
  )

  expect_identical(
    deckgl_table(lines, "xyz"),
    list(
      length = jsonlite::unbox(10L),
      lengths = c(5L, 4L, 1L),
      columns = list(
        start_position = cbind(as.numeric(1:10), as.numeric(1:10), as.numeric(1:10)),
        end_position = -cbind(as.numeric(1:10), as.numeric(1:10), as.numeric(1:10)),
        foo = rep.int("bar", 3)
      )
    )
  )
})

test_that("deckgl_table works for linestrings", {
  paths <- vctrs::data_frame(
    path = wk::wkt(c("LINESTRING Z (1 2 3, 4 5 6)", "LINESTRING Z (7 8 9, 10 11 12)")),
    foo = "bar"
  )

  expect_identical(
    deckgl_table(paths, "xy"),
    list(
      length = jsonlite::unbox(2L),
      lengths = NULL,
      columns = list(
        path = list(c(1, 2, 4, 5), c(7, 8, 10, 11)),
        foo = rep.int("bar", 2)
      )
    )
  )

  expect_identical(
    deckgl_table(paths, "xyz"),
    list(
      length = jsonlite::unbox(2L),
      lengths = NULL,
      columns = list(
        path = list(
          c(1, 2, 3, 4, 5, 6),
          c(7, 8, 9, 10, 11, 12)
        ),
        foo = rep.int("bar", 2)
      )
    )
  )
})

test_that("deckgl_table works for multilinestrings", {
  paths <- vctrs::data_frame(
    path = wk::wkt(c(
      "MULTILINESTRING Z ((1 2 3, 4 5 6), (7 8 9, 10 11 12))",
      "LINESTRING Z (13 14 15, 16 17 18)"
    )),
    foo = 1:2
  )

  expect_identical(
    deckgl_table(paths, "xy"),
    list(
      length = jsonlite::unbox(3L),
      lengths = c(2L, 1L),
      columns = list(
        path = list(c(1, 2, 4, 5), c(7, 8, 10, 11), c(13, 14, 16, 17)),
        foo = 1:2
      )
    )
  )

  expect_identical(
    deckgl_table(paths, "xyz"),
    list(
      length = jsonlite::unbox(3L),
      lengths = c(2L, 1L),
      columns = list(
        path = list(
          c(1, 2, 3, 4, 5, 6),
          c(7, 8, 9, 10, 11, 12),
          c(13, 14, 15, 16, 17, 18)
        ),
        foo = 1:2
      )
    )
  )
})

test_that("deckgl_table works for polygons", {
  polygons <- vctrs::data_frame(
    polygon = wk::wkt(c(
      "POLYGON Z ((0 0 1, 1 0 1, 1 1 1, 0 1 1, 0 0 1))",
      # CCW
      "POLYGON Z ((0 0 1, 0 1 1, 1 1 1, 1 0 1, 0 0 1))",
      # complex
      "POLYGON Z ((0 0 0, 10 0 0, 10 10 0, 0 10 0, 0 0 0), (2 2 0, 2 8 0, 8 8 0, 8 2 0, 2 2 0))"
    )),
    my_col = 1:3
  )

  expect_identical(
    deckgl_table(polygons, "xy"),
    list(
      length = jsonlite::unbox(3L),
      lengths = NULL,
      columns = list(
        polygon = list(
          c(0, 0, 1, 0, 1, 1, 0, 1, 0, 0),
          c(0, 0, 1, 0, 1, 1, 0, 1, 0, 0),
          list(
            positions = c(
              0, 0, 10, 0, 10, 10, 0, 10, 0, 0,
              2, 2, 2, 8, 8, 8, 8, 2, 2, 2
            ),
            holeIndices = 10L
          )
        ),
        my_col = 1:3
      )
    )
  )

  expect_identical(
    deckgl_table(polygons, "xyz"),
    list(
      length = jsonlite::unbox(3L),
      lengths = NULL,
      columns = list(
        polygon = list(
          c(0, 0, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 0, 0, 1),
          c(0, 0, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 0, 0, 1),
          list(
            positions = c(
              0, 0, 0, 10, 0, 0, 10, 10, 0, 0, 10, 0, 0, 0, 0,
              2, 2, 0, 2, 8, 0, 8, 8, 0, 8, 2, 0, 2, 2, 0
            ),
            holeIndices = 15L
          )
        ),
        my_col = 1:3
      )
    )
  )
})

test_that("deckgl_table works for multipolygons", {
  polygons <- vctrs::data_frame(
    polygon = wk::wkt(c(
      "MULTIPOLYGON (((0 0, 1 0, 1 1, 0 1, 0 0)))",
      # complex multi + re-orient hole
      "MULTIPOLYGON (((0 0, 4 0, 2 3, 0 0), (2 0, 3 1.5, 1 1.5, 2 0)), ((0 0, 4 0, 2 -3, 0 0)))",
      # complex
      "POLYGON ((0 0, 10 0, 10 10, 0 10, 0 0), (2 2, 2 8, 8 8, 8 2, 2 2))"
    )),
    my_col = 1:3
  )

  expect_identical(
    deckgl_table(polygons, "xy"),
    list(
      length = jsonlite::unbox(4L),
      lengths = c(1L, 2L, 1L),
      columns = list(
        polygon = list(
          c(0, 0, 1, 0, 1, 1, 0, 1, 0, 0),
          list(
            positions = c(
              0, 0, 4, 0, 2, 3, 0, 0,
              2, 0, 1, 1.5, 3, 1.5, 2, 0
            ),
            holeIndices = 8L
          ),
          c(0, 0, 2, -3, 4, 0, 0, 0),
          list(
            positions = c(
              0, 0, 10, 0, 10, 10, 0, 10, 0, 0,
              2, 2, 2, 8, 8, 8, 8, 2, 2, 2
            ),
            holeIndices = 10L
          )
        ),
        my_col = 1:3
      )
    )
  )

  expect_identical(
    deckgl_table(wk::wk_set_z(polygons, 1), "xyz"),
    list(
      length = jsonlite::unbox(4L),
      lengths = c(1L, 2L, 1L),
      columns = list(
        polygon = list(
          c(0, 0, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 0, 0, 1),
          list(
            positions = c(
              0, 0, 1, 4, 0, 1, 2, 3, 1, 0, 0, 1,
              2, 0, 1, 1, 1.5, 1, 3, 1.5, 1, 2, 0, 1
            ),
            holeIndices = 12L
          ),
          c(0, 0, 1, 2, -3, 1, 4, 0, 1, 0, 0, 1),
          list(
            positions = c(
              0, 0, 1, 10, 0, 1, 10, 10, 1, 0, 10, 1, 0, 0, 1,
              2, 2, 1, 2, 8, 1, 8, 8, 1, 8, 2, 1, 2, 2, 1
            ),
            holeIndices = 15L
          )
        ),
        my_col = 1:3
      )
    )
  )
})

test_that("deckgl_table works for empty data frames", {
  expect_identical(
    deckgl_table(vctrs::data_frame()),
    list(length = jsonlite::unbox(0L), lengths = NULL, columns = list())
  )

  expect_identical(
    deckgl_table(vctrs::data_frame(foo = integer())),
    list(length = jsonlite::unbox(0L), lengths = NULL, columns = list(foo = integer()))
  )

  expect_identical(
    deckgl_table(vctrs::data_frame(point = wk::wkt("POINT EMPTY"))),
    list(length = jsonlite::unbox(0L), lengths = NULL, columns = list(point = matrix(double(), ncol = 2L))),
    ignore_attr = "dimnames"
  )

  expect_identical(
    deckgl_table(vctrs::data_frame(point = wk::wkt("POINT EMPTY"), foo = integer())),
    list(length = jsonlite::unbox(0L), lengths = NULL, columns = list(point = matrix(double(), ncol = 2L), foo = integer()))
  )
})

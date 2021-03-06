context("to_ndjson")

test_that("objects converted to ndjson",{

  ## vectors - as per json
  expect_equal( unclass( to_ndjson( 1:5 ) ),"[1,2,3,4,5]\n")
  expect_equal( unclass( to_ndjson( letters[1:5] ) ), '["a","b","c","d","e"]\n')

  mat <- matrix(1:6, ncol = 2)

  expect_equal( unclass( to_ndjson( x = mat ) ), '[1,4]\n[2,5]\n[3,6]\n')
  expect_equal( unclass( to_ndjson( x = mat, by = "col" ) ), '[1,2,3]\n[4,5,6]\n' )

  df <- data.frame(
    x = 1:5
    , y = letters[1:5]
    , z = as.Date(seq(18262, 18262 + 4, by = 1 ), origin = "1970-01-01" )
    )

  expect_equal( unclass( to_ndjson( x = df ) ) , "{\"x\":1,\"y\":\"a\",\"z\":18262.0}\n{\"x\":2,\"y\":\"b\",\"z\":18263.0}\n{\"x\":3,\"y\":\"c\",\"z\":18264.0}\n{\"x\":4,\"y\":\"d\",\"z\":18265.0}\n{\"x\":5,\"y\":\"e\",\"z\":18266.0}\n" )
  expect_equal( unclass( to_ndjson( x = df, numeric_dates = FALSE ) ), "{\"x\":1,\"y\":\"a\",\"z\":\"2020-01-01\"}\n{\"x\":2,\"y\":\"b\",\"z\":\"2020-01-02\"}\n{\"x\":3,\"y\":\"c\",\"z\":\"2020-01-03\"}\n{\"x\":4,\"y\":\"d\",\"z\":\"2020-01-04\"}\n{\"x\":5,\"y\":\"e\",\"z\":\"2020-01-05\"}\n" )
  expect_equal( unclass( to_ndjson( x = df, factors_as_string = FALSE ) ), "{\"x\":1,\"y\":1,\"z\":18262.0}\n{\"x\":2,\"y\":2,\"z\":18263.0}\n{\"x\":3,\"y\":3,\"z\":18264.0}\n{\"x\":4,\"y\":4,\"z\":18265.0}\n{\"x\":5,\"y\":5,\"z\":18266.0}\n" )
  expect_equal( unclass( to_ndjson( x = df, by = "column" ) ), "{\"x\":[1,2,3,4,5]}\n{\"y\":[\"a\",\"b\",\"c\",\"d\",\"e\"]}\n{\"z\":[18262.0,18263.0,18264.0,18265.0,18266.0]}\n" )

  ## Lists are non-recurisve; only elements `x` and `y` are converted to ndjson
  lst <- list(
    x = 1:5
    , y = list(
      a = letters[1:5]
      , b = data.frame(i = 10:15, j = 20:25)
    )
  )

  expect_equal( unclass( to_ndjson( x = lst ) ), "[1,2,3,4,5]\n{\"a\":[\"a\",\"b\",\"c\",\"d\",\"e\"],\"b\":[{\"i\":10,\"j\":20},{\"i\":11,\"j\":21},{\"i\":12,\"j\":22},{\"i\":13,\"j\":23},{\"i\":14,\"j\":24},{\"i\":15,\"j\":25}]}\n" )
  expect_equal( unclass( to_ndjson( x = lst, by = "column") ), "[1,2,3,4,5]\n{\"a\":[\"a\",\"b\",\"c\",\"d\",\"e\"],\"b\":{\"i\":[10,11,12,13,14,15],\"j\":[20,21,22,23,24,25]}}\n" )


})
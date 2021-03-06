################################################################################
# Copyright 2017-2018 Gabriele Valentini, Douglas G. Moore. All rights reserved.
# Use of this source code is governed by a MIT license that can be found in the
# LICENSE file.
################################################################################
library(rinform)
context("Black Box Parts")

test_that("black_box_parts checks parameters", {
  xs <- sample(0:1, 10, T)
  expect_error(black_box_parts("series", parts = c(0)))
  expect_error(black_box_parts(NULL,     parts = c(0)))
  expect_error(black_box_parts(NA,       parts = c(0)))
  expect_error(black_box_parts(xs,       parts = c(0)))

  xs <- matrix(xs, ncol = 2)
  expect_error(black_box_parts(xs, parts = "parts"))
  expect_error(black_box_parts(xs, parts = NULL))
  expect_error(black_box_parts(xs, parts = NA))
  expect_error(black_box_parts(xs, parts = c(0)))
  expect_error(black_box_parts(xs, parts = c(1)))
  expect_error(black_box_parts(xs, parts = c(2)))
  expect_error(black_box_parts(xs, parts = c(-1, 2)))
  expect_error(black_box_parts(xs, parts = c(1, 3)))
  expect_error(black_box_parts(xs, parts = c(1, 0)))
})

test_that("black_box_parts on single series", {
  series <- matrix(c(0, 1, 1, 1, 0, 1), ncol = 2)
  expect <- black_box(series, l = 2)
  x      <- black_box_parts(series, parts = c(1, 1))
  expect_equal(length(x$box), length(expect), tolerance = 1e-6)
  for (i in 1:3) expect_equal(x$box[i], expect[i], tolerance = 1e-6)

  series <- matrix(c(0, 1, 1, 1, 0, 1, 0, 0, 1), ncol = 3)
  expect <- black_box(series, l = 3)
  x      <- black_box_parts(series, parts = c(1, 1, 1))
  expect_equal(length(x$box), length(expect), tolerance = 1e-6)
  for (i in 1:3) expect_equal(x$box[i], expect[i], tolerance = 1e-6)

  series <- matrix(c(0, 1, 1, 1, 0, 1), ncol = 2)
  x      <- black_box_parts(series, parts = c(1, 2))
  expect_equal(length(x$box), length(series), tolerance = 1e-6)
  for (i in 1:6) expect_equal(x$box[i], series[i], tolerance = 1e-6)

  series <- matrix(c(0, 1, 1, 1, 0, 1, 0, 0, 1), ncol = 3)
  expect <- black_box(series[, 1:2], l = 2)
  x      <- black_box_parts(series, parts = c(1, 1, 2))
  expect_equal(dim(x$box)[1], length(expect), tolerance = 1e-6)
  for (i in 1:3) expect_equal(x$box[i, 1], expect[i], tolerance = 1e-6)
  for (i in 1:3) expect_equal(x$box[i, 2], series[i, 3], tolerance = 1e-6)

  series <- matrix(c(0, 1, 1, 1, 0, 1, 0, 0, 1), ncol = 3)
  expect <- black_box(series[, 2:3], l = 2)
  x      <- black_box_parts(series, parts = c(1, 2, 2))
  expect_equal(dim(x$box)[1], length(expect), tolerance = 1e-6)
  for (i in 1:3) expect_equal(x$box[i, 2], expect[i], tolerance = 1e-6)
  for (i in 1:3) expect_equal(x$box[i, 1], series[i, 1], tolerance = 1e-6)

  series <- matrix(c(0, 1, 1, 1, 0, 1, 0, 0, 1), ncol = 3)
  expect <- black_box(series[, c(1, 3)], l = 2)
  x      <- black_box_parts(series, parts = c(1, 2, 1))
  expect_equal(dim(x$box)[1], length(expect), tolerance = 1e-6)
  for (i in 1:3) expect_equal(x$box[i, 1], expect[i], tolerance = 1e-6)
  for (i in 1:3) expect_equal(x$box[i, 2], series[i, 2], tolerance = 1e-6)

  series <- matrix(c(0, 1, 1, 1, 0, 1, 0, 0, 1), ncol = 3)
  x      <- black_box_parts(series, parts = c(1, 2, 3))
  expect_equal(dim(x$box)[1], length(expect), tolerance = 1e-6)
  for (i in 1:9) expect_equal(x$box[i], series[i], tolerance = 1e-6)	
})

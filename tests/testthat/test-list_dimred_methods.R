context("Retrieving dimred methods")

test_that("Retrieving dimred_methods", {
  methods <- list_dimred_methods()
  expect_is(methods, "list")
  expect_gt(length(methods), 0)
  expect_named(methods)
})

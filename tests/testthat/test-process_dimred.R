context("Testing .process_dimred")

test_that("Testing .process_dimred", {
  sp <- matrix(runif(1:10), nrow = 2)
  new_sp <- .process_dimred(sp, c("A", "B"))
  expect_identical(rownames(new_sp), c("A", "B"))
  expect_identical(colnames(new_sp), paste0("comp_", seq_len(5)))
})

context("Dimred with sparse matrices")

small_expr <- abs(Matrix::rsparsematrix(100, 100, .5))

methods <- list_dimred_methods()

for (method_name in names(methods)) {
  test_that(paste0("Perform dimred ", method_name), {
    method_fun <- methods[[method_name]]
    expect_is(method_fun, "function")

    capture.output({
      pdf(file = NULL)

      set.seed(1)
      out1 <- method_fun(small_expr)
      set.seed(1)
      out2 <- method_fun(as.matrix(small_expr))

      dev.off()
    })

    expect_identical(dimnames(out1), dimnames(out2))

    v1 <- as.vector(as.matrix(dist(out1)))
    v2 <- as.vector(as.matrix(dist(out2)))

    expect_true(all(cor(cbind(v1, v2)) > .80))

  })
}
large_expr <- abs(Matrix::rsparsematrix(2000, 1000, .05))

should_scale <- c("pca", "landmark_mds")
for (method_name in should_scale) {
  test_that(paste0("Perform large dimred ", method_name), {
    method_fun <- methods[[method_name]]
    expect_is(method_fun, "function")

    capture.output({
      pdf(file = NULL)

      out1 <- method_fun(large_expr)

      dev.off()
    })

    expect_is(out1, "matrix")
    expect_identical(rownames(out1), rownames(large_expr))
    expect_identical(colnames(out1), paste0("comp_", seq_len(ncol(out1))))
  })
}

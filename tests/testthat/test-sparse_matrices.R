context("Dimred with sparse matrices")

generate_expr <- function(nrow, ncol) {
  i <- unlist(lapply(seq_len(nrow), function(i) rep(i, sample(25:50, 1))))
  j <- sample(seq_len(ncol), length(i), replace = TRUE)
  expr <- Matrix::sparseMatrix(i = i, j = j, x = runif(length(i)))

  rownames(expr) <- sample(paste0("cell", seq_len(nrow(expr))))
  colnames(expr) <- sample(paste0("gene", seq_len(ncol(expr))))

  expr
}

small_expr <- generate_expr(nrow = 200, ncol = 500)

methods <- list_dimred_methods()

for (method_name in names(methods)) {
  test_that(paste0("Perform dimred ", method_name), {
    method_fun <- methods[[method_name]]
    expect_is(method_fun, "function")

    pdf("/dev/null")
    sink("/dev/null")
    set.seed(1)
    out1 <- method_fun(small_expr)
    set.seed(1)
    out2 <- method_fun(as.matrix(small_expr))
    sink()

    expect_identical(dimnames(out1), dimnames(out2))

    v1 <- as.vector(as.matrix(dist(out1)))
    v2 <- as.vector(as.matrix(dist(out2)))

    expect_true(all(cor(cbind(v1, v2)) > .80))
    dev.off()
  })
}

large_expr <- generate_expr(nrow = 20000, ncol = 10000)

should_scale <- c("pca")
for (method_name in should_scale) {
  test_that(paste0("Perform large dimred ", method_name), {
    method_fun <- methods[[method_name]]
    expect_is(method_fun, "function")

    pdf("/dev/null")
    sink("/dev/null")
    out1 <- method_fun(large_expr)
    sink()

    expect_is(out1, "matrix")
    expect_identical(rownames(out1), rownames(large_expr))
    expect_identical(colnames(out1), paste0("comp_", seq_len(ncol(out1))))
    dev.off()
  })
}

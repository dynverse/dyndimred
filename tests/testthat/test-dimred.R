context("Dimred for expression")

set.seed(1)
expr <- generate_dataset(num_samples = 100, num_genes = 100)

methods <- list_dimred_methods()

for (method_name in names(methods)) {
  test_that(paste0("Perform dimred ", method_name), {
    method_fun <- methods[[method_name]]
    expect_is(method_fun, "function")

    capture.output({
      pdf(file = NULL)
      set.seed(1)
      out1 <- method_fun(expr)

      dev.off()
    })

    expect_is(out1, "matrix")
    expect_identical(rownames(out1), rownames(expr))
    expect_identical(colnames(out1), paste0("comp_", seq_len(ncol(out1))))

    set.seed(1)
    capture.output({
      out2 <- method_fun(expr, ndim = 2)
    })
    expect_is(out2, "matrix")
    expect_identical(rownames(out2), rownames(expr))
    expect_identical(colnames(out2), paste0("comp_", seq_len(ncol(out2))))
    expect_equal(ncol(out2), 2)

    capture.output({
      set.seed(1)
      ndim <- ifelse(method_name == "tsne", 3, 5)
      out3 <- dimred(expr, method = method_name, ndim = ndim)
      expect_is(out3, "matrix")
      expect_identical(rownames(out3), rownames(expr))
      expect_identical(colnames(out3), paste0("comp_", seq_len(ncol(out3))))
      expect_equal(ncol(out3), ndim)
    })

    v1 <- as.vector(as.matrix(dist(out1)))
    v2 <- as.vector(as.matrix(dist(out2)))
    v3 <- as.vector(as.matrix(dist(out3)))

    expect_true(all(cor(cbind(v1, v2, v3)) > .25))

  })
}

context("Dimred for expression")

set.seed(1)
expr <- generate_dataset(num_samples = 200, num_genes = 200)
sparse_expr <- Matrix::Matrix(expr, sparse = TRUE)


for (i in seq_len(nrow(dr_methods))) {
  dr_name <- dr_methods$name[[i]]
  dr_fun <- dr_methods$fun[[i]]
  dr_requires <- dr_methods$requires[[i]]
  req_check <- sapply(dr_requires, function(req) requireNamespace(req, quietly = TRUE))

  if (!all(req_check)) {
    # generate warning if not on cran
    if (identical(Sys.getenv("NOT_CRAN"), "true")) {
      test_that(paste0("Requirements are met for ", dr_name), {
        warning("Not all requirements are met: ", paste(dr_requires[!req_check], collapse = ", "))
      })
    }
  } else {
    test_that(paste0("Perform dimred with ", dr_name), {
      capture.output({
        pdf(file = NULL)
        set.seed(1)
        out1 <- dr_fun(expr)

        dev.off()
      })

      expect_is(out1, "matrix")
      expect_identical(rownames(out1), rownames(expr))
      expect_identical(colnames(out1), paste0("comp_", seq_len(ncol(out1))))

      set.seed(1)
      capture.output({
        out2 <- dr_fun(expr, ndim = 2)
      })
      expect_is(out2, "matrix")
      expect_identical(rownames(out2), rownames(expr))
      expect_identical(colnames(out2), paste0("comp_", seq_len(ncol(out2))))
      expect_equal(ncol(out2), 2)

      capture.output({
        set.seed(1)
        ndim <-
          if (dr_name == "knn_fr") {
            2
          } else if (dr_name == "tsne") {
            3
          } else {
            5
          }
        out3 <- dimred(expr, method = dr_name, ndim = ndim)
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

    test_that(paste0("Check sparse capable ", dr_name), {
      capture.output({
        pdf(file = NULL)

        set.seed(1)
        out1 <- dr_fun(sparse_expr)
        set.seed(1)
        out2 <- dr_fun(as.matrix(sparse_expr))

        dev.off()
      })

      expect_identical(dimnames(out1), dimnames(out2))

      v1 <- as.vector(as.matrix(dist(out1)))
      v2 <- as.vector(as.matrix(dist(out2)))

      expect_true(all(cor(cbind(v1, v2)) > .80))

    })
  }
}

#' @rdname dimred
#' @export
#' @inheritParams uwot::umap
dimred_umap <- function(x, ndim = 2, n_neighbors = 15L, init = "spectral", n_threads = 1) {
  # `install_packages()` checks whether the required package is installed
  # and will prompt the user about whether it should be installed
  install_packages("uwot")
  requireNamespace("uwot")

  if (is_sparse(x)) {
    x <- as.matrix(x)
  }

  space <- uwot::umap(x, n_components = ndim, n_neighbors = n_neighbors, init = init, n_threads = n_threads)

  .process_dimred(space, rownames(x))
}

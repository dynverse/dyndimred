#' @rdname dimred
#' @export
#' @inheritParams uwot::umap
dimred_umap <- function(x, ndim = 2, distance_method = c("euclidean", "cosine", "manhattan"), n_neighbors = 15L, init = "spectral", n_threads = 1) {
  # `install_packages()` checks whether the required package is installed
  # and will prompt the user about whether it should be installed
  install_packages("uwot")
  requireNamespace("uwot")

  if (is_sparse(x)) {
    x <- as.matrix(x)
  }
  distance_method <- match.arg(distance_method)
  space <- uwot::umap(
    x,
    n_components = ndim,
    n_neighbors = n_neighbors,
    metric = distance_method,
    init = init,
    n_threads = n_threads,
    nn_method = "annoy"
  )

  .process_dimred(space, rownames(x))
}

#' UMAP
#' @inheritParams dimred
#' @inheritParams uwot::umap
#' @seealso [uwot::umap()]
#' @export
dimred_umap <- function(x, ndim = 2, n_neighbors = 15L, init = "spectral", n_threads = 1) {
  dynutils::install_packages(dependencies = "uwot", package = "dyndimred")

  requireNamespace("uwot")
  space <- uwot::umap(x, n_components = ndim, n_neighbors = n_neighbors, init = init, n_threads = n_threads)
  process_dimred(space, rownames(x))
}

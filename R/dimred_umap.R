#' UMAP
#' @inheritParams dimred
#' @inheritParams uwot::umap
#' @seealso [uwot::umap()]
#' @export
dimred_umap <- function(x, ndim = 2, n_neighbors = 15L, alpha = 1, init = "spectral", n_threads = 1) {
  dynutils::install_packages(dependencies = "uwot", package = "dyndimred")

  requireNamespace("uwot")
  space <- uwot::umap(x, n_components = ndim, n_neighbors = n_neighbors, alpha = alpha, init = init, n_threads = n_threads)
  process_dimred(space, rownames(x))
}

process_dimred <- function(space, rn = rownames(space)) {
  space <- as.matrix(space)
  dimnames(space) <- list(rn, paste0("comp_", seq_len(ncol(space))))
  space
}

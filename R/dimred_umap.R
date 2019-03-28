#' UMAP
#' @inheritParams dimred
#' @inheritParams uwot::umap
#' @seealso [uwot::umap()]
#' @export
dimred_umap <- function(x, ndim = 2, n_neighbors = 15L, init = "spectral") {
  required_check("umap")

  if (dynutils::is_sparse(x)) {
    x <- as.matrix(x)
  }

  config <- umap::umap.defaults
  config$n_components <- ndim
  config$n_neighbors <- n_neighbors
  config$init <- init

  requireNamespace("umap")
  space <- umap::umap(x, config)
  process_dimred(space$layout, rownames(x))
}

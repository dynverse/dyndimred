#' UMAP
#' @inheritParams dimred
#' @inheritParams uwot::umap
#' @param pca_components The number of pca components to use for UMAP. If NULL, PCA will not be performed first
#' @seealso [uwot::umap()]
#' @export
#'
#' @examples
#' library(Matrix)
#' dataset <- abs(Matrix::rsparsematrix(100, 100, .5))
#' dimred_umap(dataset, ndim = 2, pca_components = NULL)
dimred_umap <- function(x, ndim = 2, distance_method = c("euclidean", "cosine", "manhattan"), pca_components = 50, n_neighbors = 15L, init = "spectral", n_threads = 1) {
  requireNamespace("uwot")

  if (!is.null(pca_components)) {
    x <- dimred_pca(x, ndim = pca_components)
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

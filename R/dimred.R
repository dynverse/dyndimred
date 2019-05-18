#' Perform simple dimensionality reduction
#'
#' @param x Log transformed expression data, with rows as cells and columns as features
#' @param method The name of the dimensionality reduction method to use
#' @param distance_method The name of the distance metric, see [dynutils::calculate_distance]
#' @param ndim The number of dimensions
#' @param ... Any arguments to be passed to the dimensionality reduction method
#'
#' @examples
#' x <- abs(Matrix::rsparsematrix(100, 100, .5))
#' dimred(x, "pca", ndim = 3)
#' dimred(x, "ica", ndim = 3)
#'
#' \dontrun{
#' dimred_dm_destiny(x)
#' dimred_dm_diffusionmap(x)
#' dimred_ica(x)
#' dimred_landmark_mds(x)
#' dimred_lle(x)
#' dimred_mds(x)
#' dimred_mds_isomds(x)
#' dimred_mds_sammon(x)
#' dimred_mds_smacof(x)
#' dimred_pca(x)
#' dimred_tsne(x)
#' dimred_umap(x)
#' }
#'
#' @export
dimred <- function(x, method, ndim, ...) {
  methods <- list_dimred_methods()
  if (method %in% names(methods)) {
    meth <- methods[[method]]
    params <- list(x = x, ndim = ndim, ...)
    do.call(meth, params)
  } else {
    stop("Method ", sQuote(method), " not found.")
  }
}

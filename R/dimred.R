#' Perform simple dimensionality reduction
#'
#' @param x Log transformed expression data, with rows as cells and columns as features
#' @param method The name of the dimensionality reduction method to use
#' @param distance_method The name of the distance metric, see [dynutils::calculate_distance]
#' @param ndim The number of dimensions
#' @param ... Any arguments to be passed to the dimensionality reduction method
#'
#' @examples
#' dataset <- abs(Matrix::rsparsematrix(100, 100, .5))
#' dimred(dataset, "pca", ndim = 3)
#' dimred_pca(dataset)
#' dimred_mds(dataset)
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

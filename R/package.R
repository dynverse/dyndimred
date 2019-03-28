#' Common dimensionality reduction methods
#'
#' Provides a common interface for applying common dimensionality reduction methods,
#' Such as PCA, ICA, diffusion maps, LLE, t-SNE, and umap.
#'
#' @importFrom dynutils correlation_distance install_packages
#'
#' @docType package
#' @name dyndimred
NULL



required_check <- function (pkg) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    stop(paste0(package, "not installed, install it using install.packages('", package, "')"))
  }
}

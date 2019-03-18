#' @rdname dimred
#' @export
dimred_lle <- function(x, ndim = 3) {
  dynutils::install_packages(dependencies = "lle", package = "dyndimred")

  if (dynutils::is_sparse(x)) {
    x <- as.matrix(x)
  }

  requireNamespace("lle")
  k <- lle::calc_k(t(scale(t(x))), ndim)
  k <- k$k[which.min(k$rho)]
  space <- lle::lle(t(scale(t(x))), ndim, k)$Y
  process_dimred(space, rownames(x))
}

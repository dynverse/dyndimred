#' @rdname dimred
#' @export
dimred_lle <- function(x, ndim = 3) {
  # `install_packages()` checks whether the required package is installed.
  # If the session is interactive and the package is not installed,
  # The user will be prompted about whether it should be installed.
  install_packages("lle")

  if (is_sparse(x)) {
    x <- as.matrix(x)
  }

  requireNamespace("lle")

  x_sc <- t(scale(t(x)))

  k <- lle::calc_k(x_sc, m = ndim)

  k <- k$k[which.min(k$rho)]

  space <- lle::lle(x_sc, m = ndim, k = k)$Y

  .process_dimred(space, rownames(x))
}

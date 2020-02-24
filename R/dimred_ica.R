#' @rdname dimred
#' @export
dimred_ica <- function(x, ndim = 3) {
  # `install_packages()` checks whether the required package is installed.
  # If the session is interactive and the package is not installed,
  # The user will be prompted about whether it should be installed.
  install_packages("fastICA")
  requireNamespace("fastICA")

  if (is_sparse(x)) {
    x <- as.matrix(x)
  }

  space <- fastICA::fastICA(t(scale(t(x))), n.comp = ndim)$S

  .process_dimred(space)
}

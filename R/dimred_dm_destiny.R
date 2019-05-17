#' @rdname dimred
#' @export
dimred_dm_destiny <- function(x, ndim = 2) {
  # `install_packages()` checks whether the required package is installed
  # and will prompt the user about whether it should be installed
  install_packages("destiny")
  requireNamespace("destiny")

  if (is_sparse(x)) {
    x <- as.matrix(x)
  }

  dm <- destiny::DiffusionMap(
    data = x,
    n_eigs = ndim
  )

  .process_dimred(dm@eigenvectors[,seq_len(ndim)], rownames(x))
}

#' @rdname dimred
#' @export
#'
#' @importFrom stats as.dist
dimred_dm_destiny <- function(x, ndim = 2) {
  required_check("destiny")

  if (dynutils::is_sparse(x)) {
    x <- as.matrix(x)
  }

  requireNamespace("destiny")

  dm <- destiny::DiffusionMap(
    data = x,
    n_eigs = ndim
  )
  process_dimred(dm@eigenvectors[,seq_len(ndim)], rownames(x))
}

#' @rdname dimred
#' @export
dimred_ica <- function(x, ndim = 3) {
  dynutils::install_packages("fastICA")

  if (dynutils::is_sparse(x)) {
    x <- as.matrix(x)
  }

  requireNamespace("fastICA")
  space <- fastICA::fastICA(t(scale(t(x))), ndim)$S
  process_dimred(space)
}

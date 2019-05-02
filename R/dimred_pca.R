#' @rdname dimred
#' @export
dimred_pca <- function(x, ndim = 2) {
  dynutils::install_packages("irlba")
  requireNamespace("irlba")

  space <- irlba::prcomp_irlba(x, n = ndim)$x

  .process_dimred(space, rn = rownames(x))
}

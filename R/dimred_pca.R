#' @rdname dimred
#' @importFrom irlba prcomp_irlba
#' @export
dimred_pca <- function(x, ndim = 2) {
  space <- irlba::prcomp_irlba(x, n = ndim)$x

  process_dimred(space)
}

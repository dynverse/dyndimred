#' @rdname dimred
#' @export
dimred_pca <- function(x, ndim = 2) {
  space <- stats::prcomp(x)$x[,seq_len(ndim)]
  process_dimred(space)
}

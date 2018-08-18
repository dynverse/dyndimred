#' @rdname dimred
#' @export
dimred_mds <- function(x, ndim = 2) {
  space <- stats::cmdscale(dynutils::correlation_distance(x), k = ndim)
  process_dimred(space)
}

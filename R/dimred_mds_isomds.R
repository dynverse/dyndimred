#' @rdname dimred
#' @export
dimred_mds_isomds <- function(x, ndim = 2) {
  dynutils::install_packages(c("MASS"), "dyndimred")

  dist <- dynutils::correlation_distance(x)
  space <- MASS::isoMDS(dist, k = ndim)$points
  process_dimred(space)
}

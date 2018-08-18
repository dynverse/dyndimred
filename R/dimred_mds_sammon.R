#' @rdname dimred
#' @export
dimred_mds_sammon <- function(x, ndim = 2) {
  dynutils::install_packages(c("MASS"), "dyndimred")

  dist <- dynutils::correlation_distance(x)
  space <- MASS::sammon(dist, k = ndim)$points
  process_dimred(space)
}

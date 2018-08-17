#' @rdname dimred
#' @export
dimred_mds_smacof <- function(x, ndim = 2) {
  dynutils::install_packages(c("smacof"), "dyndimred")

  dist <- dynutils::correlation_distance(x)
  space <- smacof::mds(as.dist(dist), type = "ratio", ndim = ndim)$conf
  process_dimred(space)
}

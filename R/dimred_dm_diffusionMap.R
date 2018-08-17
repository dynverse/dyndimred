#' @rdname dimred
#' @export
#'
#' @importFrom stats as.dist
dimred_dm_diffusionMap <- function(x, ndim = 2) {
  dynutils::install_packages(dependencies = "diffusionMap", package = "dyndimred")

  requireNamespace("diffusionMap")
  dist <- dynutils::correlation_distance(x)
  space <- diffusionMap::diffuse(stats::as.dist(dist), neigen = ndim, delta = 10e-5)$X
  process_dimred(space[,seq_len(ndim)], rownames(x))
}

#' @rdname dimred
#' @export
#'
#' @importFrom stats as.dist
dimred_dm_diffusionmap <- function(
  x,
  ndim = 2,
  distance_method
) {
  requireNamespace("diffusionMap")

  distance_method <- match.arg(distance_method)
  dist <- calculate_distance(x, method = distance_method)

  space <- diffusionMap::diffuse(as.dist(dist), neigen = ndim, delta = 10e-5)$X

  .process_dimred(space[,seq_len(ndim)], rownames(x))
}

formals(dimred_dm_diffusionmap)$distance_method <- dynutils::list_distance_methods()

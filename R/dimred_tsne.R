#' tSNE
#' @inheritParams dimred
#' @inheritParams Rtsne::Rtsne
#' @seealso [Rtsne::Rtsne()]
#' @export
dimred_tsne <- function(x, ndim = 2, perplexity = 30, theta = 0.5, initial_dims = 50) {
  dynutils::install_packages(c("Rtsne"), "dyndimred")

  requireNamespace("Rtsne")
  space <- Rtsne::Rtsne(
    as.dist(dynutils::correlation_distance(x)),
    dims = ndim,
    is_distance = TRUE,
    perplexity = perplexity,
    theta = theta,
    initial_dims = initial_dims
  )$Y
  rownames(space) = rownames(x)
  process_dimred(space)
}

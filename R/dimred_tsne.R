#' tSNE
#' @inheritParams dimred
#' @inheritParams Rtsne::Rtsne
#' @seealso [Rtsne::Rtsne()]
#' @export
dimred_tsne <- function(x, ndim = 2, perplexity = 30, theta = 0.5, initial_dims = 50, distance_method) {
  install_packages("Rtsne")
  requireNamespace("Rtsne")

  dis <- calculate_distance(x, method = distance_method)

  space <- Rtsne::Rtsne(
    as.dist(dis),
    dims = ndim,
    is_distance = TRUE,
    perplexity = perplexity,
    theta = theta,
    initial_dims = initial_dims
  )$Y

  .process_dimred(space, rownames(x))
}

formals(dimred_tsne)$distance_method <- dynutils::list_distance_methods()

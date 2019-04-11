#' tSNE
#' @inheritParams dimred
#' @inheritParams Rtsne::Rtsne
#' @seealso [Rtsne::Rtsne()]
#' @export
dimred_tsne <- function(x, ndim = 2, perplexity = 30, theta = 0.5, initial_dims = 50, distance_metric) {
  install_packages("Rtsne")
  requireNamespace("Rtsne")

  dis <- calculate_distance(x, metric = distance_metric)

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

formals(dimred_tsne)$distance_metric <- dynutils::list_distance_metrics()

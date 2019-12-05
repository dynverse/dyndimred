#' @importFrom lmds lmds
#' @rdname dimred
#' @param n_neighbors The size of local neighborhood (in terms of number of neighboring sample points).
#' @param lmds_components The number of lmds components to use.
#'   If NULL, LMDS will not be performed first.
#'   If this is a matrix, it is assumed it is a dimred for x.
#' @export
dimred_knn_fr <- function(
  x,
  lmds_components = 10,
  distance_method,
  n_neighbors = 10
) {
  requireNamespace("igraph")
  requireNamespace("RANN")

  distance_method <- match.arg(distance_method)

  if (is.null(lmds_components)) {
    space <- x
  } else if (!is.matrix(lmds_components)) {
    space <- lmds_components
  } else {
    space <- lmds::lmds(
      x = x,
      ndim = lmds_components,
      distance_method = distance_method
    )
  }

  knn <- RANN::nn2(space, k = n_neighbors)

  kdf <- data.frame(
    i = as.vector(row(knn$nn.idx)),
    j = as.vector(knn$nn.idx),
    d = 1 / as.vector(knn$nn.dists)
  )
  kdf <- kdf[kdf$i != kdf$j]

  gr <- igraph::graph_from_data_frame(kdf, vertices = seq_len(nrow(x)))

  dimred <- dynutils::scale_uniform(igraph::layout_with_fr(gr))
  rownames(dimred) <- rownames(x)

  .process_dimred(dimred)
}

formals(dimred_knn_fr)$distance_method <- dynutils::list_distance_methods()

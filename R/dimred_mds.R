#' @rdname dimred
#' @export
dimred_mds <- function(x, ndim = 2, distance_metric) {
  dis <- calculate_distance(x, metric = distance_metric)
  space <- stats::cmdscale(as.dist(dis), k = ndim)

  .process_dimred(space)
}

formals(dimred_mds)$distance_metric <- dynutils::list_distance_metrics()

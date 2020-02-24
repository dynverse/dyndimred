#' @rdname dimred
#' @export
dimred_mds <- function(x, ndim = 2, distance_method) {
  distance_method <- match.arg(distance_method)
  dis <- calculate_distance(x, method = distance_method)
  space <- stats::cmdscale(as.dist(dis), k = ndim)
  .process_dimred(space)
}

formals(dimred_mds)$distance_method <- dynutils::list_distance_methods()

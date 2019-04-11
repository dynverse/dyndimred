#' @rdname dimred
#' @export
dimred_mds_isomds <- function(x, ndim = 2, distance_metric) {
  dynutils::install_packages(c("MASS"), "dyndimred")

  dis <- calculate_distance(x, metric = distance_metric)
  space <- MASS::isoMDS(as.dist(dis), k = ndim)$points

  .process_dimred(space)
}
formals(dimred_mds_isomds)$distance_metric <- dynutils::list_distance_metrics()

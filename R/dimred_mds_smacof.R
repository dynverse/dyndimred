#' @rdname dimred
#' @export
dimred_mds_smacof <- function(x, ndim = 2, distance_metric) {
  dynutils::install_packages(c("smacof"), "dyndimred")

  dis <- calculate_distance(x, metric = distance_metric)
  space <- smacof::mds(as.dist(dis), type = "ratio", ndim = ndim)$conf

  .process_dimred(space)
}

formals(dimred_mds_smacof)$distance_metric <- dynutils::list_distance_metrics()

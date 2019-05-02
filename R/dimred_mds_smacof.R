#' @rdname dimred
#' @export
dimred_mds_smacof <- function(x, ndim = 2, distance_method) {
  dynutils::install_packages(c("smacof"), "dyndimred")

  dis <- calculate_distance(x, method = distance_method)
  space <- smacof::mds(as.dist(dis), type = "ratio", ndim = ndim)$conf

  .process_dimred(space)
}

formals(dimred_mds_smacof)$distance_method <- dynutils::list_distance_methods()

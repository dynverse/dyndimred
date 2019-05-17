#' @rdname dimred
#' @export
dimred_mds_isomds <- function(x, ndim = 2, distance_method) {
  # `install_packages()` checks whether the required package is installed
  # and will prompt the user about whether it should be installed
  install_packages("MASS", "dyndimred")
  requireNamespace("MASS")

  dis <- calculate_distance(x, method = distance_method)
  space <- MASS::isoMDS(as.dist(dis), k = ndim)$points

  .process_dimred(space)
}
formals(dimred_mds_isomds)$distance_method <- dynutils::list_distance_methods()

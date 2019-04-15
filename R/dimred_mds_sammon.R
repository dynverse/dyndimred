#' @rdname dimred
#' @export
dimred_mds_sammon <- function(x, ndim = 2, distance_method) {
  dynutils::install_packages(c("MASS"), "dyndimred")

  dis <- calculate_distance(x, method = distance_method)
  space <- MASS::sammon(as.dist(dis), k = ndim)$points

  .process_dimred(space)
}

formals(dimred_mds_sammon)$distance_method <- dynutils::list_distance_methods()

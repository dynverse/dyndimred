#' @rdname dimred
#' @export
dimred_mds_sammon <- function(x, ndim = 2, distance_method) {
  # `install_packages()` checks whether the required package is installed.
  # If the session is interactive and the package is not installed,
  # The user will be prompted about whether it should be installed.
  install_packages("MASS", "dyndimred")
  requireNamespace("MASS")

  distance_method <- match.arg(distance_method)
  dis <- calculate_distance(x, method = distance_method)
  space <- MASS::sammon(as.dist(dis), k = ndim)$points

  .process_dimred(space)
}

formals(dimred_mds_sammon)$distance_method <- dynutils::list_distance_methods()

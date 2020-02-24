#' @rdname dimred
#' @export
dimred_mds_smacof <- function(x, ndim = 2, distance_method) {
  # `install_packages()` checks whether the required package is installed.
  # If the session is interactive and the package is not installed,
  # The user will be prompted about whether it should be installed.
  install_packages("smacof", "dyndimred")
  requireNamespace("smacof")

  distance_method <- match.arg(distance_method)
  dis <- calculate_distance(x, method = distance_method)
  space <- smacof::mds(as.dist(dis), type = "ratio", ndim = ndim)$conf

  .process_dimred(space)
}

formals(dimred_mds_smacof)$distance_method <- dynutils::list_distance_methods()

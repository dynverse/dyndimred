#' @rdname dimred
#' @export
dimred_ica <- function(x, ndim = 3) {
  dynutils::install_packages(dependencies = "fastICA", package = "dyndimred")

  requireNamespace("fastICA")
  space <- fastICA::fastICA(t(scale(t(x))), ndim)$S
  process_dimred(space)
}
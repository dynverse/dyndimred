#' Landmark MDS
#' @inheritParams dimred
#' @inheritParams SCORPIUS::reduce_dimensionality
#' @seealso [SCORPIUS::reduce_dimensionality()]
#' @export
dimred_landmark_mds <- function(x, ndim = 2, landmark_method = "naive", num_landmarks = 100, rescale = T) {
  dynutils::install_packages(c("SCORPIUS"), "dyndimred")

  # TODO: this should really work with sparse matrices...
  if (dynutils::is_sparse(x)) {
    x <- as.matrix(x)
  }

  requireNamespace("SCORPIUS")
  space <- SCORPIUS::reduce_dimensionality(
    x,
    dynutils::correlation_distance,
    num_landmarks = num_landmarks,
    ndim = ndim
  )

  process_dimred(space)
}

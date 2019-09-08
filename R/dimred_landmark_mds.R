#' Landmark MDS
#'
#' @inheritParams lmds::lmds
#'
#' @importFrom lmds lmds
#'
#' @export
#'
#' @examples
#' library(Matrix)
#' dataset <- abs(Matrix::rsparsematrix(100, 100, .5))
#' dimred_landmark_mds(dataset, ndim = 3)
dimred_landmark_mds <- function(
  x,
  ndim = 2,
  distance_method,
  num_landmarks = 500
) {
  distance_method <- match.arg(distance_method)

  space <- lmds::lmds(
    x = x,
    ndim = ndim,
    distance_method = distance_method,
    num_landmarks = num_landmarks
  )

  .process_dimred(space)
}

formals(dimred_landmark_mds)$distance_method <- dynutils::list_distance_methods()

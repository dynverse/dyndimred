#' @importFrom lmds lmds
#' @rdname dimred
#' @export
dimred_landmark_mds <- function(
  x,
  ndim = 2,
  distance_method
) {
  distance_method <- match.arg(distance_method)

  space <- lmds::lmds(
    x = x,
    ndim = ndim,
    distance_method = distance_method
  )

  .process_dimred(space)
}

formals(dimred_landmark_mds)$distance_method <- dynutils::list_distance_methods()

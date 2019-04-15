#' Landmark MDS
#' @inheritParams dimred
#'
#' @param num_landmarks The number of landmarks to use,
#' @export
dimred_landmark_mds <- function(
  x,
  ndim = 2,
  distance_method,
  num_landmarks = 500
) {
  # select the landmarks
  lm_out <- .lmds_landmark_selection(
    x = x,
    distance_method = distance_method,
    landmark_method = "naive",
    num_landmarks = num_landmarks
  )

  # reduce dimensionality for landmarks and project to non-landmarks
  space <- .lmds_cmdscale(
    dist_lm = lm_out$dist_lm,
    dist_2lm = lm_out$dist_2lm,
    ndim = ndim,
    rescale = TRUE
  )

  .process_dimred(space)
}

formals(dimred_landmark_mds)$distance_method <- dynutils::list_distance_methods()


# Select landmarks
#
# @return A list with the following elements:
# \itemize{
#   \item{\code{ix_lm}: The incides of the selected landmarks}
#   \item{\code{dist_lm}: Pairwise distance matrix between the selected landmarks}
#   \item{\code{dist_2lm}: Distance matrix between the landmarks and all the samples in \code{x}}
# }
.lmds_landmark_selection <- function(x, distance_method, landmark_method = c("naive"), num_landmarks) {
  # parameter check on num_landmarks
  if (num_landmarks > nrow(x)) {
    num_landmarks <- nrow(x)
  }

  # naive -> just subsample the cell ids
  if (landmark_method == "naive") {
    ix_lm <- sample.int(nrow(x), num_landmarks)
    dist_2lm <- as.matrix(calculate_distance(x[ix_lm, , drop = FALSE], x, method = distance_method))
    dist_lm <- dist_2lm[, ix_lm, drop = FALSE]
  }

  list(
    ix_lm = ix_lm,
    dist_lm = dist_lm,
    dist_2lm = dist_2lm
  )
}

# Landmark MDS
#
# @param dist_lm Pairwise distance matrix between the selected landmarks
# @param dist_2lm Distance matrix between the landmarks and all the samples in original dataset
# @param ndim The number of dimensions
# @param rescale Whether or not to rescale the final dimensionality reduction (recommended)
# @param ... Extra params to pass to [irlba::partial_eigen()]
#
#' @importFrom irlba partial_eigen
#' @importFrom dynutils scale_uniform
.lmds_cmdscale <- function(dist_lm, dist_2lm, ndim = 3, rescale = TRUE, ...) {
  # short hand notations
  x <- dist_lm^2
  n <- as.integer(nrow(x))
  N <- as.integer(ncol(dist_2lm))

  # double center data
  mu_n <- rowMeans(x)
  mu <- mean(x)
  x_dc <-
    sweep(
      sweep(x, 1, mu_n, "-"),
      2, mu_n, "-"
    ) + mu

  # classical MDS on landmarks
  e <- irlba::partial_eigen(-x_dc / 2, symmetric = TRUE, n = ndim, ...)
  ev <- e$values
  evec <- e$vectors
  ndim1 <- sum(ev > 0)
  if (ndim1 < ndim) {
    warning(gettextf("only %d of the first %d eigenvalues are > 0", ndim1, ndim), domain = NA)
    evec <- evec[, ev > 0, drop = FALSE]
    ev <- ev[ev > 0]
    ndim <- ndim1
  }

  # distance-based triangulation
  points_inv <- evec / rep(sqrt(ev), each = n)
  S <- (-t(dist_2lm - rep(mu_n, each = N)) / 2) %*% points_inv

  # rescale if necessary
  if (rescale) {
    S <- dynutils::scale_uniform(S)
  }

  S
}

#' Landmark MDS
#' @inheritParams dimred
#'
#' @param distance_metric Which distance function to use. Must be one of: `"spearman"`, `"pearson"`, `"kendall"`, `"angular"`, `"euclidean"` or `"manhattan"`.
#' @param num_landmarks The number of landmarks to use,
#' @export
dimred_landmark_mds <- function(
  x,
  ndim = 2,
  distance_metric,
  num_landmarks = 500
) {
  distance_metric <- match.arg(distance_metric)

  # fetch distance function
  dist_fun <- dynutils::list_distance_metrics()[[distance_metric]]

  # select the landmarks
  lm_out <- .lmds_landmark_selection(
    x = x,
    dist_fun = dist_fun,
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
  attr(space, "landmark_space") <- NULL

  process_dimred(space)
}

formals(dimred_landmark_mds)$distance_metric <-
  c(
    "spearman",
    setdiff(names(dynutils::list_distance_metrics()), "spearman")
  )


# Select landmarks
#
# @return A list with the following elements:
# \itemize{
#   \item{\code{ix_lm}: The incides of the selected landmarks}
#   \item{\code{dist_lm}: Pairwise distance matrix between the selected landmarks}
#   \item{\code{dist_2lm}: Distance matrix between the landmarks and all the samples in \code{x}}
# }
.lmds_landmark_selection <- function(x, dist_fun, landmark_method = c("naive"), num_landmarks) {
  # parameter check on num_landmarks
  if (num_landmarks > nrow(x)) {
    num_landmarks <- nrow(x)
  }

  # naive -> just subsample the cell ids
  if (landmark_method == "naive") {
    ix_lm <- sample.int(nrow(x), num_landmarks)
    dist_lm <- dist_fun(x[ix_lm, , drop = FALSE], x[ix_lm, , drop = FALSE])
    dist_2lm <- dist_fun(x[ix_lm, , drop = FALSE], x)
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
#
# @importFrom irlba partial_eigen
# @importFrom dynutils scale_uniform
.lmds_cmdscale <- function(dist_lm, dist_2lm, ndim = 3, rescale = TRUE) {
  x <- as.matrix(dist_lm^2)
  storage.mode(x) <- "double"

  if (nrow(x) != ncol(x))
    stop("dist_lm must be a square matrix")

  # short hand notations
  x <- as.matrix(dist_lm^2)
  n <- as.integer(nrow(x))
  N <- as.integer(ncol(dist_2lm))

  # double center data
  mu_n <- rowMeans(x)
  mu <- mean(x)
  x_dc <- x - rep(mu_n, n) - rep(mu_n, each = n) + mu

  # classical MDS on landmarks
  e <- irlba::partial_eigen(-x_dc / 2, symmetric = TRUE, n = ndim)
  ev <- e$values
  evec <- e$vectors
  ndim1 <- sum(ev > 0)
  if (ndim1 < ndim) {
    warning(gettextf("only %d of the first %d eigenvalues are > 0", ndim1, ndim), domain = NA)
    evec <- evec[, ev > 0, drop = FALSE]
    ev <- ev[ev > 0]
    ndim <- ndim1
  }
  Slm <- evec * rep(sqrt(ev), each = n)

  # distance-based triangulation
  points_inv <- evec / rep(sqrt(ev), each = n)
  S <- (-t(dist_2lm - rep(mu_n, each = N)) / 2) %*% points_inv

  # set dimension names
  rn_lm <- rownames(dist_lm)
  rn_all <- colnames(dist_2lm)
  cn <- paste0("Comp", seq_len(ndim))
  dimnames(Slm) <- list(rn_lm, cn)
  dimnames(S) <- list(rn_all, cn)

  # rescale if necessary
  if (rescale) {
    Slm <- dynutils::scale_uniform(Slm)
    S <- dynutils::scale_uniform(S)
  }

  # output
  attr(S, "landmark_space") <- Slm

  S
}

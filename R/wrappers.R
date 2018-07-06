#' @rdname dimred
#' @export
list_dimred_methods <- function() {
  list(
    pca = dimred_pca,
    mds = dimred_mds,
    tsne = dimred_tsne,
    ica = dimred_ica,
    lle = dimred_lle,
    mds_sammon = dimred_mds_sammon,
    mds_isomds = dimred_mds_isomds,
    mds_smacof = dimred_mds_smacof,
    umap = dimred_umap
  )
}

#' Perform simple dimensionality reduction
#'
#' @param x Log transformed expression data, with rows as cells and columns as features
#' @param method The name of the dimensionality reduction method to use
#' @param ndim The number of dimensions
#' @param ... Any arguments to be passed to the dimensionality reduction method
#'
#' @export
dimred <- function(x, method, ndim, ...) {
  methods <- list_dimred_methods()
  if (method %in% names(methods)) {
    meth <- methods[[method]]
    params <- list(x = x, ndim = ndim, ...)
    do.call(meth, params)
  } else {
    stop("Method ", sQuote(method), " not found.")
  }
}

#' @rdname dimred
#' @export
dimred_pca <- function(x, ndim = 2) {
  space <- stats::prcomp(x)$x[,seq_len(ndim)]
  process_dimred(space)
}

#' @rdname dimred
#' @export
dimred_mds <- function(x, ndim = 2) {
  space <- stats::cmdscale(dynutils::correlation_distance(x), k = ndim)
  process_dimred(space)
}

#' @rdname dimred
#' @export
dimred_mds_sammon <- function(x, ndim = 2) {
  dynutils::install_packages(c("MASS"), "dyndimred")

  dist <- dynutils::correlation_distance(x)
  space <- MASS::sammon(dist, k = ndim)$points
  process_dimred(space)
}

#' @rdname dimred
#' @export
dimred_mds_isomds <- function(x, ndim = 2) {
  dynutils::install_packages(c("MASS"), "dyndimred")

  dist <- dynutils::correlation_distance(x)
  space <- MASS::isoMDS(dist, k = ndim)$points
  process_dimred(space)
}

#' @rdname dimred
#' @export
dimred_mds_smacof <- function(x, ndim = 2) {
  dynutils::install_packages(c("smacof"), "dyndimred")

  dist <- dynutils::correlation_distance(x)
  space <- smacof::mds(as.dist(dist), type = "ratio", ndim = ndim)$conf
  process_dimred(space)
}

#' Landmark MDS
#' @inheritParams SCORPIUS::reduce_dimensionality
#' @seealso [SCORPIUS::reduce_dimensionality()]
#' @export
dimred_landmark_mds <- function(x, ndim = 2, landmark_method = "naive", num_landmarks = 100, rescale = T) {
  dynutils::install_packages(c("SCORPIUS"), "dyndimred")

  requireNamespace("SCORPIUS")
  space <- SCORPIUS::reduce_dimensionality(
    x,
    dynutils::correlation_distance,
    num_landmarks = num_landmarks,
    ndim = ndim
  )

  process_dimred(space)
}

#' tSNE
#' @inheritParams Rtsne::Rtsne
#' @seealso [Rtsne::Rtsne()]
#' @export
dimred_tsne <- function(x, ndim = 2, perplexity = 30, theta = 0.5, initial_dims = 50) {
  dynutils::install_packages(c("Rtsne"), "dyndimred")

  requireNamespace("Rtsne")
  space <- Rtsne::Rtsne(
    as.dist(dynutils::correlation_distance(x)),
    dims = ndim,
    is_distance = TRUE,
    perplexity = perplexity,
    theta = theta,
    initial_dims = initial_dims
  )$Y
  rownames(space) = rownames(x)
  process_dimred(space)
}

#' @rdname dimred
#' @export
#'
#' @importFrom stats as.dist
dimred_dm_diffusionMap <- function(x, ndim = 2) {
  dynutils::install_packages(dependencies = "diffusionMap", package = "dyndimred")

  requireNamespace("diffusionMap")
  dist <- dynutils::correlation_distance(x)
  space <- diffusionMap::diffuse(stats::as.dist(dist), neigen = ndim, delta = 10e-5)$X
  process_dimred(space[,seq_len(ndim)], rownames(x))
}

#' @rdname dimred
#' @export
dimred_ica <- function(x, ndim = 3) {
  dynutils::install_packages(dependencies = "fastICA", package = "dyndimred")

  requireNamespace("fastICA")
  space <- fastICA::fastICA(t(scale(t(x))), ndim)$S
  process_dimred(space)
}

#' @rdname dimred
#' @export
dimred_lle <- function(x, ndim = 3) {
  dynutils::install_packages(dependencies = "lle", package = "dyndimred")

  requireNamespace("lle")
  k <- lle::calc_k(t(scale(t(x))), ndim)
  k <- k$k[which.min(k$rho)]
  space <- lle::lle(t(scale(t(x))), ndim, k)$Y
  process_dimred(space, rownames(x))
}

#' UMAP
#' @inheritParams uwot::umap
#' @seealso [uwot::umap()]
#' @export
dimred_umap <- function(x, ndim = 2, n_neighbors = 15L, alpha = 1, init = "spectral", n_threads = 1) {
  dynutils::install_packages(dependencies = "uwot", package = "dyndimred")

  requireNamespace("uwot")
  space <- uwot::umap(x, n_components = ndim, n_neighbors = n_neighbors, alpha = alpha, init = init, n_threads = n_threads)
  process_dimred(space, rownames(x))
}

process_dimred <- function(space, rn = rownames(space)) {
  space <- as.matrix(space)
  dimnames(space) <- list(rn, paste0("comp_", seq_len(ncol(space))))
  space
}

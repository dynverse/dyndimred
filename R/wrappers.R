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
#' @inheritParams umapr::umap
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
dimred_pca <- function(x, ndim = 3) {
  space <- stats::prcomp(x)$x[,seq_len(ndim)]
  process_dimred(space)
}

#' @rdname dimred
#' @export
dimred_mds <- function(x, ndim = 3) {
  space <- stats::cmdscale(dynutils::correlation_distance(x), k = ndim)
  process_dimred(space)
}

#' @rdname dimred
#' @export
dimred_mds_sammon <- function(x, ndim = 3) {
  dynutils::install_packages(c("MASS"), "dyndimred")

  dist <- dynutils::correlation_distance(x)
  space <- MASS::sammon(dist, k = ndim)$points
  process_dimred(space)
}

#' @rdname dimred
#' @export
dimred_mds_isomds <- function(x, ndim = 3) {
  dynutils::install_packages(c("MASS"), "dyndimred")

  dist <- dynutils::correlation_distance(x)
  space <- MASS::isoMDS(dist, k = ndim)$points
  process_dimred(space)
}

#' @rdname dimred
#' @export
dimred_mds_smacof <- function(x, ndim = 3) {
  dynutils::install_packages(c("smacof"), "dyndimred")

  dist <- dynutils::correlation_distance(x)
  space <- smacof::mds(as.dist(dist), type = "ratio", ndim = ndim)$conf
  process_dimred(space)
}

#' @rdname dimred
#' @export
dimred_tsne <- function(x, ndim = 3) {
  dynutils::install_packages(c("Rtsne"), "dyndimred")

  space <- Rtsne::Rtsne(as.dist(dynutils::correlation_distance(x)), dims = ndim, is_distance = TRUE, perplexity = 5)$Y
  rownames(space) = rownames(x)
  process_dimred(space)
}

#' @rdname dimred
#' @export
dimred_dp <- function(x, ndim = 3) {
  dynutils::install_packages(c("diffusionMap"), "dyndimred")

  space <- diffusionMap::diffuse(as.dist(dynutils::correlation_distance(x)), neigen = ndim, delta = 10e-5)
  rownames(space$X) <- rownames(x)
  process_dimred(space$X[,seq_len(ndim)])
}

#' @rdname dimred
#' @export
dimred_ica <- function(x, ndim = 3) {
  dynutils::install_packages(c("fastICA"), "dyndimred")

  space <- fastICA::fastICA(t(scale(t(x))), ndim)$S
  process_dimred(space)
}

#' @rdname dimred
#' @export
dimred_lle <- function(x, ndim = 3) {
  dynutils::install_packages(c("lle"), "dyndimred")

  k <- lle::calc_k(t(scale(t(x))), ndim)
  k <- k$k[which.min(k$rho)]
  space <- lle::lle(t(scale(t(x))), ndim, k)$Y
  rownames(space) <- rownames(x)
  process_dimred(space)
}

# previous umap wrapper
#' #' @rdname dimred
#' #' @export
#'
#' #' @inheritParams umapr::umap
#' dimred_umap <- function(x, ndim = 2, n_neighbors = 15L) {
#'
#'   dynutils::install_packages(dependencies = "umapr", package = "dyndimred")
#'
#'   space <- umapr::umap(x, n_neighbors = n_neighbors, n_components = ndim)
#'   space <- space[, (ncol(space)-ndim+1):ncol(space)]
#'
#'   process_dimred(space)
#' }


#' @rdname dimred
#' @export
dimred_umap <- function(x, ndim = 2, n_neighbors = 15L, alpha = 1, init = "spectral") {
  dynutils::install_packages(dependencies = "uwot", package = "dyndimred")

  space <- uwot::umap(x, n_components = ndim, n_neighbors = n_neighbors, alpha = alpha, init = init, n_threads = 1)
  rownames(space) <- rownames(x)
  process_dimred(space)
}

process_dimred <- function(space, rn = rownames(space)) {
  space <- as.matrix(space)
  dimnames(space) <- list(rn, paste0("comp_", seq_len(ncol(space))))
  space
}

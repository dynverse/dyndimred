#' @rdname dimred
#' @importFrom irlba prcomp_irlba
#' @export
dimred_pca <- function(x, ndim = 2) {
  space <- irlba::prcomp_irlba(x, n = ndim)$x

  # pca <- irlba::irlba(x, nv = ndim)
  # space <- pca$u
  # rownames(pca) <- rownames(x)
  # colnames(pca) <- paste0("comp_", seq_len(ncol(pca)))

  .process_dimred(space, rn = rownames(x))
}

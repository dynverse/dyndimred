# #' @rdname dimred
# #' @export
# dimred_dm_destiny <- function(x, ndim = 2, distance_method = c("euclidean", "spearman", "cosine")) {
#   requireNamespace("destiny")
#
#   if (is_sparse(x)) {
#     x <- as.matrix(x)
#   }
#
#   distance_method<- match.arg(distance_method)
#   distance <- c(euclidean = "euclidean", cosine = "cosine", spearman = "rankcor")[distance_method]
#
#   dm <- destiny::DiffusionMap(
#     data = x,
#     n_eigs = ndim,
#     distance = distance
#   )
#
#   .process_dimred(dm@eigenvectors[,seq_len(ndim)], rownames(x))
# }

#' @rdname dimred
#' @export
dimred_dm_destiny <- function(x, ndim = 2, distance_method = c("euclidean", "spearman", "cosine")) {
  .Defunct(new = "dimred_dm_diffusionmap")
}

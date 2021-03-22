#' @importFrom tibble tribble
dr_methods <- tibble::tribble(
  ~name, ~fun, ~requires,
  # "dm_destiny", dimred_dm_destiny, "destiny",
  "dm_diffusionMap", dimred_dm_diffusionmap, "diffusionMap",
  "ica", dimred_ica, "fastICA",
  "knn_fr", dimred_knn_fr, c("igraph", "RANN"),
  "landmark_mds", dimred_landmark_mds, "lmds",
  "lle", dimred_lle, "lle",
  "mds_isomds", dimred_mds_isomds, "MASS",
  "mds_sammon", dimred_mds_sammon, "MASS",
  "mds_smacof", dimred_mds_smacof, "smacof",
  "pca", dimred_pca, "irlba",
  "tsne", dimred_tsne, "Rtsne",
  "umap", dimred_umap, "uwot"

)

#' @rdname dimred
#' @importFrom stats setNames
#' @export
list_dimred_methods <- function() {
  stats::setNames(dr_methods$fun, dr_methods$name)
}

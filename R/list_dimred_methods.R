#' @rdname dimred
#' @export
list_dimred_methods <- function() {
  list(
    pca = dimred_pca,
    mds = dimred_mds,
    tsne = dimred_tsne,
    ica = dimred_ica,
    lle = dimred_lle,
    landmark_mds = dimred_landmark_mds,
    mds_sammon = dimred_mds_sammon,
    mds_isomds = dimred_mds_isomds,
    mds_smacof = dimred_mds_smacof,
    umap = dimred_umap,
    dm_diffusionmap = dimred_dm_diffusionmap,
    dm_destiny = dimred_dm_destiny
  )
}

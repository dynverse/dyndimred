process_dimred <- function(space, rn = rownames(space)) {
  space <- as.matrix(space)
  dimnames(space) <- list(rn, paste0("comp_", seq_len(ncol(space))))
  space
}

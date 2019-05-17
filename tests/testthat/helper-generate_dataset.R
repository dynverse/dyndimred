
generate_dataset <- function(type = c("splines", "polynomial"), num_samples = 100, num_genes = 100) {
  type <- match.arg(type)
  x <- seq(-1, 1, length.out = num_samples)
  switch(
    type,
    "polynomial"={
      y <- stats::poly(x, 2)
      sd <- .012 * sqrt(num_genes)
    },
    "splines"={
      y <- splines::ns(x, df=3)
      sd <- .06 * sqrt(num_genes)
    })
  expression <- sapply(seq_len(num_genes), function(g) {
    scale <- stats::rnorm(ncol(y), mean=0, sd=1)
    noise <- stats::rnorm(length(x), sd=sd)
    rowSums(sweep(y, 2, scale, "*")) + noise
  })
  weighted_random_sample <- function(data, weights, n){
    key <- stats::runif(length(data)) ^ (1 / weights)
    data[order(key, decreasing=TRUE)][seq_len(n)]
  }
  undetectable <- which(expression < 0)
  undetectable <- weighted_random_sample(undetectable, -expression[undetectable], round(length(undetectable)*.5))

  expression <- expression + .5
  expression[expression < 0 | seq_along(expression) %in% undetectable] <- 0

  dimnames(expression) <- list(paste0("sample", seq_len(num_samples)), paste0("feature", seq_len(num_genes)))
  expression
}

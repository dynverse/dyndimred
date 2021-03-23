# dyndimred 1.0.4

* MAJOR CHANGES: Changed maintainer to avoid frequent archivings.

* DEFUNCT `dimred_dm_destiny()`: Marked this function as defunct as destiny is currently not on CRAN anymore.

* MINOR CHANGES: Running unit tests requiring suggested packages is now conditional on its availability.

* MINOR CHANGES: Remove usage of`dynutils::install_packages()`.

# dyndimred 1.0.3 (08-03-2020)

* MINOR CHANGES: The code for landmark mds has been moved to its own separate package, `lmds`.

* MINOR CHANGES: Change license to MIT.

* MINOR CHANGES: Fix `dynutils::install_packages()` such that it prompts the user whether or
  not to install packages when in interactive mode, and simply returns an error
  when not in interactive mode.

# dyndimred 1.0.2 (08-07-2019)

* MINOR CHANGES: Move Matrix to Suggests.

# dyndimred 1.0.1 (02-05-2019)

* MINOR CHANGES: dyndimred works with sparse (distance) matrices when appropriate through dynutils.

# dyndimred 1.0.0 (29-03-2019)

* Initial release of dyndimred, includes tsne, umap, lle, pca, diffusion map, mds, landmark mds.

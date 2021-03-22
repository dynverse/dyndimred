# dyndimred 1.0.4

* MINOR CHANGES: Check package is installed before running unit tests.

* MINOR CHANGES: Remove `dynutils::install_packages()`.

# dyndimred 1.0.3

* MINOR CHANGES: The code for landmark mds has been moved to its own separate package, `lmds`.

* MINOR CHANGES: Change license to MIT.

* MINOR CHANGES: Fix `dynutils::install_packages()` such that it prompts the user whether or
  not to install packages when in interactive mode, and simply returns an error
  when not in interactive mode.

# dyndimred 1.0.2 (07-08-2018)

* MINOR CHANGES: Move Matrix to Suggests.

# dyndimred 1.0.1 (02-05-2019)

* MINOR CHANGES: dyndimred works with sparse (distance) matrices when appropriate through dynutils.

# dyndimred 1.0.0 (29-03-2019)

* Initial release of dyndimred, includes tsne, umap, lle, pca, diffusion map, mds, landmark mds

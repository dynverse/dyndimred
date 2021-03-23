# dyndimred 1.0.4

* MAJOR CHANGES: Changed maintainer to avoid frequent archivings.

* DEFUNCT `dimred_dm_destiny()`: Marked this function as defunct as destiny is currently not on CRAN anymore.

* MINOR CHANGES: Running unit tests requiring suggested packages is now conditional on its availability.

* MINOR CHANGES: Remove usage of`dynutils::install_packages()`.

# Test environments

* local Fedora installation, R 4.0.3
* ubuntu 20.04, mac os x, windows (on github actions), R 4.0

## R CMD check results
```
── R CMD check results ──────────────────────────────────── dyndimred 1.0.4 ────
Duration: 1m 36.8s

0 errors ✓ | 0 warnings ✓ | 0 notes ✓

R CMD check succeeded
```


## Reverse dependencies

Can't run revdepcheck as dyndimred is not on CRAN.

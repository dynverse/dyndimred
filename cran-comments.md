Fixed check errors. Packages are not automatically installed unless user
is in interactive mode and responds affirmatively to the displayed prompts.

Function also respects the users' choice of CRAN mirror.

# dyndimred 1.0.3

* MINOR CHANGES: The code for landmark mds has been moved to its own separate package, `lmds`.

* MINOR CHANGES: Change license to MIT.

* MINOR CHANGES: Fix `dynutils::install_packages()` such that it prompts the user whether or
  not to install packages when in interactive mode, and simply returns an error
  when not in interactive mode.

# Test environments

* local Fedora 31 installation, R 3.6.2
* ubuntu 16.04.5 LTS (on travis-ci), R 3.6.0
* win-builder (devel and release)


## R CMD check results
```
── R CMD check results ──────────────────────────────────── dyndimred 1.0.4 ────
Duration: 1m 53.4s

0 errors ✓ | 0 warnings ✓ | 0 notes ✓

R CMD check succeeded
```


## Reverse dependencies

A reverse dependency check was run on all downstream dependencies.
(Summary at [revdep/README.md](revdep/README.md)). No new problems were found.

```
> revdepcheck::revdep_check(timeout = as.difftime(60, units = "mins"), num_workers = 30)
── INSTALL ─────────────────────────────── 2 versions ──
Installing CRAN version of dyndimred
Installing DEV version of dyndimred
── CHECK ─────────────────────────────── 1 packages ──
✓ dynwrap 1.1.4                          ── E: 0     | W: 0     | N: 1                                                                                                               
OK: 1                                                                                                                                                                              
BROKEN: 0
Total time: 13 min
── REPORT ─────────────────────────────── 
Writing summary to 'revdep/README.md'
Writing problems to 'revdep/problems.md'
Writing failures to 'revdep/failures.md'
```

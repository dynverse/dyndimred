# dyndimred 1.0.3
  
* Change license to MIT.

* Fix dynutils::install_packages() such that it prompts the user whether or
  not to install packages when in interactive mode, and simply returns an error
  when not in interactive mode.
  
# dyndimred 1.0.2

Minor changes to the DESCRIPTION.

# Test environments

* local Fedora 30 installation, R 3.6.0
* ubuntu 16.04.5 LTS (on travis-ci), R 3.6.0
* win-builder (devel and release)

# R CMD check results

── R CMD check results ──────────────────────────────────────────────────────────────────────────────────── dyndimred 1.0.1 ────
Duration: 4m 23.6s

0 errors ✔ | 0 warnings ✔ | 0 notes ✔

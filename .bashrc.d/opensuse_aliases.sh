# zypper aliases
alias refresh='sudo zypper ref'                          # refresh repositories
alias upgrade='sudo zypper dup --allow-vendor-change'   # upgrade OpenSUSE Tumbleweed
alias install='sudo zypper in'                          # install a package
alias remove='sudo zypper rm --clean-deps'              # remove a package and unneeded dependencies
alias search='sudo zypper se'                           # search for package
alias info='sudo zypper if'                             # view package information
alias list='sudo zypper search -i'                      # list installed packages
alias orphans='sudo zypper packages --orphaned'         # list all orphaned packages
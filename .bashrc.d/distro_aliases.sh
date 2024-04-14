# Distro specific aliases
# Uncomment for your specific distro

#######################
# Arch
#######################

# pacman
alias refresh='sudo pacman -Syy'                            # refresh repositories
alias upgrade='sudo pacman -Syu'                            # update system
alias install='sudo pacman -Syu'                            # install
alias search='sudo pacman -Ss'                              # search
alias searchins='sudo pacman -Qs'                           # search installed packages
alias remove='sudo pacman -Rns'                             # remove the package, avoid orphaned dependencies and erase its global configuration
alias info='sudo pacman -Qi'                                # view package information
alias list='sudo pacman -Qet'                               # list packages that you explicitly installed and that aren’t dependencies of some other package.
alias orphans='sudo pacman -Qdtq'                           # list orphaned packages
alias removeorphans='sudo pacman -Qdtq | pacman -Rns -'     # remove orphaned packages
alias pac-clean-cache='pacman -Scc'                         # clean cache

# yay
alias yinstall='yay -S'                                     # yay install
alias ysearch='yay -Ss'                                     # yay search

# Update mirrors
alias mirrors='sudo reflector --country Sweden --age 24 --sort rate --protocol https --save /etc/pacman.d/mirrorlist --verbose'

#######################
# openSUSE Tumbleweed
#######################

# zypper
# alias refresh='sudo zypper ref'                         # refresh repositories
# alias upgrade='sudo zypper dup --allow-vendor-change'   # upgrade OpenSUSE Tumbleweed
# alias install='sudo zypper in'                          # install a package
# alias remove='sudo zypper rm --clean-deps'              # remove a package and unneeded dependencies
# alias search='sudo zypper se'                           # search for package
# alias info='sudo zypper if'                             # view package information
# alias list='sudo zypper search -i'                      # list installed packages
# alias orphans='sudo zypper packages --orphaned'         # list all orphaned packages

#######################
# Fedora
#######################

# dnf
# alias updates='sudo dnf check-update'                   # check for available package updates
# alias upgrade='sudo dnf upgrade'                        # upgrade system
# alias install='sudo dnf install'                        # install a package
# alias remove='sudo dnf remove'                          # remove a package
# alias search='sudo dnf search'                          # search for package
# alias clean='sudo dnf clean all'                        # clean system
# alias info='sudo dnf info'                              # view package information
# alias list='sudo dnf list installed'                    # list installed packages
alias lt='ls --human-readable --size -1 -S --classify --group-directories-first'    # sort files by file size
alias ls='ls --color=auto'                                                          # list with colored output
alias la='ls -A'                                                                    # list all files including hidden files
alias ll='ls -l'                                                                    # list with long format - show permissions
alias lla='ll -A'                                                                   # list all files including hidden files with long format - show permissions
alias sl='ln -s '                                                                   # create symlink | /sourcepath /destinationpath
alias cpv='rsync -ah --info=progress2'                                              # copy with progress bar
alias md='make_cd'                                                                # create a directory and all parent directories with verbosity
alias rd='rm -rf'                                                                   # remove a directory with all its contents (including all interior directories)
alias .='cd ..'                                                                     # go up one directory
alias ..='cd ../..'                                                                 # go up two directories
alias ...='cd ../../..'                                                             # go up three directories
alias tarc='tar -tvf'                                                               # view .tar content
alias nano='sudo nano'                                                              # open file with nano
alias vim='sudo vim'                                                                # open file with vim
alias count='find . -type f | wc -l'                                                # count number of files in directory
alias h='history'                                                                   # view the bash history
alias exe='chmod +x'                                                                # make script file executable
alias grep='grep --color=auto'                                                      # grep with colored output
alias wget='wget -c'                                                                # wget with continue

alias activeservices='sudo systemctl list-units --type=service'                     # list active (running and exited) services
alias allservices='sudo systemctl list-units --type=service'                        # list all services (active and inactive)
alias runningservices='sudo systemctl list-units --type=service'                    # list only running services

alias myip='curl ipinfo.io/ip'                                                      # show public IP
alias openports='netstat -tulanp'                                                   # show open ports
alias now='date +"%Y-%m-%d" && date +"%T"'                                          # date and time
alias x='exit'                                                                      # exit
alias bye='exit'                                                                    # exit
alias c='clear'                                                                     # clear console
alias reboot='sudo reboot'                                                          # reboot
alias shutdown='sudo shutdown -h now'                                               # shutdown straight away
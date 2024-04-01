# Sample .bashrc for SUSE Linux
# Copyright (c) SUSE Software Solutions Germany GmbH

# There are 3 different types of shells in bash: the login shell, normal shell
# and interactive shell. Login shells read ~/.profile and interactive shells
# read ~/.bashrc; in our setup, /etc/profile sources ~/.bashrc - thus all
# settings made here will also take effect in a login shell.
#
# NOTE: It is recommended to make language settings in ~/.profile rather than
# here, since multilingual X sessions would not work properly if LANG is over-
# ridden in every subshell.

export PS1="\w\n   " ## requires a nerd font to display correctly

test -s ~/.alias && . ~/.alias || true

# Load user specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for sh in ~/.bashrc.d/*; do
		if [ -f "$sh" ]; then
			. "$sh"
		fi
	done
fi
unset sh

fastfetch

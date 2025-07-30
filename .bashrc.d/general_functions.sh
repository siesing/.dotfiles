#!/usr/bin/env bash
# -----------------------------------------------------------------------------
# Helper functions for interactive Bash use (Linux only)
#
# Goals: Security (--), robust quoting, performance, clear error handling,
# and a strict "no eval" policy.
# -----------------------------------------------------------------------------

# Enable strict mode – abort on errors & undefined vars, safer word-splitting
set -euo pipefail
IFS=$'\n\t'

# --- Internal helpers --------------------------------------------------------
_warn() { printf 'bash-helpers: %s: %s\n' "$1" "$2" >&2; }
# _die now handles the return status entirely.
_die()  { printf 'bash-helpers: %s: %s\n' "$1" "$2" >&2; return 1; }

# cl  —  Change directory, list contents, and show file/dir count
# Usage: cl [dir]
cl() {
    local -r dir="${1:-$PWD}"

    # EAFP Principle: Attempt the action first, then handle exceptions.
    if ! builtin cd -P -- "$dir"; then
        # If cd fails, now we diagnose the reason for a better error message.
        if [[ ! -e $dir ]]; then
            _die "cl" "'$dir' does not exist"
        elif [[ ! -d $dir ]]; then
            _die "cl" "'$dir' is not a directory"
        elif [[ ! -x $dir ]]; then
            _die "cl" "permission denied: '$dir'"
        else
            _die "cl" "failed to cd into '$dir' for an unknown reason"
        fi
        return 1
    fi

    if [[ ! -r . ]]; then
        _warn "cl" "cannot read directory contents (permission denied)"
        return 0
    fi

    # List contents. Flags like --group-directories-first are GNU-specific.
    if command -v eza >/dev/null 2>&1; then
        eza -lag --group-directories-first --time-style=long-iso || _warn "cl" "listing failed"
    elif command -v exa >/dev/null 2>&1; then
        exa -lag --group-directories-first --time-style=long-iso || _warn "cl" "listing failed"
    else
        command ls -Alh --group-directories-first --time-style="+%Y-%m-%d %H:%M" --color=auto || _warn "cl" "listing failed"
    fi

    # Count files & directories using find for performance
    (
        local -i num_dirs=0 num_files=0

        if find . -maxdepth 1 -printf '' 2>/dev/null; then   # GNU/BSD-find detected
            num_dirs=$(find . -mindepth 1 -maxdepth 1 -type d -print0 | grep -cz . || true)
            num_files=$(find . -mindepth 1 -maxdepth 1 ! -type d -print0 | grep -cz . || true)
        else
            # BusyBox or ancient find – fall back to the old glob method
            local f
            shopt -s nullglob dotglob
            for f in * .[!.]* ..?*; do
                [[ -d $f ]] && ((num_dirs++)) || ((num_files++))
            done
        fi
        printf '(%d dir(s), %d file(s))\n' "$num_dirs" "$num_files"
    )
}

# mkcd  —  Create directory (including parents) and cd into it
# Usage: mkcd <directory>
mkcd() {
    if (( $# != 1 )); then
        printf 'Usage: mkcd <directory>\n' >&2
        return 2
    fi
    local -r dir="$1"

    if [[ -e $dir && ! -d $dir ]]; then
        _die "mkcd" "'$dir' exists and is not a directory"
    fi

    if ! mkdir -p -- "$dir"; then
        _die "mkcd" "mkdir failed for '$dir'"
    fi

    if ! builtin cd -P -- "$dir"; then
        # If cd fails after a successful mkdir, attempt to clean up the directory.
        # 'rmdir' is safe as it only removes empty directories.
        # A warning is only shown if the cleanup itself fails.
        rmdir -- "$dir" 2>/dev/null || _warn "mkcd" "Leftover directory: '$dir' could not be removed."
        _die "mkcd" "Failed to cd into '$dir' after creation"
    fi
}

# bak  —  Create backup: file -> file.bak, or file.bak.N on collision
# Usage: bak <file>
bak() {
    # --- argument‑ and in-data‑checks ------------------------------------
    if (( $# != 1 )); then
        printf 'Usage: bak <file>\n' >&2
        return 2
    fi

    local -r src=$1
    [[ -f $src        ]] || _die "bak" "'$src' is not a regular file"
    [[ -r $src        ]] || _die "bak" "cannot read '$src'"
    [[ ! -L $src.bak  ]] || _die "bak" "refusing to overwrite a symlink"

    # --- hardening against TOCTOU / permissions
    umask 077          # private permissions on the temp­/backup file
    set -o noclobber   # mv -n and ln -T gets error if target already exists
    trap '[[ -n ${tmp:-} && -e $tmp ]] && rm -f -- "$tmp"' INT TERM EXIT

    local -r base="$src.bak"
    local tmp dst
    tmp=$(mktemp -- "${base}.XXXXXX") || _die "bak" "mktemp failed"
    cp -a -- "$src" "$tmp"            || _die "bak" "copy failed"

    local -i i=0
    while :; do
        dst=$base${i:+.$i}
        
        if ln -T -- "$tmp" "$dst" 2>/dev/null; then
            break
        fi
        ((i++))
    done

    trap - INT TERM EXIT
    printf 'Created %s\n' "$dst"
}


# ch  —  Search command history (literal match, robust against options)
# Usage: ch <pattern>
ch() {
    if (( $# == 0 )); then
        printf 'Usage: ch <pattern>\n' >&2
        return 2
    fi
    local -r pattern="$1"

    if ! builtin fc -l 1 | grep -F -- "$pattern"; then
        if (( $? == 1 )); then
            _warn "ch" "no matches for '$pattern'"
        else
            _die "ch" "history search failed"
        fi
        return 1
    fi
}
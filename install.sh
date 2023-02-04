#!/usr/bin/env bash

which git &> /dev/null || {
    echo 'Please install git.' >&2
    exit 1
}

readonly DOT_DIR="$HOME/.dotfiles"
readonly GIT_REPO='https://github.com/CRaLFa/dotfiles.git'

main () {
    [ -d "$DOT_DIR" ] && {
        cd "$HOME"
        rm -rf "$DOT_DIR"
    }

    git clone "$GIT_REPO" "$DOT_DIR" || {
        echo 'Failed to clone repository.' >&2
        return 1
    }

    for f in $(find "$DOT_DIR" -maxdepth 1 -type f -name '.*')
    do
        ln -sfv "$f" "$HOME/$(basename "$f")"
    done
}

main

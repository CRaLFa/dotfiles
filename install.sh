#!/usr/bin/env bash

DOT_DIR="$HOME/.dotfiles"
GIT_URL='https://github.com/CRaLFa/dotfiles.git'

which git > /dev/null 2>&1 || {
    echo 'Please install git.' >&2
    exit 1
}

if [ -d $DOT_DIR ]; then
    read -p 'Overwrite ~/.dotfiles directory? (y/n)' REPLY
    if [[ "$REPLY" == "y" ]]; then
        rm -rf $DOT_DIR && git clone $GIT_URL $DOT_DIR || exit $?
    else
        exit 0
    fi
else
    git clone $GIT_URL $DOT_DIR || exit $?
fi

cd $DOT_DIR

for f in .??*
do
    [[ "$f" == '.git' ]] && continue
    ln -snfv "$DOT_DIR/$f" "$HOME/$f"
done

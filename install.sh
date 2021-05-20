#!/usr/bin/env bash

DOT_DIR="$HOME/.dotfiles"
GIT_REPO='https://github.com/CRaLFa/dotfiles.git'

which git &> /dev/null || {
    echo 'Please install git.' >&2
    exit 1
}

if [ -d $DOT_DIR ]; then
    cd $HOME
    rm -rf $DOT_DIR
fi

git clone $GIT_REPO $DOT_DIR || exit $?
cd $DOT_DIR

for f in .??*
do
    [[ "$f" == '.git' ]] && continue
    ln -sfv "$DOT_DIR/$f" "$HOME/$f"
done

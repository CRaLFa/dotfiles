#!/usr/bin/env bash

readonly DOT_DIR="$HOME/.dotfiles"
readonly GIT_REPO='https://github.com/CRaLFa/dotfiles.git'

main () {
	which git &> /dev/null || {
		echo 'Please install git.' >&2
		return 1
	}

	# 既存のクローンは消さずに更新し、未コミットの変更やシンボリックリンクを壊さない
	if [ -d "$DOT_DIR" ]; then
		git -C "$DOT_DIR" pull --ff-only
	else
		git clone "$GIT_REPO" "$DOT_DIR"
	fi || {
		echo 'Failed to update repository.' >&2
		return 1
	}

	for f in "$DOT_DIR"/.[!.]*
	do
		[ -f "$f" ] && ln -sfv "$f" "$HOME/${f##*/}"
	done
}

main

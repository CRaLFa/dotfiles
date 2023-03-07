[ -f ~/.git-prompt.sh ] && . ~/.git-prompt.sh
[ -f ~/.bashrc ] && . ~/.bashrc

umask 022

export PS1='\n\[\e[32m\]\u@\h \[\e[35m\]\s \[\e[33m\]\w\[\e[36m\]$(__git_ps1) \[\e[0m\][$(date "+%Y/%m/%d %H:%M:%S")]\n$ '
export PS3='Please input NUMBER. > '
export LANG='ja_JP.UTF-8'
export EDITOR='/usr/bin/vim'
export GOPATH="$HOME/go"
export TEXTIMG_EMOJI_DIR='/usr/local/src/noto-emoji/png/512'
export DENO_INSTALL="$HOME/.deno"

PATH="$HOME/.nodebrew/current/bin:$PATH"
PATH="$GOPATH/bin:$PATH"
PATH="$HOME/.cargo/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"
PATH="$DENO_INSTALL/bin:$PATH"
PATH="/usr/local/zig:$PATH"
export PATH

export SDKMAN_DIR="$HOME/.sdkman"
[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ] && . "$HOME/.sdkman/bin/sdkman-init.sh"

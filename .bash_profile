[ -f ~/.git-prompt.sh ] && . ~/.git-prompt.sh
[ -f ~/.bashrc ] && . ~/.bashrc

umask 022

export PS1='\n\[\e[32m\]\u@\h \[\e[35m\]\s \[\e[33m\]\w\[\e[36m\]$(__git_ps1) \[\e[0m\][$(date "+%Y/%m/%d %H:%M:%S")]\n$ '
export PS3='Please input NUMBER. > '
export LANG='ja_JP.UTF-8'
export EDITOR='/usr/bin/vim'
export GOPATH="$HOME/go"
export TEXTIMG_FONT_FILE='/usr/share/fonts/truetype/noto/NotoSansMono-Regular.ttf'
export TEXTIMG_EMOJI_DIR='/usr/share/fonts/noto-emoji/png/512'
export DENO_INSTALL="$HOME/.deno"
export SDKMAN_DIR="$HOME/.sdkman"
export JAVA_HOME="$SDKMAN_DIR/candidates/java/current"
export ANDROID_HOME='/usr/local/android/sdk'

PATH="$HOME/.nodebrew/current/bin:$PATH"
PATH="$GOPATH/bin:$PATH"
PATH="$HOME/.cargo/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"
PATH="$DENO_INSTALL/bin:$PATH"
PATH="/usr/local/zig:$PATH"
PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
PATH="$ANDROID_HOME/platform-tools:$PATH"
PATH="/usr/local/flutter/bin:$PATH"
export PATH

[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ] && . "$SDKMAN_DIR/bin/sdkman-init.sh"

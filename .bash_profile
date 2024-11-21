[ -s "$HOME/.git-prompt.sh" ] && . "$HOME/.git-prompt.sh"
[ -s "$HOME/.bashrc" ] && . "$HOME/.bashrc"

umask 022

export PS1='\n\[\e[32m\]\u@\h \[\e[35m\]\s \[\e[33m\]\w\[\e[36m\]$(__git_ps1) \[\e[0m\][$(date "+%Y/%m/%d %H:%M:%S")]\n$ '
export PS3='Please input NUMBER. > '
export LANG='ja_JP.UTF-8'
export EDITOR='/usr/bin/vim'
export GOPATH="$HOME/go"
export TEXTIMG_FONT_FILE='/usr/share/fonts/opentype/noto/NotoSansCJK-Regular.ttc'
export TEXTIMG_EMOJI_DIR='/usr/share/fonts/noto-emoji/png/512'
export DENO_INSTALL="$HOME/.deno"
export SDKMAN_DIR="$HOME/.sdkman"
export JAVA_HOME="$SDKMAN_DIR/candidates/java/current"
export ANDROID_HOME='/usr/local/android/sdk'
export DPRINT_INSTALL="$HOME/.dprint"
export BUN_INSTALL="$HOME/.bun"

PATH="$HOME/.nodebrew/current/bin:$PATH"
PATH="$GOPATH/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"
PATH="$DENO_INSTALL/bin:$PATH"
PATH="/usr/local/zig:$PATH"
PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
PATH="$ANDROID_HOME/platform-tools:$PATH"
PATH="/usr/local/flutter/bin:$PATH"
PATH="$DPRINT_INSTALL/bin:$PATH"
PATH="$BUN_INSTALL/bin:$PATH"
export PATH

[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ] && . "$SDKMAN_DIR/bin/sdkman-init.sh"
[ -s "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

[ -f '/usr/local/lib/libstderred.so' ] && {
	export LD_PRELOAD="/usr/local/lib/libstderred.so${LD_PRELOAD:+:$LD_PRELOAD}"
	export STDERRED_ESC_CODE="$(tput setaf 224)"
}

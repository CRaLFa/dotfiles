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
export VOLTA_HOME="$HOME/.volta"
export WASMTIME_HOME="$HOME/.wasmtime"
export NODE_OPTIONS='--no-deprecation'

PATH="$GOPATH/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"
PATH="$DENO_INSTALL/bin:$PATH"
PATH="/usr/local/zig:$PATH"
PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
PATH="$ANDROID_HOME/platform-tools:$PATH"
PATH="/usr/local/flutter/bin:$PATH"
PATH="$DPRINT_INSTALL/bin:$PATH"
PATH="$BUN_INSTALL/bin:$PATH"
PATH="$VOLTA_HOME/bin:$PATH"
PATH="$WASMTIME_HOME/bin:$PATH"
export PATH

[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ] && . "$SDKMAN_DIR/bin/sdkman-init.sh"
[ -s "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
[ -s "$HOME/.local/share/swiftly/env.sh" ] && . "$HOME/.local/share/swiftly/env.sh"
# Vite+ は既存の ~/.vite-plus があればそれを再利用し、無ければ XDG 準拠の分割レイアウトに入る。
[ -s "$HOME/.vite-plus/env" ] && . "$HOME/.vite-plus/env"
[ -s "${XDG_CONFIG_HOME:-$HOME/.config}/vite-plus/env" ] && . "${XDG_CONFIG_HOME:-$HOME/.config}/vite-plus/env"
[ -s "$HOME/.atuin/bin/env" ] && . "$HOME/.atuin/bin/env"

[ -f '/usr/local/lib/libstderred.so' ] && {
	export LD_PRELOAD="/usr/local/lib/libstderred.so${LD_PRELOAD:+:$LD_PRELOAD}"
	export STDERRED_ESC_CODE="$(tput setaf 224)"
}

# 対話シェル向けの設定は PATH 確定後に読み込む
[ -s "$HOME/.bashrc" ] && . "$HOME/.bashrc"

umask 0022

# 対話シェルでなければ何もしない
case $- in
	*i*) ;;
	  *) return;;
esac

shopt -s autocd
shopt -s cdspell
shopt -s checkwinsize
shopt -s dotglob
shopt -s globstar
shopt -s histappend
# shopt -s nullglob

# 履歴に重複行と空白で始まる行を残さない
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

# プロンプト
[ -s "$HOME/.git-prompt.sh" ] && . "$HOME/.git-prompt.sh"
PS1='\n\[\e[32m\]\u@\h \[\e[35m\]\s \[\e[33m\]\w\[\e[36m\]$(__git_ps1) \[\e[0m\][$(date "+%Y/%m/%d %H:%M:%S")]\n$ '
PS3='Please input NUMBER > '

alias cdg='cd "$(git rev-parse --show-toplevel)"'
alias clock='watch -n 1 "date +\"%Y/%m/%dT%H:%M:%S\" | tr "T" "\\\\n" | figlet -f big"'
alias funcs='type $(grep -Pho "^\s*\w+(?= \(\))" ~/.bashrc ~/.bashrc.local 2> /dev/null)'
alias hr='yes "#" | head -n $(tput cols) | paste -sd ""'
alias ins='sudo apt -y install'
alias insed='apt list --installed 2> /dev/null | grep -v "自動" | cut -d "/" -f 1'
alias ipv4='ip -4 -o addr show eth0 | grep -Po "inet \K[\d.]+"'
alias less='less -ix 4'
alias ll.='ll -d .??*'
alias ll='ls -lh'
alias lla='ll -A'
alias ls='ls -F --color=auto'
alias reload='exec bash -l'
alias tree='eza -Ta --git-ignore'
alias update='sudo apt update && sudo apt -y upgrade && sudo apt -y autoremove'
alias vibp='vi ~/.bash_profile'
alias vibr='vi ~/.bashrc'
alias vig='vi ~/.gitconfig'
alias viv='vi ~/.vimrc'

md () {
	mkdir -p "${1:?usage: md DIR}" && cd "$_"
}

rd () {
	local dir=${1:?usage: rd DIR}
	[ -d "$dir" ] || {
		echo "Error: Directory '$dir' doesn't exist." >&2
		return 1
	}
	local s=''
	[ -w "$dir" ] || s='sudo'
	$s rmdir "$dir" 2> /dev/null || {
		read -rp "Remove non-empty directory '$dir' ? [y/N]: " answer
		[ "$answer" = 'y' ] && $s rm -rf "$dir"
	}
}

mt () {
	local f=${1:?usage: mt FILE} d
	d=$(dirname "$f")
	[ -d "$d" ] || mkdir -p "$d" || {
		echo 'Failed to make directory.' >&2
		return 1
	}
	touch "$f"
}

repeat () {
	local s=${1:?usage: repeat STR N} n=${2:?usage: repeat STR N}
	yes "$s" | head -n "$n" | paste -sd ''
}

bcrypt () {
	local pw=${1:?usage: bcrypt PASSWORD}
	htpasswd -nbB '' "$pw" | cut -d : -f 2 | tr -d '\n'
}

format_number () {
	perl -pe 's/\d(?=(\d{3})+$)/$&,/g' <<< "${1:?usage: format_number N}"
}

ccount () {
	local s=${1:-$(cat)}
	echo -n "$s" | wc -c
}

ex_norm () {
	ex -s +"norm! $*" +'%|q!' /dev/stdin
}

commands () {
	local pkg=${1:?usage: commands APT_PACKAGE_NAME}
	local bins
	mapfile -t bins < <(dpkg -L "$pkg" | grep -P '(/usr)*/(s?bin|games)/')
	(( ${#bins[@]} )) && printf '%s\n' "${bins[@]##*/}" | sort -u
}

get_certificate () {
	local host=${1:?usage: get_certificate HOST}
	openssl s_client -connect "${host}:443" < /dev/null 2> /dev/null | openssl x509 -text -noout
}

rand () {
	local -i num=$1
	echo $(( num == 0 ? RANDOM : RANDOM % num ))
}

kaomoji () {
	echo -e "$(printf '\\U1F6%02X' {0..79})"
}

emoji () {
	echo -e "$(printf '\\U1F%3X' {768..1535})"
}

unicode () {
	printf '%04X\n' {32..65535} | xargs -I @ -P 0 echo 'echo -e "U+@: \u@"' | bash
	printf '%5X\n' {65536..129791} | xargs -I @ -P 0 echo 'echo -e "U+@: \U@"' | bash
}

nanikiru () {
	shuf -e {0..33}{,,,} \
		| head -n 14 \
		| awk '{ print ($1 < 7) ? $1 + 34 : $1 }' \
		| sort -n \
		| awk '{ print ($1 > 33) ? $1 - 34 : $1 }' \
		| xargs printf '\\U1F0%02X' \
		| echo -e "$(cat)"
}

multiplication_table () {
	local -i max="$1" i j
	local -i square=$(( max ** 2 ))
	for i in $(seq $max)
	do
		for j in $(seq $max)
		do
			printf "%${#square}d " $(( i * j ))
		done
		echo
	done
}

upgrade_go_bin () {
	local bin path bins=("$GOPATH"/bin/*)
	if (( $# < 1 )); then
		select bin in "${bins[@]##*/}"
		do
			[ -n "$bin" ] && break
			echo "Invalid input: '$REPLY'" >&2
		done
	else
		bin="$1"
	fi
	path=$(which -a "$bin" | grep "$GOPATH" | sed -n '1p')
	[ -z "$path" ] && {
		echo "Binary not found: '$bin'" >&2
		return
	}
	go install "$(go version -m "$path" | grep -Po '(?<=path\t).+$')@latest"
}

# For WSL
[[ "$(uname -r)" == *WSL* ]] && {
	export BROWSER="$HOME/.dotfiles/bin/winopen"
	export EXECIGNORE='*.dll:*.mof'

	# Windows 版 Blender を WSL から呼ぶ
	alias blender='/mnt/c/Program Files/Blender Foundation/Blender 5.2/blender.exe'
	alias clc='fc -ln -1 | sed -E "s/^\s+//" | nkf -s | clip.exe'
	alias ps1='powershell.exe'
	alias pst='powershell.exe -c Get-Clipboard | nkf -Lu'

	explore () {
		$BROWSER "$(wslpath -wa "${1:-.}")"
	}

	clip () {
		local file="${1:-/dev/stdin}"
		nkf -s < "$file" | clip.exe
	}

	lns () {
		local src=${1:?usage: lns TARGET NAME} dst=${2:?usage: lns TARGET NAME}
		command -v gsudo &> /dev/null || {
			echo 'gsudo is required' >&2
			return
		}
		local target name
		target=$(wslpath -wa "$src") && name=$(wslpath -wa "$dst") || return
		gsudo powershell.exe -c "New-Item -ItemType SymbolicLink -Path '$name' -Target '$target'"
	}

	open_chrome () {
		local f=${1:?usage: open_chrome FILE}
		powershell.exe -c "Start-Process chrome.exe '$(wslpath -wa "$f")'"
	}

	cpl () {
		local item items=(/mnt/c/Windows/system32/*.cpl)
		items=("${items[@]##*/}")
		if (( $# < 1 )); then
			select item in "${items[@]%.cpl}"
			do
				[ -n "$item" ] && break
				echo "Invalid input: $REPLY" >&2
			done
		else
			item="$1"
		fi
		control.exe "${item}.cpl"
	}

	go_coverage () {
		local out
		out=$(mktemp) || return
		# 出力先を固定して go 側のブラウザ起動判定に依存しない
		go test -coverprofile="$out" && go tool cover -html="$out" -o "$out.html" || return
		open_chrome "$out.html"
	}
}

##########################################################################
# 以下は Debian 標準の ~/.bashrc 由来の設定

# 非テキストファイルも less で扱えるようにする
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# ls と grep の色付けを有効にする
[ -x /usr/bin/dircolors ] && {
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias grep='grep --color=auto'
}

# プログラマブル補完を有効にする
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

##########################################################################
# 対話シェル向けツールの初期化

[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
command -v atuin &> /dev/null && eval "$(atuin init bash --disable-up-arrow)"
command -v thefuck &> /dev/null && eval "$(thefuck --alias)"

[ -x '/usr/local/bin/aws_completer' ] && complete -C '/usr/local/bin/aws_completer' aws
command -v influx &> /dev/null && source <(influx completion bash)
command -v jquants &> /dev/null && source <(jquants completion bash)

# 秘密情報や業務固有の設定 (git 管理外)
[ -s "$HOME/.bashrc.local" ] && . "$HOME/.bashrc.local"

# git-prompt が無い環境でもプロンプトを壊さない
declare -F __git_ps1 &> /dev/null || __git_ps1 () { :; }

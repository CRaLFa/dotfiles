alias ..='cd ..'
alias cl='clear && clear'
alias clock='watch -n 1 "date +\"%Y/%m/%dT%H:%M:%S\" | tr "T" "\\\\n" | figlet -f big"'
alias conoha='tmux new-session -s conoha ssh conoha'
alias d='docker'
alias funcs='type $(grep -Po "^\s*\w+(?= \(\))" ~/.bashrc)'
alias ins='sudo apt -y install'
alias insed='apt list --installed 2> /dev/null | grep -v "自動" | cut -d "/" -f 1'
alias ipv4='ip a | grep eth0 | grep -Po "inet\s\K[\d.]+"'
alias less='less -ix 4'
alias ll.='ll -d .??*'
alias ll='ls -lh'
alias lla='ll -A'
alias ls='ls -F --color=auto'
alias reload='exec bash -l'
alias tree='tree -Aa -I .git -I node_modules'
alias update='sudo apt update && sudo apt -y upgrade && sudo apt -y autoremove'
alias vibp='vi ~/.bash_profile'
alias vibr='vi ~/.bashrc'
alias vig='vi ~/.gitconfig'
alias viv='vi ~/.vimrc'

md () {
	(( $# < 1 )) && return 1
	mkdir "$1" && cd "$_"
}

rd () {
	[ -d "$1" ] || {
		echo "Error: Directory '$1' doesn't exist." >&2
		return 1
	}
	local s=''
	[ -w "$1" ] || s='sudo'
	eval "$s" rmdir "$1" 2> /dev/null || {
		read -rp "Remove non-empty directory '$1' ? [y/N]: " answer
		[ "$answer" = 'y' ] && eval "$s" rm -rf "$1"
	}
}

mt () {
	(( $# < 1 )) && return 1
	local d
	d=$(dirname "$1")
	[ -d "$d" ] || mkdir -p "$d" || {
		echo 'Failed to make directory.' >&2
		return 1
	}
	touch "$1"
}

repeat () {
	(( $# < 2 )) && return 1
	yes "$1" | head -n $2 | paste -sd ''
}

remove_docker_image () {
	(( $# < 1 )) && return 1
	docker images | grep "$1" | sed -E 's/\s+/\t/g' | cut -f 3 | xargs docker rmi -f
}

format_number () {
	(( $# < 1 )) && return 1
	perl -pe 's/\d(?=(\d{3})+$)/$&,/g' <<< "$1"
}

cc () {
	local s="$1"
	[ -z "$s" ] && s=$(cat)
	echo -n "$s" | wc -c
}

ex_norm () {
	ex -s +"norm! $*" +'%|q!' /dev/stdin
}

commands () {
	(( $# < 1 )) && {
		echo 'Usage: commands APT_PACKAGE_NAME' >&2
		return 1
	}
	local bins="$(dpkg -L "$1" | grep -P '(/usr)*/(s?bin|games)/')"
	[ -n "$bins" ] && echo "$bins" | xargs basename -a | sort | uniq
}

get_certificate () {
	openssl s_client -connect "${1}:443" < /dev/null 2> /dev/null | openssl x509 -text -noout
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

# For WSL
[[ "$(uname -r)" == *WSL* ]] && {
	alias ps1='powershell.exe'
	alias pst='powershell.exe -Command Get-Clipboard'

	explore () {
		explorer.exe /e,"$(wslpath -wa "${1:-.}")"
	}

	clip () {
		local file="${1:-/dev/stdin}"
		nkf -s < "$file" | clip.exe
	}

	lns () {
		(( $# < 2 )) && return 1
		which gsudo &> /dev/null || {
			echo 'gsudo is required' >&2
			return
		}
		local target="$(wslpath -wa "$1")" name="$(wslpath -wa "$2")"
		gsudo powershell.exe -Command "New-Item -ItemType SymbolicLink -Path $name -Target $target"
	}

	open_chrome () {
		(( $# < 1 )) && return 1
		powershell.exe -Command "Start-Process chrome.exe $(wslpath -wa "$1")"
	}

	cpl () {
		local item
		if (( $# < 1 )); then
			select item in $(find /mnt/c/Windows/system32/ -maxdepth 1 -name '*.cpl' | xargs basename -s '.cpl')
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
		local out=$(mktemp) html
		go test -coverprofile="$out" || return
		html=$(go tool cover -html="$out" |& rev | cut -d ' ' -f 1 | rev) || return
		open_chrome "$html"
	}
}

##########################################################################

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
	*i*) ;;
	  *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
	xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
	else
	color_prompt=
	fi
fi

if [ "$color_prompt" = yes ]; then
	PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
	PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
	PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
	;;
*)
	;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	# alias ls='ls --color=auto'
	# alias dir='dir --color=auto'
	# alias vdir='vdir --color=auto'

	alias grep='grep --color=auto'
	# alias fgrep='fgrep --color=auto'
	# alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
# alias ll='ls -alF'
# alias la='ls -A'
# alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#	sleep 10; alert
# alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
	. /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
  fi
fi

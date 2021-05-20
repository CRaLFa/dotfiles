[ -f ~/.bashrc ] && . ~/.bashrc

export PS1='\n\[\e[32m\]\u@\h \[\e[35m\]\s \[\e[33m\]\w\[\e[36m\]$(__git_ps1) \[\e[0m\][$(date "+%Y/%m/%d %H:%M:%S")]\n$ '
export LANG='ja_JP.UTF-8'
export EDITOR=/usr/bin/vim

PATH=$HOME/bin:$PATH
PATH=$HOME/.nodebrew/current/bin:$PATH
PATH=/opt/certbot:$PATH
export PATH

umask 022

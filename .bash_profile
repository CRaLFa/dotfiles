# [ -f ~/.bashrc ] && . ~/.bashrc

export PS1='\n\[\e[32m\]\u@\h \[\e[35m\]\s \[\e[33m\]\w\[\e[36m\]$(__git_ps1)\[\e[0m\]\n$ '
# export LANG='ja_JP.UTF-8'

PATH=$HOME/bin:$PATH
PATH=$HOME/.nodebrew/current/bin:$PATH
PATH=/opt/certbot:$PATH
export PATH

umask 022

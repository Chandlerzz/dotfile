# .bashrc
# tmux new -s 0 "fish" > /dev/null 2>&1
# tmux a -t 0 > /dev/null 2>&1
# tmux="tmux -2"

source ~/script/bash_script/find.sh
source ~/script/bash_script/monitorFile.sh
# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
alias his="history | grep"
alias docker="sudo docker"
source "$HOME/.cargo/env"
alias suro='~/script/bash_script/suroot'
alias suchandler='~/script/bash_script/suchandler'
alias gitpush='~/script/bash_script/gitpush'
export PATH=$PATH:/usr/local/go/bin
# bash $HOME/script/bash_script/diary.sh
# alias rmswp="perl $HOME/script/perl_script/unlinkSwap.pl"
export VISUAL="vim"
alias cds="cd && cd "
alias mymysql="python3 $HOME/script/python_script/mysqlManage/mysqlManage.py"
alias gits="perl $HOME/script/perl_script/gitManage/gitManage.pl"
alias ls="ls --color=auto"
alias javascript="cd /mnt/d/javascript_program"
alias collegy="cd /mnt/d/javascript_program/risentrain"
alias finereport="cd '/mnt/d/Program Files/FineReport_10.0'" 
alias gitstatus="mkdir -p /tmp/rmdbg && git status > /tmp/rmdbg/status.txt && pwd >> /tmp/rmdbg/status.txt && perl ~/script/perl_script/rmdbg.pl&&git status"
alias vims="vim -S ~/Session.vim"
alias vimss="vim -S ~/Chandler.vim"

export NVM_DIR="/home/chandler/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# 设置 redis的密码为空 
 redis-cli CONFIG set requirepass ""


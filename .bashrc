# .bashrc

# mysql pspg
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
alias docker="sudo docker"
source "$HOME/.cargo/env"
alias suchandler='~/dotfile/script/bash_script/suchandler'

# go env
export PATH=$PATH:/usr/local/go/bin
# 启用 Go Modules 功能
go env -w GO111MODULE=on
# 配置 GOPROXY 环境变量，以下三选一
# 1. 七牛 CDN
go env -w  GOPROXY=https://goproxy.cn,direct
# 2. 阿里云
go env -w GOPROXY=https://mirrors.aliyun.com/goproxy/,direct
# 3. 官方
go env -w  GOPROXY=https://goproxy.io,direct
go env -w GOBIN=$HOME/bin
# bash $HOME/script/bash_script/diary.sh
# alias rmswp="perl $HOME/script/perl_script/unlinkSwap.pl"
export VISUAL="vim"
alias ls="ls --color=auto"
alias javascript="cd /mnt/d/javascript_program"
alias collegy="cd /mnt/d/javascript_program/risentrain"
alias gitstatus="mkdir -p /tmp/rmdbg && git status > /tmp/rmdbg/status.txt && pwd >> /tmp/rmdbg/status.txt && perl ~/dotfile/script/perl_script/rmdbg.pl&&git status"

export NVM_DIR="/home/chandler/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm


eval "$(lua ~/.learn/z.lua/z.lua --init bash)"
# upload 是否存在 存在upload init
type upload > /dev/null 2>&1
if [[ $? == 0 ]]; then
    eval "$(upload && upload -i init)"
fi


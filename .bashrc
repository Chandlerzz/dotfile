# .bashrc

# mysql pspg
# pgcli -d risen_mes -h 10.10.8.235 -U gpadmin -W gpisgood
# Source global definitions
if [ -f /etc/bashrc ]; then
  .	/etc/bashrc
fi
# Environment variables
# --------------------------------------------------------------------

### man bash
export HISTCONTROL=ignoreboth:erasedups
export HISTSIZE=
export HISTFILESIZE=
export HISTTIMEFORMAT="%Y/%m/%d %H:%M:%S:   "
[ -z "$TMPDIR" ] && TMPDIR=/tmp
# create temp directory for vim
[ -d "/tmp/bufferList" ] && echo 1 > /dev/null || mkdir /tmp/bufferList
[ -d "/tmp/swp" ] && echo 1 > /dev/null || mkdir /tmp/swp

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
source "$HOME/.cargo/env"
export EDITOR="vim"
export VISUAL="vim"
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

alias gitstatus="mkdir -p /tmp/rmdbg && git status > /tmp/rmdbg/status.txt && pwd >> /tmp/rmdbg/status.txt && perl ~/dotfile/script/perl_script/rmdbg.pl&&git status"

export NVM_DIR="/home/chandler/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm


# a.lua
# --------------------------------------------------------------------

eval "$(lua ~/.learn/z.lua/z.lua --init bash)"
alias zz="z -I"
export _ZL_LOG_NAME="/tmp/.zlog"
export _ZL_HYPHEN=1
#  minio 
# --------------------------------------------------------------------
if command -v upload > /dev/null; then
    eval "$(upload -i init)"
fi


# Prompt
# --------------------------------------------------------------------

if [ "$PLATFORM" = Linux ]; then
  PS1="\[\e[1;38m\]\u\[\e[1;34m\]@\[\e[1;31m\]\h\[\e[1;30m\]:"
  PS1="$PS1\[\e[0;38m\]\w\[\e[1;35m\]> \[\e[0m\]"
else
  ### git-prompt
  __git_ps1() { :;}
  if [ -e ~/.git-prompt.sh ]; then
    source ~/.git-prompt.sh
  fi
  PS1='\[\e[34m\]\u\[\e[1;32m\]@\[\e[0;33m\]\h\[\e[35m\]:\[\e[m\]\w\[\e[1;30m\]$(__git_ps1)\[\e[1;31m\]> \[\e[0m\]'
fi

### Colored ls
if [ -x /usr/bin/dircolors ]; then
  eval "`dircolors -b`"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
elif [ "$PLATFORM" = Darwin ]; then
  alias ls='ls -G'
fi

# Aliases
# --------------------------------------------------------------------

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias cd.='cd ..'
alias cd..='cd ..'
alias l='ls -alF'
alias ll='ls -l'
alias vi=$EDITOR
alias vim=$EDITOR
alias docker="sudo docker"
alias which='type -p'
alias k5='kill -9 %%'
alias gv='vim +GV +"autocmd BufWipeout <buffer> qall"'
alias gpob='git push origin $(git branch --show-current)'
alias start="powershell.exe start"

tally(){
  sort | uniq -c | sort -n
}

ext() {
  ext-all --exclude .git --exclude target --exclude "*.log"
}

ext-all() {
  local name=$(basename $(pwd))
  cd ..
  tar -cvzf "$name.tgz" $* --exclude "$name.tgz" "$name"
  cd -
  mv ../"$name".tgz .
}

### Tmux
# Attach to named.
alias ta='tmux attach -t'
# Shortcut functions
# --------------------------------------------------------------------

..cd() {
  cd ..
  cd "$@"
}

_parent_dirs() {
  COMPREPLY=( $(cd ..; find . -mindepth 1 -maxdepth 1 -type d -print | cut -c3- | grep "^${COMP_WORDS[COMP_CWORD]}") )
}

complete -F _parent_dirs -o default -o bashdefault ..cd

viw() {
  vim "$(which "$1")"
}
fzf-down() {
  fzf --height 50% --min-height 20 --border --bind ctrl-/:toggle-preview "$@"
}

# fzf (https://github.com/junegunn/fzf)
# --------------------------------------------------------------------
# tmux list-windows -F "#{pane_id}" >/dev/null 2>&1
# if [ $? -eq 1 ]; then
# fi

Rg() {
  RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
  INITIAL_QUERY="$1"
  local filename linenumber
  local selected=$(
    FZF_DEFAULT_COMMAND="$RG_PREFIX '$INITIAL_QUERY' || true" \
      fzf --bind "change:reload:$RG_PREFIX {q} || true" \
          --ansi --query "$INITIAL_QUERY" \
          --delimiter : \
          --preview 'bat --style=full --color=always --highlight-line {2} {1}' \
          # --preview-window '~3:+{2}+3/2'
  )
  filename=$(echo $selected | awk -F ':' '{print $1}')
  linenumber=$(echo $selected | awk -F ':' '{print $2}')

  [ -n "$selected" ] && $EDITOR "$filename" +"$linenumber"
}

fzf-down() {
  fzf --height 50% --min-height 20 --border --bind ctrl-/:toggle-preview "$@"
}
export FZF_TMUX_OPTS='-p80%,60%'
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window down:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

if command -v fd > /dev/null; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND='fd --type f --type d --hidden --follow --exclude .git'
fi

command -v bat  > /dev/null && export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {}'"
command -v blsd > /dev/null && export FZF_ALT_C_COMMAND='blsd'
command -v tree > /dev/null && export FZF_ALT_C_OPTS="--preview 'tree -C {}'"

# chrome
# --------------------------------------------------------------------

chrome(){
  local q
  for query in $@; do
      q+=$query"+"
  done
  p start chrome "https://www.google.com/search?q="$q
}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# cp with fzf
# --------------------------------------------------------------------

if [ "$TERM" != "dumb" ] && command -v fzf >/dev/null 2>&1; then
	# To redraw line after fzf closes (printf '\e[5n')
	bind '"\e[0n": redraw-current-line'
	_zcp_fzf_complete() {
    local word=${COMP_WORDS[COMP_CWORD]} 
    if [ -z $word ]; then
      # word='|'
      return
    fi
    local wordlist=($(cat ~/.zlua | grep "$word" | awk -F '|' '{print $1;}' | sed "s|$HOME|\~|"))
    if [ "${#wordlist[@]}" == "0" ];then 
      echo "useless" >/dev/null 2>&1
    else
      local selected=$(cat ~/.zlua | grep $word |awk -F '|' '{print $1;}'| sed "s|$HOME|\~|" | fzf --height=35%)
      if [ -n "$selected" ]; then
        COMPREPLY=( "$selected" )
      fi
		printf '\e[5n'
    fi
	}
	complete -f -o bashdefault -o nospace -F _zcp_fzf_complete cp
fi
# ls with fzf
# --------------------------------------------------------------------

if [ "$TERM" != "dumb" ] && command -v fzf >/dev/null 2>&1; then
	# To redraw line after fzf closes (printf '\e[5n')
	bind '"\e[0n": redraw-current-line'
	_ls_fzf_complete() {
    local word=${COMP_WORDS[COMP_CWORD]} 
    if [ -z $word ]; then
      # word='|'
      return
    fi
    local wordlist=($(cat ~/.zlua | grep "$word" | awk -F '|' '{print $1;}' | sed "s|$HOME|\~|"))
    if [ "${#wordlist[@]}" == "0" ];then 
      echo "useless" >/dev/null 2>&1
    else
      local selected=$(cat ~/.zlua | grep $word |awk -F '|' '{print $1;}'| sed "s|$HOME|\~|" | fzf --height=35%)
      if [ -n "$selected" ]; then
        COMPREPLY=( "$selected" )
      fi
		printf '\e[5n'
    fi
	}
	complete -d -o bashdefault -o nospace -F _ls_fzf_complete ls
fi
# windows exe reference
# --------------------------------------------------------------------
# 'uname -a'   check witch linux it is.  
#Linux LT0303609 5.10.16.3-microsoft-standard-WSL2 #1 SMP Fri Apr 2 22:23:49 UTC 2021 x86_64 GNU/Linux
alias mysqldump="/mnt/c/Program\ Files/MySQL/MySQL\ Server\ 8.0/bin/mysqldump.exe"
alias mysql="/mnt/c/Program\ Files/MySQL/MySQL\ Server\ 8.0/bin/mysql.exe"
alias npm="powershell.exe npm"

# thefuck
# --------------------------------------------------------------------
eval "$(thefuck --alias)"


#!/bin/bash
tmux has-session -t mysql
if [ $? != 0 ]
then
    # get the config in_use
    config=$(python <<EOF
import json
import os
configFile = os.environ['HOME']+"/dotfile/mysql_config.json"
with open(configFile) as f:
    result = json.load(f)
    in_use = result['in_use']
    print(in_use)
EOF
)
    replace=""
    config=${config//[\[\]]/$replace}
    config=${config//"'"/$replace}
    configArray=$(echo $config | tr "," "\n")
    tmux new-session -s mysql -n "vim" -d
    tmux send-keys -t vim 'vim -S ~/Mysql.vim' C-m
    for name in $configArray
    do
       echo $name
       tmux new-window -t mysql -n $name
    done
    # tmux split-window -h -t mysql:1 
    # tmux send-keys -t vim:2 'redis-cli set tty $(tty)' C-m
    # tmux send-keys -t mysql:1 'mymysql univ_test' C-m
fi
 tmux attach -t mysql

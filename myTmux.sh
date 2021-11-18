#!/bin/bash
tmux has-session -t mysql
if [ $? != 0 ]
then
    tmux new-session -s mysql -n "vim" -d
    tmux send-keys -t vim 'cd $HOME/mysql' C-m
    #  do it in python
    python <<EOF
import json
import os
configFile = os.environ['HOME']+"/dotfile/mysql_config.json"
with open(configFile) as f:
    result = json.load(f)
    in_use = result['in_use']
    for i in in_use:
        name = i['name']
        database = i['database']
        os.system("tmux new-window -t mysql -n " + name)
        os.system("tmux send-keys -t " + name + " 'cd $HOME/mysql' C-m" )
        os.system("tmux send-keys -t " + name + " 'vim "+name+".mysql' C-m" )
        os.system("tmux split-window -h -t mysql:" + name)
        os.system("tmux send-keys -t 2 'mymysql " + name +"'" + " C-m")
        os.system("tmux send-keys -t 2 'use " + database +"'" + " C-m")
        os.system("tmux select-pane -t 1")
EOF
    #### difficult to deal with datatype in shell
    #replace=""
    #config=${config//[\[\]]/$replace}
    #config=${config//"'"/$replace}
    #configArray=$(echo $config | tr "," "\n")
    #for name in $configArray
    #do
    #    #create new window by the mysql nickname
    #    tmux new-window -t mysql -n $name
    #    #mysql cli
    #    tmux send-keys -t mysql 'mymysql '$name C-m
    #    # -- todo table name --
    #done
    tmux kill-window -t vim
fi
 tmux attach -t mysql

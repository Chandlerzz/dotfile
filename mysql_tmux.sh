#!/bin/bash
tmux has-session -t dev
if [ $? != 0 ]
then
    tmux new-session -s dev -n "vim" -d
    tmux send-keys -t dev "watch cat /tmp/bufferList.chandler /tmp/lrccount1" C-m
    tmux split-window -h -t dev:1 -p 100
    tmux send-keys -t vim 'vim -S ~/Mysql.vim' C-m
    tmux select-pane -L
    tmux split-window -v -t dev:1 
    tmux send-keys -t dev "python3 ~/vim/demoserver.py" C-m
    tmux new-window -n "mysql" -t dev
    tmux send-keys -t mysql 'redis-cli set tty $(tty)' C-m
    tmux send-keys -t mysql 'mymysql univ_test' C-m
fi
tmux attach -t dev

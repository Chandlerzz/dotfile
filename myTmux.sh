#!/bin/bash
tmux has-session -t mysql
if [ $? != 0 ]
then
    tmux new-session -s mysql -n "vim" -d
    tmux send-keys -t vim 'vim -S ~/Mysql.vim' C-m
    tmux split-window -v -t mysql:1 
    tmux send-keys -t vim:2 'redis-cli set tty $(tty)' C-m
    tmux send-keys -t mysql:1 'mymysql univ_mysql' C-m
fi
tmux attach -t mysql

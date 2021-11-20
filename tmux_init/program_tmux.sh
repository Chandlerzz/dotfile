#!/bin/bash
tmux has-session -t program 
if [ $? != 0 ]
then
    tmux new-session -s program -n "vim" -d
    tmux send-keys -t program "watch cat /tmp/bufferList.chandler /tmp/lrccount1" C-m
    tmux split-window -h -t program:1 -p 100
    tmux send-keys -t vim 'vim -S ~/Module.vim' C-m
    tmux select-pane -L
    tmux split-window -v -t program:1  
    tmux send-keys -t program "watch cat /tmp/registers" C-m
fi
tmux attach -t program

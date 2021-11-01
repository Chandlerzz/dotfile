#!/bin/bash
tmux has-session -t collegy 
if [ $? != 0 ]
then
    tmux new-session -s collegy -n "vim" -d
    tmux send-keys -t collegy "watch cat /tmp/bufferList.chandler /tmp/lrccount1" C-m
    tmux split-window -h -t collegy:0 -p 100
    tmux send-keys -t vim 'vim -S ~/Session.vim' C-m
    tmux select-pane -L
    tmux split-window -v -t collegy:0  
    tmux new-window -n "server" -t collegy
    tmux send-keys -t collegy:server "collegy && cd vue-admin/ && npm run serve" C-m
    tmux split-window -h -t collegy:server
    tmux send-keys -t collegy:server "collegy && cd egg-server/ && npm run debug" C-m
    tmux select-window -t collegy:0
fi
tmux attach -t collegy

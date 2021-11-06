#!/bin/bash
tmux has-session -t dev
if [ $? != 0 ]
then
    tmux new-session -s dev -n "TEST" -d

    tmux split-window -h -t dev:0
    tmux split-window -v -t dev:0.1
    tmux send-keys -t dev:0.0 'cd ~/foo/bar' C-m
    tmux send-keys -t dev:0.1 'autossh -M 0 -o "ServerAliveInterval 60" -o "ServerAliveCountMax 3" test@test -t "cd ~/bar;bash"' C-m
    tmux send-keys -t dev:0.2 'autossh -M 0 -o "ServerAliveInterval 60" -o "ServerAliveCountMax 3" test@test -t "cd ~/bar;bash"' C-m

    tmux new-window -n "TEST logs" -t dev
    tmux send-keys -t dev:1.0 'multitail -Ev "deprecated" -Ev "Twig_(Function|Filter).*is deprecated" -Ev "\"Twig_(Function|Filter)_Method\" for (function|filter) \"(ld|ladybug_dump)" -Ev "event\\.DEBUG" -Ev "HTTP/1\\.1\" (2|3)" -Ev "snc_redis.INFO" -s 2 -f ~/foo/bar/app/logs/dev.log ~/foo/logs/d.*' C-m

    tmux new-window -n "TEST2" -t dev
    tmux split-window -h -t dev:2
    tmux split-window -v -t dev:2.1
    tmux send-keys -t dev:2.0 'cd ~/foo/bar_foo' C-m
    tmux send-keys -t dev:2.1 'autossh -M 0 -o "ServerAliveInterval 60" -o "ServerAliveCountMax 3" test@test -t "cd ~/bar_foo;bash"' C-m
    tmux send-keys -t dev:2.2 'autossh -M 0 -o "ServerAliveInterval 60" -o "ServerAliveCountMax 3" test@test -t "cd ~/bar_foo;bash"' C-m

    tmux new-window -n "TEST2 logs" -t dev
    tmux send-keys -t dev:3.0 'multitail -Ev "deprecated" -Ev "Twig_(Function|Filter).*is deprecated" -Ev "\"Twig_(Function|Filter)_Method\" for (function|filter) \"(ld|ladybug_dump)" -Ev "event\\.DEBUG" -Ev "HTTP/1\\.1\" (2|3)" -Ev "snc_redis.INFO" -s 2 -f ~/foo/bar_foo/app/logs/dev.log ~/foo/logs/foo.*' C-m

    tmux new-window -n "TEST3" -t dev
    tmux split-window -h -t dev:4
    tmux send-keys -t dev:4.0 'autossh -M 0 -o "ServerAliveInterval 60" -o "ServerAliveCountMax 3" test@test' C-m
    tmux send-keys -t dev:4.1 'autossh -M 0 -o "ServerAliveInterval 60" -o "ServerAliveCountMax 3" test@test -t "multitail -Ev \"NotFoundHttpException|MethodNotAllowedHttpException\" -iw \"/mnt/syslog-stage/php/errors/*\" 120"' C-m

    tmux new-window -n "TEST4" -t dev
    tmux split-window -h -t dev:5
    tmux send-keys -t dev:5.0 'autossh -M 0 -o "ServerAliveInterval 60" -o "ServerAliveCountMax 3" test@test' C-m
    tmux send-keys -t dev:5.1 'autossh -M 0 -o "ServerAliveInterval 60" -o "ServerAliveCountMax 3" test@test -t "multitail -Ev \"NotFoundHttpException|MethodNotAllowedHttpException\" -iw \"/mnt/syslog/php/errors/*\" 120"' C-m

    tmux new-window -n "dotfiles/doc" -t dev
    tmux split-window -h -t dev:6
    tmux send-keys -t dev:6.0 'cd ~/dotfiles' C-m
    tmux send-keys -t dev:6.0 'cd ~/docs' C-m

    tmux select-window -t dev:0
fi
tmux attach -t dev

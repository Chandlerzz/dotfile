#/bin/sh

[[ -L ~/dotfile/.tmux.conf ]] || ln -s ~/dotfile/plugin ~/.tmux.conf
[[ -L ~/dotfile/.bashrc ]] || ln -s ~/dotfile/.bashrc ~/.bashrc

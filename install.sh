#/bin/sh

[[ -L ~/dotfile/.tmux.conf ]] || ln -s ~/dotfile/.tmux.conf ~/.tmux.conf
[[ -L ~/dotfile/.bashrc ]] || ln -s ~/dotfile/.bashrc ~/.bashrc

#/bin/bash
# man link  手动执行
[[ -L /usr/share/man/man1c ]] \
    && (sudo rm /usr/share/man/man1c && sudo ln -s $HOME/dotfile/man /usr/share/man/man1c)\
    || sudo ln -s $HOME/dotfile/man /usr/share/man/man1c
make ~/dotfile/script/c/rmswp
cp ~/dotfile/script/c/rmswp ~/bin

if [[ -f $HOME/bin/upload ]]; then
    # useless
    eval
else
    cd $HOME/dotfile/script/golang_script/upload
    go build -o $HOME/bin/
fi


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

mkdir -p ~/.vim/pack/tpope/start
cd ~/.vim/pack/tpope/start
git clone https://tpope.io/vim/surround.git
vim -u NONE -c "helptags surround/doc" -c q
# mkdir -p ~/.vim/pack/tpope/start
cd ~/.vim/pack/tpope/start
git clone https://tpope.io/vim/commentary.git
vim -u NONE -c "helptags commentary/doc" -c q
# mkdir -p ~/.vim/pack/tpope/start
cd ~/.vim/pack/tpope/start
git clone https://tpope.io/vim/fugitive.git
vim -u NONE -c "helptags fugitive/doc" -c q
mkdir -p ~/.vim/pack/tpope/start
cd ~/.vim/pack/tpope/start
git clone https://tpope.io/vim/repeat.git

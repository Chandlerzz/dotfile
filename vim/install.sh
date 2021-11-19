#/bin/sh

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


[[ -L ~/.vimrc ]] && (rm ~/.vimrc && ln -s ~/dotfile/vim/.vimrc ~/.vimrc) || ln -s ~/dotfile/vim/.vimrc ~/.vimrc 
# [[ -L ~/.vim/plugin ]] 
#     \ && (rm ~/.vim/plugin && ln -s ~/dotfile/vim/plugin ~/.vim/plugin) 
#     \ || ln -s ~/dotfile/vim/plugin ~/.vim/plugin 
# [[ -L ~/.vim/autoload ]] 
#     \ && ( rm ~/.vim/autoload && ln -s ~/dotfile/vim/autoload ~/.vim/autoload ) 
#     \ || ln -s ~/dotfile/vim/autoload ~/.vim/autoload 
# [[ -L ~/.vim/ftdetect ]] 
#     \ && (rm ~/.vim/ftdetect && ln -s ~/dotfile/vim/ftdetect ~/.vim/ftdetect )
#     \ || ln -s ~/dotfile/vim/ftdetect ~/.vim/ftdetect 
# [[ -L ~/.vim/syntax ]] 
#     \ && (rm ~/.vim/syntax && ln -s ~/dotfile/vim/syntax ~/.vim/syntax)
#     \ || ln -s ~/dotfile/vim/syntax ~/.vim/syntax 

# mkdir -p ~/.vim/pack/chandler/start 
# [[ -L ~/.vim/pack/chandler/start ]] 
#     \ && (rm ~/.vim/pack/chandler/start && ln -s ~/dotfile/vim/mysql ~/.vim/pack/chandler/start/mysql )
#     \ || ln -s ~/dotfile/vim/mysql ~/.vim/pack/chandler/start/mysql 
# [[ -L ~/.vim/pack/chandler/start ]] 
#     \ && (rm ~/.vim/pack/chandler/start && ln -s ~/dotfile/vim/diary ~/.vim/pack/chandler/start/diary) 
#     \ || ln -s ~/dotfile/vim/diary ~/.vim/pack/chandler/start/diary 
# [[ -L ~/.vim/pack/chandler/start ]]
#     \ && (rm ~/.vim/pack/chandler/start && ln -s ~/dotfile/vim/roast.vim ~/.vim/pack/chandler/start/roast.vim) 
#     \ || ln -s ~/dotfile/vim/roast.vim ~/.vim/pack/chandler/start/roast.vim 
# [[ -L ~/bin/mysqltmux ]] 
#     \ (&& rm ~/bin/mysqltmux && ln -s ~/dotfile/vim/mysql/python/mysql_tmux.py ~/bin/mysqltmux)
#     \ || ln -s ~/dotfile/vim/mysql/python/mysql_tmux.py ~/bin/mysqltmux

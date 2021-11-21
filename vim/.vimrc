syntax on
" diary plugin path
let g:diarybasepath = "~/report/"
let g:diaryshellscript = "/dotfile/vim/diary/diary.sh"

" register plugin path
let g:registerWatchFile = "/tmp/registers"
let g:bufferListFileName ="/tmp/bufferList.chandler"
let g:LRCfileName = "/tmp/LRC.chandler"
let g:LRCcount = "/tmp/lrccount"
let g:tabpath = [
            \"/mnt/d/javascript_program/risentrain/applet-student",
            \"/mnt/d/javascript_program/risentrain/vue-admin",
            \"/mnt/d/javascript_program/risentrain/egg-server"
\]
let g:globalpath = [
            \$HOME . "/todo",
            \$HOME . "/man",
            \$HOME . "/vim",
            \$HOME . "/vim/plugin",
            \]
for $gpath in g:globalpath
    set path+=$gpath
endfor
let g:localpath = [
            \"/mnt/d/javascript_program/risentrain/applet-student/pages",
            \"/mnt/d/javascript_program/risentrain/applet-student/component",
            \"/mnt/d/javascript_program/risentrain/applet-student/functions",
            \"/mnt/d/javascript_program/risentrain/egg-server/app/route",
            \"/mnt/d/javascript_program/risentrain/egg-server/app/model",
            \"/mnt/d/javascript_program/risentrain/egg-server/app/controller",
            \"/mnt/d/javascript_program/risentrain/egg-server/app/service",
            \"/mnt/d/javascript_program/risentrain/vue-admin/src/views",
            \"/mnt/d/javascript_program/risentrain/vue-admin/src/mixins",
            \"/mnt/d/javascript_program/risentrain/vue-admin/src/components",
            \]
"ctags config
set tags=tags
let g:Lf_ShortcutB='<leader>bn'
""leaderf gtags, but I don't know how to use it.
"let g:Lf_GtagsAutoGenerate = 1
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set number
set relativenumber
set cmdheight=2
set so=5
set laststatus=2
let mapleader = "-"
let maplocalleader = ";"
noremap <leader>m :marks<CR>
nnoremap <c-k>o ZZ
xnoremap <leader>p "_dp
imap jj <esc>  
nnoremap <c-s> :w<CR>
vmap <c-s> <Esc><c-s>gv
imap <c-s> <Esc><c-s>
" move line
map <Esc>j <A-j>
map <Esc>k <A-k>
nnoremap <A-k> :m .-2<CR>==
nnoremap <A-j> :m .+1<CR>==
" inoremap <A-j> <Esc>:m .+1<CR>==gi
" inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
"" clipbord map

inoremap <C-v> <ESC>:set paste<CR>"+p:set nopaste<CR>a
vnoremap <C-c> "+y
vnoremap <C-d> "+d

nnoremap <leader>m :marks<cr>
""" move to html tab to insert word in normal mode
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>bv :vsplit ~/.bashrc<cr>
map <C-right> <ESC>:bn<CR>
map <C-left> <ESC>:bp<CR>
noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
"" cmdline map
cnoremap <C-A> <Home>
cnoremap <C-F> <Right>
cnoremap <C-B> <Left>
cnoremap <Esc>b <S-Left>
cnoremap <Esc>d <S-Right>

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
"""set the directory presentation
let g:netrw_browse_split = 4
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_winsize = 25
if has ('autocmd')
	augroup Reload_Vimrc
	autocmd!
	autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded" . $MYVIMRC | redraw
	augroup end
endif " has aoutocmd
call plug#begin('~/.vim/bundle')
Plug 'skywind3000/asyncrun.vim'
Plug 'scrooloose/nerdcommenter'
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
Plug 'mattn/emmet-vim'
Plug 'morhetz/gruvbox'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
Plug 'chemzqm/wxapp.vim'
Plug 'Chandlerzz/vim-vue'
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
call plug#end()
colorscheme gruvbox
set background=dark
highlight Normal ctermbg=0
let g:user_emmet_settings = {
  \ 'wxss': {
  \   'extends': 'css',
  \ },
  \ 'wxml': {
  \   'extends': 'html',
  \   'aliases': {
  \     'div': 'view',
  \     'span': 'text',
  \   },
  \  'default_attributes': {
  \     'block': [{'wx:for-items': '{{list}}','wx:for-item': '{{item}}'}],
  \     'navigator': [{'url': '', 'redirect': 'false'}],
  \     'scroll-view': [{'bindscroll': ''}],
  \     'swiper': [{'autoplay': 'false', 'current': '0'}],
  \     'icon': [{'type': 'success', 'size': '23'}],
  \     'progress': [{'precent': '0'}],
  \     'button': [{'size': 'default'}],
  \     'checkbox-group': [{'bindchange': ''}],
  \     'checkbox': [{'value': '', 'checked': ''}],
  \     'form': [{'bindsubmit': ''}],
  \     'input': [{'type': 'text'}],
  \     'label': [{'for': ''}],
  \     'picker': [{'bindchange': ''}],
  \     'radio-group': [{'bindchange': ''}],
  \     'radio': [{'checked': ''}],
  \     'switch': [{'checked': ''}],
  \     'slider': [{'value': ''}],
  \     'action-sheet': [{'bindchange': ''}],
  \     'modal': [{'title': ''}],
  \     'loading': [{'bindchange': ''}],
  \     'toast': [{'duration': '1500'}],
  \     'audio': [{'src': ''}],
  \     'video': [{'src': ''}],
  \     'image': [{'src': '', 'mode': 'scaleToFill'}],
  \   }
  \ },
  \}

"gger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
"   " - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"

" perl 
let perl_fold =1
let perl_fold_anonymous_subs=1
 " let perl_include_pod = 1
 " unlet perl_no_scope_in_variables
 " unlet perl_no_extended_vars
 " unlet perl_string_as_statement
 " unlet perl_no_sync_on_sub
 " unlet perl_no_sync_on_global_var
 " let perl_sync_dist = 100
 " let perl_fold_blocks=1
 " let perl_nofold_packages=1
 " let perl_nofold_subs=1
 " let perl_no_subprototype_error=1
 
"" easy switch window 
 nnoremap <C-j> <C-w>j
 nnoremap <C-k> <C-w>k
 nnoremap <C-h> <C-w>h
 nnoremap <C-l> <C-w>l
" Map Ctrl + p to open fuzzy find (FZF)
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')


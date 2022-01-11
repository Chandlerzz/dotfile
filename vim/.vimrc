" vim: set foldmethod=marker foldlevel=0 nomodeline:
"
"
" ============================================================================
"  .vimrc of zhongzhong {{{
    
" ============================================================================
" Vim 8 defaults
unlet! skip_defaults_vim
silent! source $VIMRUNTIME/defaults.vim
augroup vimrc
     autocmd!
 augroup END

let s:darwin = has('mac')
let s:windows = has('win32') || has('win64')
let mapleader = "-"
let maplocalleader = ";"

" }}}
 
" ============================================================================
" VIM-PLUG BLOCK {{{
" ============================================================================
call plug#begin('~/.vim/bundle')
"zhongzhong
Plug 'Chandlerzz/vim-hideseek'
Plug 'Chandlerzz/vimTmysql'
Plug 'Chandlerzz/vim-diary'
"junegunn
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-github-dashboard'
  let g:github_dashboard = { 'username': 'junegunn' }
Plug 'junegunn/vim-emoji'
  command! -range EmojiReplace <line1>,<line2>s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g

Plug 'junegunn/vim-pseudocl'
Plug 'junegunn/vim-slash'
  if has('timers')
    noremap <expr> <plug>(slash-after) slash#blink(2, 50)
  endif

Plug 'junegunn/vim-cfr'
Plug 'junegunn/vim-fnr'
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/vim-journal'
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/gv.vim'
  function! s:gv_expand()
    let line = getline('.')
    GV --name-status
    call search('\V'.line, 'c')
    normal! zz
  endfunction
  autocmd! FileType GV nnoremap <buffer> <silent> + :call <sid>gv_expand()<cr>

Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
  nmap <Leader>l <Plug>(Limelight)
  xmap <Leader>l <Plug>(Limelight)
  nnoremap <Leader>ll :Limelight!<cr>
Plug 'junegunn/vader.vim'
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'junegunn/heytmux'
Plug 'junegunn/vim-after-object'
  autocmd VimEnter * silent! call after_object#enable('=', ':', '#', ' ', '|')

if s:darwin
  Plug 'junegunn/vim-xmark'
endif

Plug 'skywind3000/asyncrun.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'mattn/emmet-vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'chemzqm/wxapp.vim'
Plug 'Chandlerzz/vim-vue'
" Browsing
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
  augroup nerd_loader
  autocmd!
  autocmd VimEnter * silent! autocmd! FileExplorer
  autocmd BufEnter,BufNew *
    \  if isdirectory(expand('<amatch>'))
    \|   call plug#load('nerdtree')
    \|   execute 'autocmd! nerd_loader'
    \| endif
augroup END
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
Plug 'Yggdroot/indentLine', { 'on': 'IndentLinesEnable' }
    autocmd! User indentLine doautocmd indentLine Syntax
    let g:indentLine_color_term = 239
    let g:indentLine_color_gui = '#616161'
" Colors
Plug 'tomasr/molokai'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'morhetz/gruvbox'
  let g:gruvbox_contrast_dark = 'soft'
Plug 'yuttie/hydrangea-vim'
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'AlessandroYorba/Despacio'
Plug 'cocopon/iceberg.vim'
Plug 'w0ng/vim-hybrid'
Plug 'nightsense/snow'
Plug 'nightsense/stellarized'
Plug 'arcticicestudio/nord-vim'
Plug 'nightsense/cosmic_latte'
" Edit
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-commentary'
  map  gc  <Plug>Commentary
  nmap gcc <Plug>CommentaryLine

Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
  let g:undotree_WindowLayout = 2
  nnoremap U :UndotreeToggle<CR>
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'AndrewRadev/splitjoin.vim'
  let g:splitjoin_split_mapping = ''
  let g:splitjoin_join_mapping = ''
  nnoremap gss :SplitjoinSplit<cr>
  nnoremap gsj :SplitjoinJoin<cr>

Plug 'AndrewRadev/switch.vim'
  let g:switch_mapping = '-'
  let g:switch_custom_definitions = [
  \   ['MON', 'TUE', 'WED', 'THU', 'FRI']
  \ ]

Plug 'sgur/vim-editorconfig'
if exists('##TextYankPost')
  Plug 'machakann/vim-highlightedyank'
  let g:highlightedyank_highlight_duration = 100
endif
" Browsing
Plug 'Yggdroot/indentLine', { 'on': 'IndentLinesEnable' }
  autocmd! User indentLine doautocmd indentLine Syntax
  let g:indentLine_color_term = 239
  let g:indentLine_color_gui = '#616161'


Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
  augroup nerd_loader
    autocmd!
    autocmd VimEnter * silent! autocmd! FileExplorer
    autocmd BufEnter,BufNew *
          \  if isdirectory(expand('<amatch>'))
          \|   call plug#load('nerdtree')
          \|   execute 'autocmd! nerd_loader'
          \| endif
  augroup END

Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
  let g:tagbar_sort = 0

Plug 'justinmk/vim-gtfo'

Plug 'junegunn/vim-carbon-now-sh' " Forked
let g:carbon_now_sh_options = { 't': 'oceanic-next'}

" Git
Plug 'tpope/vim-fugitive'
  nmap     <Leader>g :Git<CR>gg<c-n>
  nnoremap <Leader>d :Gdiff<CR>
Plug 'rhysd/git-messenger.vim'

Plug 'tpope/vim-rhubarb'
Plug 'mhinz/vim-signify'
  let g:signify_vcs_list = ['git']
  let g:signify_skip_filetype = { 'journal': 1 }
  let g:signify_sign_add          = '│'
  let g:signify_sign_change       = '│'
  let g:signify_sign_changedelete = '│'

" Lang
Plug 'kovisoft/paredit', { 'for': 'clojure' }
  let g:paredit_smartjump = 1
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'guns/vim-clojure-static'
  let g:clojure_maxlines = 60
  set lispwords+=match
  let g:clojure_fuzzy_indent_patterns = ['^with', '^def', '^let']
Plug 'guns/vim-clojure-highlight'
Plug 'guns/vim-slamhound'
Plug 'tpope/vim-bundler'
if v:version >= 800
  Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
endif
Plug 'groenewege/vim-less'
Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'alvan/vim-closetag'
  let g:closetag_filenames = '*.js'

Plug 'kchmck/vim-coffee-script'
Plug 'slim-template/vim-slim'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-rails', { 'for': [] }
Plug 'derekwyatt/vim-scala'
Plug 'honza/dockerfile.vim'
Plug 'solarnz/thrift.vim'
Plug 'dag/vim-fish'
" Plug 'chrisbra/unicode.vim', { 'for': 'journal' }
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'ferrine/md-img-paste.vim'
  autocmd FileType markdown nnoremap <buffer> <silent> <leader>v :call mdip#MarkdownClipboardImage()<CR>
  let g:mdip_imgdir = 'images'
  let g:mdip_imgname = 'image'
Plug 'mzlogin/vim-markdown-toc'
Plug 'habamax/vim-sendtoterm'
Plug '907th/vim-auto-save'

" Lint
" completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()
" }}}
" ============================================================================
 " BASIC SETTINGS {{{
" ============================================================================
syntax on
" diary plugin path
let g:diarybasepath = "~/report/"
let g:diaryshellscript = "/.vim/bundle/vim-diary/diary.sh"

" register plugin path
let g:registerWatchFile = "/tmp/registers"
let g:bufferListFileName ="/tmp/bufferList.hideseek"
let g:LRCfileName = "/tmp/LRC.hideseek"
let g:LRCcount = "/tmp/lrccount"

"ctags config
set nu
set so=5
set relativenumber
set autoindent
set smartindent
set lazyredraw
set laststatus=2
set showcmd
set visualbell
set backspace=indent,eol,start
set timeoutlen=500
set whichwrap=b,s
set shortmess=aIT
set hlsearch " CTRL-L / CTRL-R W
set incsearch
set hidden
set ignorecase smartcase
set wildmenu
set wildmode=full
set tabstop=2
set shiftwidth=2
set expandtab smarttab
set scrolloff=5
set encoding=utf-8
set list
set listchars=tab:\|\ ,
set virtualedit=block
set nojoinspaces
set diffopt=filler,vertical
set autoread
set clipboard=unnamed
set foldlevelstart=99
set grepformat=%f:%l:%c:%m,%f:%l:%m
set completeopt=menuone,preview
set nocursorline
set nrformats=hex
silent! set cryptmethod=blowfish2
set formatoptions+=1
if has('patch-7.3.541')
  set formatoptions+=j
endif
if has('patch-7.4.338')
  let &showbreak = '↳ '
  set breakindent
  set breakindentopt=sbr
endif
if has('termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
function! s:statusline_expr()
    let mod = "%{&modified ? '[+] ' : !&modifiable ? '[x] ' : ''}"
    let ro  = "%{&readonly ? '[RO] ' : ''}"
    let ft  = "%{len(&filetype) ? '['.&filetype.'] ' : ''}"
    let fug = "%{exists('g:loaded_fugitive') ? fugitive#statusline() : ''}"
    let sep = ' %= '
    let pos = ' %-12(%l : %c%V%) '
    let pct = ' %P'

 return '[%n] %F %<'.mod.ro.ft.fug.sep.pos.'%*'.pct
endfunction
let &statusline = s:statusline_expr()

set modelines=2
set synmaxcol=1000
" For MacVim
set noimd
set imi=1
set ims=-1

" ctags
set tags=./tags;/
" Annoying temporary files
set backupdir=/tmp//,.
set directory=/tmp//,.
" Semi-persistent undo
if has('persistent_undo')
  set undodir=/tmp,.
  set undofile
endif

" Shift-tab on GNU screen
" http://superuser.com/questions/195794/gnu-screen-shift-tab-issue
set t_kB=   

" set complete=.,w,b,u,t
set complete-=i

" mouse
silent! set ttymouse=xterm2
set mouse=a
" 80 chars/line
set textwidth=0
if exists('&colorcolumn')
  set colorcolumn=80
endif
" Keep the cursor on the same column
set nostartofline
" FOOBAR=~/<CTRL-><CTRL-F>
set isfname-==
if exists('&fixeol')
  set nofixeol
endif

silent! colo seoul256
if has('nvim')
  " https://github.com/neovim/neovim/issues/2897#issuecomment-115464516
  let g:terminal_color_0 = '#4e4e4e'
  let g:terminal_color_1 = '#d68787'
  let g:terminal_color_2 = '#5f865f'
  let g:terminal_color_3 = '#d8af5f'
  let g:terminal_color_4 = '#85add4'
  let g:terminal_color_5 = '#d7afaf'
  let g:terminal_color_6 = '#87afaf'
  let g:terminal_color_7 = '#d0d0d0'
  let g:terminal_color_8 = '#626262'
  let g:terminal_color_9 = '#d75f87'
  let g:terminal_color_10 = '#87af87'
  let g:terminal_color_11 = '#ffd787'
  let g:terminal_color_12 = '#add4fb'
  let g:terminal_color_13 = '#ffafaf'
  let g:terminal_color_14 = '#87d7d7'
  let g:terminal_color_15 = '#e4e4e4'

  set fillchars=vert:\|,fold:-
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
else
  let g:terminal_ansi_colors = [
    \ '#4e4e4e', '#d68787', '#5f865f', '#d8af5f',
    \ '#85add4', '#d7afaf', '#87afaf', '#d0d0d0',
    \ '#626262', '#d75f87', '#87af87', '#ffd787',
    \ '#add4fb', '#ffafaf', '#87d7d7', '#e4e4e4']
endif

" }}}
" ============================================================================
" MAPPINGS {{{
" ============================================================================

" ----------------------------------------------------------------------------
" Basic mappings
" ----------------------------------------------------------------------------
" Open new line below and above current line
nnoremap <leader>o o<esc>
nnoremap <leader>O O<esc>

" Save
inoremap <C-s>     <C-O>:update<cr>
nnoremap <C-s>     :update<cr>
nnoremap <leader>s :update<cr>
nnoremap <leader>w :update<cr>

" Disable CTRL-A on tmux or on screen
if $TERM =~ 'screen'
  nnoremap <C-a> <nop>
  nnoremap <Leader><C-a> <C-a>
endif
" Quit
inoremap <C-Q>     <esc>:q<cr>
nnoremap <C-Q>     :q<cr>
vnoremap <C-Q>     <esc>
nnoremap <Leader>q :q<cr>
nnoremap <Leader>Q :qa!<cr>

" Tags
" nnoremap <C-]> g<C-]>
" nnoremap g[ :pop<cr>

" Jump list (to newer position)
" nnoremap <C-p> <C-i>

" <leader>n | NERD Tree
nnoremap <leader>n :NERDTreeToggle<cr>

" jk | Escaping!
inoremap jk <Esc>
xnoremap jk <Esc>
cnoremap jk <C-c>
" Movement in insert mode
inoremap <C-h> <C-o>h
inoremap <C-l> <C-o>a
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-^> <C-o><C-^>

" Make Y behave like other capitals
nnoremap Y y$

 " qq to record, Q to replay
nnoremap Q @q

" Zoom
function! s:zoom()
  if winnr('$') > 1
    tab split
  elseif len(filter(map(range(tabpagenr('$')), 'tabpagebuflist(v:val + 1)'),
                  \ 'index(v:val, '.bufnr('').') >= 0')) > 1
    tabclose
  endif
endfunction
nnoremap <silent> <leader>z :call <sid>zoom()<cr>

" Last inserted text
nnoremap g. :normal! `[v`]<cr><left>

" ----------------------------------------------------------------------------
" nvim
" ----------------------------------------------------------------------------
if has('nvim')
  tnoremap <a-a> <esc>a
  tnoremap <a-b> <esc>b
  tnoremap <a-d> <esc>d
  tnoremap <a-f> <esc>f
endif
" ----------------------------------------------------------------------------
" Quickfix
" ----------------------------------------------------------------------------
nnoremap ]q :cnext<cr>zz
nnoremap [q :cprev<cr>zz
nnoremap ]l :lnext<cr>zz
nnoremap [l :lprev<cr>zz
" ----------------------------------------------------------------------------
" Buffers
" ----------------------------------------------------------------------------
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>
" ----------------------------------------------------------------------------
" Tabs
" ----------------------------------------------------------------------------
nnoremap ]t :tabn<cr>
nnoremap [t :tabp<cr>
" ----------------------------------------------------------------------------
" <tab> / <s-tab> | Circular windows navigation
" ----------------------------------------------------------------------------
nnoremap <tab>   <c-w>w:redraw!<CR>
nnoremap <S-tab> <c-w>W

" ----------------------------------------------------------------------------
" tmux
" ----------------------------------------------------------------------------
function! s:tmux_send(content, dest) range
  let dest = empty(a:dest) ? input('To which pane? ') : a:dest
  let tempfile = tempname()
  call writefile(split(a:content, "\n", 1), tempfile, 'b')
  call system(printf('tmux load-buffer -b vim-tmux %s \; paste-buffer -d -b vim-tmux -t %s',
        \ shellescape(tempfile), shellescape(dest)))
  call delete(tempfile)
endfunction

function! s:tmux_map(key, dest)
  execute printf('nnoremap <silent> %s "tyy:call <SID>tmux_send(@t, "%s")<cr>', a:key, a:dest)
  execute printf('xnoremap <silent> %s "ty:call <SID>tmux_send(@t, "%s")<cr>gv', a:key, a:dest)
endfunction

call s:tmux_map('<leader>tt', '')
call s:tmux_map('<leader>th', '.left')
call s:tmux_map('<leader>tj', '.bottom')
call s:tmux_map('<leader>tk', '.top')
call s:tmux_map('<leader>tl', '.right')
call s:tmux_map('<leader>ty', '.top-left')
call s:tmux_map('<leader>to', '.top-right')
call s:tmux_map('<leader>tn', '.bottom-left')
call s:tmux_map('<leader>t.', '.bottom-right')

" ----------------------------------------------------------------------------
" Markdown headings
" ----------------------------------------------------------------------------
nnoremap <leader>1 m`yypVr=``
nnoremap <leader>2 m`yypVr-``
nnoremap <leader>3 m`^i### <esc>``4l
nnoremap <leader>4 m`^i#### <esc>``5l
nnoremap <leader>5 m`^i##### <esc>``6l

" ----------------------------------------------------------------------------
" Moving lines
" ----------------------------------------------------------------------------
nnoremap <silent> <C-k> :move-2<cr>
nnoremap <silent> <C-j> :move+<cr>
nnoremap <silent> <C-h> <<
nnoremap <silent> <C-l> >>
xnoremap <silent> <C-k> :move-2<cr>gv
xnoremap <silent> <C-j> :move'>+<cr>gv
xnoremap <silent> <C-h> <gv
xnoremap <silent> <C-l> >gv
xnoremap < <gv
xnoremap > >gv
" ----------------------------------------------------------------------------
" <Leader>c Close quickfix/location window
" ----------------------------------------------------------------------------
nnoremap <leader>c :cclose<bar>lclose<cr>

" ----------------------------------------------------------------------------
" Readline-style key bindings in command-line (excerpt from rsi.vim)
" ----------------------------------------------------------------------------
cnoremap        <C-A> <Home>
cnoremap        <C-B> <Left>
cnoremap <expr> <C-D> getcmdpos()>strlen(getcmdline())?"\<Lt>C-D>":"\<Lt>Del>"
cnoremap <expr> <C-F> getcmdpos()>strlen(getcmdline())?&cedit:"\<Lt>Right>"
cnoremap        <M-b> <S-Left>
cnoremap        <M-f> <S-Right>
silent! exe "set <S-Left>=\<Esc>b"
silent! exe "set <S-Right>=\<Esc>f"

" ----------------------------------------------------------------------------
" #gi / #gpi | go to next/previous indentation level
" ----------------------------------------------------------------------------
function! s:go_indent(times, dir)
  for _ in range(a:times)
    let l = line('.')
    let x = line('$')
    let i = s:indent_len(getline(l))
    let e = empty(getline(l))

    while l >= 1 && l <= x
      let line = getline(l + a:dir)
      let l += a:dir
      if s:indent_len(line) != i || empty(line) != e
        break
      endif
    endwhile
    let l = min([max([1, l]), x])
    execute 'normal! '. l .'G^'
  endfor
endfunction
nnoremap <silent> gi :<c-u>call <SID>go_indent(v:count1, 1)<cr>
nnoremap <silent> gpi :<c-u>call <SID>go_indent(v:count1, -1)<cr>
" ----------------------------------------------------------------------------
" <leader>bs | buf-search
" ----------------------------------------------------------------------------
nnoremap <leader>bs :cex []<BAR>bufdo vimgrepadd @@g %<BAR>cw<s-left><s-left><right>


" ----------------------------------------------------------------------------
" #!! | Shebang
" ----------------------------------------------------------------------------
inoreabbrev <expr> #!! "#!/usr/bin/env" . (empty(&filetype) ? '' : ' '.&filetype)
"" clipbord map

vnoremap <C-c> "+y
vnoremap <C-d> "+d

""" move to html tab to insert word in normal mode
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>bv :vsplit ~/.bashrc<cr>
" ----------------------------------------------------------------------------

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

" ----------------------------------------------------------------------------
" :CopyRTF
" ----------------------------------------------------------------------------
function! s:colors(...)
  return filter(map(filter(split(globpath(&rtp, 'colors/*.vim'), "\n"),
        \                  'v:val !~ "^/usr/"'),
        \           'fnamemodify(v:val, ":t:r")'),
        \       '!a:0 || stridx(v:val, a:1) >= 0')
endfunction

" ----------------------------------------------------------------------------
" <F8> | Color scheme selector
" ----------------------------------------------------------------------------
function! s:rotate_colors()
  if !exists('s:colors')
    let s:colors = s:colors()
  endif
  let name = remove(s:colors, 0)
  call add(s:colors, name)
  execute 'colorscheme' name
  redraw
  echo name
endfunction
nnoremap <silent> <F8> :call <SID>rotate_colors()<cr>
" colorscheme gruvbox
" set background=dark
"}}}
" ============================================================================
" FUNCTIONS & COMMANDS {{{
" ============================================================================

" ----------------------------------------------------------------------------
" :NL
" ----------------------------------------------------------------------------
command! -range=% -nargs=1 NL
  \ <line1>,<line2>!nl -w <args> -s '. ' | perl -pe 's/^.{<args>}..$//'

" ----------------------------------------------------------------------------
" :Chomp
" ----------------------------------------------------------------------------
command! Chomp %s/\s\+$// | normal! ``

" ----------------------------------------------------------------------------
" :Count
" ----------------------------------------------------------------------------
command! -nargs=1 Count execute printf('%%s/%s//gn', escape(<q-args>, '/')) | normal! ``

" :M
" ----------------------------------------------------------------------------
command! M execute printf('!bundle exec m %s:%d', expand('%'), line('.'))

" ----------------------------------------------------------------------------
" SaveMacro / LoadMacro
" ----------------------------------------------------------------------------
function! s:save_macro(name, file)
  let content = eval('@'.a:name)
  if !empty(content)
    call writefile(split(content, "\n"), a:file)
    echom len(content) . " bytes save to ". a:file
  endif
endfunction
command! -nargs=* SaveMacro call <SID>save_macro(<f-args>)

function! s:load_macro(file, name)
  let data = join(readfile(a:file), "\n")
  call setreg(a:name, data, 'c')
  echom "Macro loaded to @". a:name
endfunction
command! -nargs=* LoadMacro call <SID>load_macro(<f-args>)
" ----------------------------------------------------------------------------
" ?ii / ?ai | indent-object
" ?io       | strictly-indent-object
" ----------------------------------------------------------------------------
function! s:indent_len(str)
  return type(a:str) == 1 ? len(matchstr(a:str, '^\s*')) : 0
endfunction

function! s:indent_object(op, skip_blank, b, e, bd, ed)
  let i = min([s:indent_len(getline(a:b)), s:indent_len(getline(a:e))])
  let x = line('$')
  let d = [a:b, a:e]

  if i == 0 && empty(getline(a:b)) && empty(getline(a:e))
    let [b, e] = [a:b, a:e]
    while b > 0 && e <= line('$')
      let b -= 1
      let e += 1
      let i = min(filter(map([b, e], 's:indent_len(getline(v:val))'), 'v:val != 0'))
      if i > 0
        break
      endif
    endwhile
  endif

  for triple in [[0, 'd[o] > 1', -1], [1, 'd[o] < x', +1]]
    let [o, ev, df] = triple

    while eval(ev)
      let line = getline(d[o] + df)
      let idt = s:indent_len(line)

      if eval('idt '.a:op.' i') && (a:skip_blank || !empty(line)) || (a:skip_blank && empty(line))
        let d[o] += df
      else | break | end
    endwhile
  endfor
  execute printf('normal! %dGV%dG', max([1, d[0] + a:bd]), min([x, d[1] + a:ed]))
endfunction
xnoremap <silent> ii :<c-u>call <SID>indent_object('>=', 1, line("'<"), line("'>"), 0, 0)<cr>
onoremap <silent> ii :<c-u>call <SID>indent_object('>=', 1, line('.'), line('.'), 0, 0)<cr>
xnoremap <silent> ai :<c-u>call <SID>indent_object('>=', 1, line("'<"), line("'>"), -1, 1)<cr>
onoremap <silent> ai :<c-u>call <SID>indent_object('>=', 1, line('.'), line('.'), -1, 1)<cr>
xnoremap <silent> io :<c-u>call <SID>indent_object('==', 0, line("'<"), line("'>"), 0, 0)<cr>
onoremap <silent> io :<c-u>call <SID>indent_object('==', 0, line('.'), line('.'), 0, 0)<cr>

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


 
" Map Ctrl + p to open fuzzy find (FZF)
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

function! My_runner(opts)
    let g:test = "success"
endfunction

let g:asyncrun_runner = get(g:, 'asyncrun_runner', {})
let g:asyncrun_runner.test = function('My_runner')
" ----------------------------------------------------------------------------
" goyo.vim + limelight.vim
" ----------------------------------------------------------------------------
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_paragraph_span = 1
let g:limelight_priority = -1

function! s:goyo_enter()
  if has('gui_running')
    set fullscreen
    set background=light
    set linespace=7
  elseif exists('$TMUX')
    silent !tmux set status off
  endif
  Limelight
  let &l:statusline = '%M'
  hi StatusLine ctermfg=red guifg=red cterm=NONE gui=NONE
endfunction

function! s:goyo_leave()
  if has('gui_running')
    set nofullscreen
    set background=dark
    set linespace=0
  elseif exists('$TMUX')
    silent !tmux set status on
  endif
  Limelight!

endfunction
autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

nnoremap <Leader>G :Goyo<CR>
"}}}

" ============================================================================
" WSL yank support 
" ============================================================================
" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif
" ============================================================================
"<Leader>g google it 
" ============================================================================
function s:goog(pat)
  let q = '"'.substitute(a:pat, '[[:space:]]', '+', 'g').'"'
  let g:q = q
call system("powershell.exe start chrome \"www.google.com/search?q=\"".q)
redraw!
endfunction
xnoremap <leader>g "gy:call <SID>goog(@g)<cr>gv
" ============================================================================
" Z && TZ
" ============================================================================
function! ZComp(ArgLead, CmdLine, CursorPos)
  let l:list = systemlist("cat ~/.zlua")
  let l:home = $HOME
  for i in range(len(l:list))
    let l:list[i] = split(l:list[i],"|")[0]
    let l:list[i] = substitute(l:list[i],l:home,"~","g")
  endfor
  return filter(l:list,'v:val =~ a:ArgLead')
  " return filter(systemlist("cat ~/.zlua | awk -F \"|\" '{print $1;}'"), 'v:val =~ a:ArgLead')
endfunction

function! ZFunc(arg)
  execute "tcd " . a:arg
endfunction

function! TZFunc(arg)
  execute "tabnew"
  execute "tcd " . a:arg
endfunction

function! LZFunc(arg)
  execute "vertical botright 80new"
  execute "lcd " . a:arg
endfunction

command! -nargs=1 -complete=customlist,ZComp Zt call TZFunc(<f-args>)
command! -nargs=1 -complete=customlist,ZComp Z call ZFunc(<f-args>)
command! -nargs=1 -complete=customlist,ZComp Zl call LZFunc(<f-args>)

" ============================================================================
"open/close terminal 
" ============================================================================
" função para colocar um terminal dentro do vim
function Terminal()
  " verificar se o terminal está aberto
  let terminal = bufname('bash')
  if terminal == ''
    below terminal ++rows=10
  else
    let bnr = bufnr(terminal)
    exec ':bwipe! ' bnr
  endif
endfunction

" mapeando uma tecla para abrir um terminal
map <c-t> :call Terminal()<cr>
autocmd TerminalOpen * if &buftype == 'terminal' | setlocal nobuflisted | endif
tnoremap  <Esc> <C-\><C-n>
" ============================================================================
"set tabline 
" ============================================================================
function! CustomizedTabLine()
    let s = ''
    let t = tabpagenr()
    let i = 1
    while i <= tabpagenr('$')
        let buflist = tabpagebuflist(i)
        let winnr = tabpagewinnr(i)
        let s .= '%' . i . 'T'
        let s .= (i == t ? '%1*' : '%2*')
        let s .= ' '
        let s .= i . ':'
        let s .= '%*'
        let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
        let file = bufname(buflist[winnr - 1])
        let file = fnamemodify(file, ':p:t')
        if file == ''
            let file = '[No Name]'
        endif
        let s .= file
        let s .= ' '
        let i = i + 1
    endwhile
    let s .= '%T%#TabLineFill#%='
    let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
    return s
endfunction

" Always show the tablilne 
set stal=2
set tabline=%!CustomizedTabLine()

" ============================================================================
"  fuzzy find leaderf {{{
" ============================================================================
" leaderf
" ----------------------------------------------------------------------------
nnoremap <leader>t :LeaderfBufTag<CR> 
" don't show the help in normal mode
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1
" popup mode
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }
let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }

let g:Lf_ShortcutF = "<leader>ff"
noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>

noremap <C-B> :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR>
noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
" search visually selected text literally
xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
noremap go :<C-U>Leaderf! rg --recall<CR>

" should use `Leaderf gtags --update` first
let g:Lf_GtagsAutoGenerate = 0
let g:Lf_Gtagslabel = 'native-pygments'
noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>
" }}}
" ============================================================================
" FZF {{{
" ============================================================================

let $FZF_DEFAULT_OPTS .= ' --inline-info'

" All files
command! -nargs=? -complete=dir AF
  \ call fzf#run(fzf#wrap(fzf#vim#with_preview({
  \   'source': 'fd --type f --hidden --follow --exclude .git --no-ignore . '.expand(<q-args>)
  \ })))

let g:fzf_colors =
\ { 'fg':         ['fg', 'Normal'],
  \ 'bg':         ['bg', 'Normal'],
  \ 'preview-bg': ['bg', 'NormalFloat'],
  \ 'hl':         ['fg', 'Comment'],
  \ 'fg+':        ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':        ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':        ['fg', 'Statement'],
  \ 'info':       ['fg', 'PreProc'],
  \ 'border':     ['fg', 'Ignore'],
  \ 'prompt':     ['fg', 'Conditional'],
  \ 'pointer':    ['fg', 'Exception'],
  \ 'marker':     ['fg', 'Keyword'],
  \ 'spinner':    ['fg', 'Label'],
  \ 'header':     ['fg', 'Comment'] }

if exists('$TMUX')
  let g:fzf_layout = { 'tmux': '-p90%,60%' }
else
  let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
endif

" nnoremap <silent> <Leader><Leader> :Files<CR>
nnoremap <silent> <expr> <Leader><Leader> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"
nnoremap <silent> <Leader>C        :Colors<CR>
" noremap <silent> <leader>b :<C-U><C-R>=printf("Buffers %s ", execute("pwd"))<CR><CR>
" nnoremap <silent> <Leader>B  :Buffers<CR>
nnoremap <silent> <Leader>L        :Lines<CR>
nnoremap <silent> <Leader>ag       :Ag <C-R><C-W><CR>
nnoremap <silent> <Leader>AG       :Ag <C-R><C-A><CR>
xnoremap <silent> <Leader>ag       y:Ag <C-R>"<CR>
nnoremap <silent> <Leader>`        :Marks<CR>
" nnoremap <silent> q: :History:<CR>
" nnoremap <silent> q/ :History/<CR>

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
inoremap <expr> <c-x><c-d> fzf#vim#complete#path('blsd')
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" nmap <leader><tab> <plug>(fzf-maps-n)
" xmap <leader><tab> <plug>(fzf-maps-x)
" omap <leader><tab> <plug>(fzf-maps-o)

function! s:plug_help_sink(line)
  let dir = g:plugs[a:line].dir
  for pat in ['doc/*.txt', 'README.md']
    let match = get(split(globpath(dir, pat), "\n"), 0, '')
    if len(match)
      execute 'tabedit' match
      return
    endif
  endfor
  tabnew
  execute 'Explore' dir
endfunction

command! PlugHelp call fzf#run(fzf#wrap({
  \ 'source': sort(keys(g:plugs)),
  \ 'sink':   function('s:plug_help_sink')}))

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let options = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  let options = fzf#vim#with_preview(options, 'right', 'ctrl-/')
  call fzf#vim#grep(initial_command, 1, options, a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" }}}
execute "silent e! /tmp/bufferList.hideseek"
let g:auto_save = 0
augroup ft_hideseek
  au!
  au FileType hideseek let b:auto_save = 1
augroup END
nnoremap ZZ :execute "wqa"<cr>

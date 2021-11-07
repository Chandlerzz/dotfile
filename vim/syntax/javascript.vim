setlocal completefunc=CompleteJson
let b:complete_head="0" 
let b:special_head="rows"

"from syntax/json.vim
" syn region  jsonFold matchgroup=jsonBraces start="\(default \|Controller \|=> \)\@<!{" end=/}a/ transparent fold
" syn region  jsonFold matchgroup=jsonBraces start="\[" end=/]\(\_s\+\ze"\)\@!/ transparent fold

" syn region importfold start="\(import\|require\)" end="^$" fold 

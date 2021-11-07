if !exists("main_syntax")
  " quit when a syntax file was already loaded
  if exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'diary'
elseif exists("b:current_syntax") && b:current_syntax == "diary"
  finish
endif

let s:cpo_save = &cpo
set cpo&vim


syn keyword javaScriptCommentTodo      TODO 
syn keyword javaScriptConditional       DONE 	

" Define the default highlighting.
" Only when an item doesn't have highlighting yet
hi def link javaScriptCommentTodo	  GruvboxFg3  	
hi def link javaScriptConditional		Conditional


let b:current_syntax = "diary"
if main_syntax == 'diary'
  unlet main_syntax
endif
let &cpo = s:cpo_save
unlet s:cpo_save
setlocal nonumber
setlocal norelativenumber
nnoremap <localleader>c :execute 'DiaryState'<CR>
noremap <localleader>v :<C-U><C-R>=printf("DiarySort %s ", expand("<cword>"))<CR>

" vim: ts=8

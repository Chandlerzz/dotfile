setlocal completefunc=CompleteJson
" if value = 0 no head such as result[0]
" if value = 1 head included
" special_head="rows" head will be substituded with the special_head
let b:complete_head="0" 
let b:special_head="rows"


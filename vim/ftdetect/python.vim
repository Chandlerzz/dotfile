"au BufRead,BufNewFile *.py set filetype=py
let currentline=0
function! Comment()
let [lnum1, col1] = getpos("'<")[1:2]
let [lnum2, col2] = getpos("'>")[1:2]
if g:currentline == 0
    let g:currentline = lnum1
endif
execute g:currentline
let line = getline(g:currentline)
if line[0] != "#"
    execute "s/^/#/g"
else
    execute "s/^#//g"
endif
if g:currentline == lnum2
    let g:currentline=0
else
    let g:currentline += 1
endif
"python3 << EOF
"from vim import *
"str1=current.line
"if str1[0] == "/":
"    current.line = str1[2:]
"    print(current.line)
"else:
"    current.line ="//"+ current.line
"    print(current.line)
"EOF
endfunction
"autocmd FileType python vnoremap <buffer> <localleader>c :s/^/#/g<CR>
"autocmd FileType python vnoremap <buffer> <localleader>b :s/^#//g<CR>
autocmd FileType python vnoremap <buffer> <localleader>v :call Comment()<CR>
    
    

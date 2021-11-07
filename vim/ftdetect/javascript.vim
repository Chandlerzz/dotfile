"au BufRead,BufNewFile *.js set filetype=js
autocmd FileType javascript nnoremap <buffer> <localleader>v :Setcomment<CR>
"autocmd FileType javascript inoremap <buffer> <localleader>v :Setcomment<CR>
autocmd FileType javascript vnoremap <buffer> <localleader>v :SetcommentV<CR>
" let javaScript_fold=1

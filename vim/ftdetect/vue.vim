"this is file for vue 
autocmd FileType vue nnoremap <buffer> <localleader>v :Setcomment<CR>
autocmd FileType vue vnoremap <buffer> <localleader>v :call SET_COMMENTV()<CR>
autocmd FileType vue nnoremap <silent> <buffer> <localleader>c :call search('=\"[^{]','')<CR>w
" autocmd FileType vue nnoremap <silent> <buffer> <localleader>s :call search('{{','')<CR>w


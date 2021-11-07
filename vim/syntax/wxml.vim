nnoremap <localleader>f :execute 'JumpFromWxmlToWxssForSearch'<CR>
nnoremap <silent> <buffer> <localleader>c :call search('=\"[^{]','')<CR>w
nnoremap <silent> <buffer> <localleader>s :call search('{{','')<CR>w
" todo 
" first to open the reame directory wxss file and goto gotto the line searched
"get the absolutepath and find hte wxss and then vsp the wxss file 

function! JumpFromWxmlToWxssForSearch()
    let currentword=expand("<cword>")
    execute "normal F=b"
    let istype =expand('<cword>')
    let bufnr = bufnr()
    let $filepath=expand('#'.bufnr.':p:r')
    echo istype
    if istype == 'class' 
        let $filepath=$filepath.".wxss"
    else
        let $filepath=$filepath.".js"
    endif
    execute "normal \<c-w>o"
    execute ":vsp".$filepath
    execute ":Sch ".currentword
    execute "normal zo"
endfunction
command! -nargs=0 JumpFromWxmlToWxssForSearch :call JumpFromWxmlToWxssForSearch()



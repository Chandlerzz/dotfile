"register
augroup getlocalvimrc
    au!
    autocmd tabEnter * call s:getlocalvimrc()
augroup END

" generate "(a-z)y to "(a-z)y:call MoveRegisters() 
for i in range(97,122)
    let character = nr2char(i)
    execute "noremap \"".character."y \"".character."y:call MoveRegisters()<CR>"
endfor

function! s:getlocalvimrc()
    let $pwd = getcwd()
    let $vimrcfile = $pwd . "/chandler.vimrc"
    if filereadable($vimrcfile)
        execute "source " . $vimrcfile
        call s:updateRegisters()
    endif
endfunction
function! s:updateRegisters()
    let $filename = "/tmp/registers"
    for i in range(97,122)
        let character = nr2char(i)
        let register = getreg(character)
        "需要把register中一些delete字符转义
        let register = substitute(register,"\"","","g")
        let register = substitute(register,"\n","","g")
        let register = substitute(register,"\*","","g")
        if(character == "a")
            execute "silent ! echo ".character.":\"".register."\" > " . $filename
        else
            if(register !="")
                execute "silent ! echo ".character.":\"".register."\" >> " . $filename
            endif
        endif
    endfor
    execute "redraw!"
endfunction
function! MoveRegisters()
    let $filename = g:registerWatchFile
    for i in range(97,122)
        let character = nr2char(i)
        let register = getreg(character)
        "需要把register中一些delete字符转义
        let register = substitute(register,"\"","","g")
        let register = substitute(register,"\n","","g")
        let register = substitute(register,"\*","","g")
        if character=="a"
            execute "silent ! echo a:\"".register."\" > " . $filename
        else
            if(register !="")
                execute "silent ! echo ".character.":\"".register."\" >> " . $filename
            endif
        endif
    endfor
    execute "redraw!"
endfunction


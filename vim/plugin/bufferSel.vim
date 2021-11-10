" bufferSel
nnoremap <expr> e SelectBuffer() ..'_'
" xnoremap <expr> <F4> SelectBuffer()
" doubling <F4> works on a line
" nnoremap <expr> <F4><F4> CountSpaces() .. '_'
nnoremap  <leader>bb :execute 'Bss'<CR>
" nnoremap <leader>SetTcd :execute 'SetTcd'<CR>
augroup bufferSel
    au!
    autocmd tabEnter * call TabPath()
    autocmd bufEnter * call LRCread()
    autocmd bufEnter,tabEnter * call BufferRead()
augroup END

function! LRCread()
    let $pwd= getcwd()
    let $lrcfilename = g:LRCfileName
    let currbufnr = bufnr("%")
    let currbufname = expand('#'.currbufnr.':p') 
    if (currbufname == "")
        execute "" 
    elseif (match(currbufname,"/tmp")> -1)
        execute "" 
    elseif (match(currbufname,"/.git")> -1)
        execute "" 
    else
          execute "silent ! echo ".currbufname." >> " . $lrcfilename
    endif
    let job = job_start("sh ". expand("~/dotfile/vim/script/LRC.sh") ." ". $lrcfilename ." " . $pwd,
                \ {"in_io": "null", "out_io": "null", "err_io": "null"})
endfunction
function! TabPath()
    let pwd= getcwd()
    set path = ""
    for $gpath in g:globalpath
        set path+=$gpath
    endfor
    for $lpath in g:localpath
        if (match($lpath,pwd) > -1)
             set path+=$lpath
        endif
    endfor
endfunction
function! BufferRead()
    let pwd= getcwd()
    let $bufferListFileName = g:bufferListFileName
    let g:test1 = $bufferListFileName
    execute "silent !echo ".pwd." >" . $bufferListFileName
    let bufcount = bufnr("$")
    let currbufnr = 1
    let nummatches = 1
    let firstmatchingbufnr = 0
    while currbufnr <= bufcount
        if(bufexists(currbufnr))
          let currbufname = expand('#'.currbufnr.':p') 
          if(match(currbufname, pwd) > -1)
            let bufname = currbufnr . ": ".expand('#'.currbufnr.':p:.')
            let nummatches += 1
            execute "silent ! echo ".bufname." >> " . $bufferListFileName
          endif
        endif
        let currbufnr = currbufnr + 1
    endwhile
endfunction
function! s:newTab()
    execute ":tabnew"
    execute ":tabnew"
    let @b="-SetTcdgt"
endfunction
function! s:bufSelPwd()
    let pwd=getcwd()
    call s:bufSel(pwd)
endfunction
function! s:setTcd()
    let tabPageNr = tabpagenr()
    execute "tcd " .g:tabpath[tabPageNr-1]
endfunction
function! s:bufSel(pattern)
  let bufcount = bufnr("$")
  let currbufnr = 1
  let nummatches = 0
  let firstmatchingbufnr = 0
  while currbufnr <= bufcount
    if(bufexists(currbufnr))
      let currbufname = expand('#'.currbufnr.':p') 
      if(match(currbufname, a:pattern) > -1)
        echo currbufnr . ": ".expand('#'.currbufnr.':p:.')
        let nummatches += 1
        let firstmatchingbufnr = currbufnr
      endif
    endif
    let currbufnr = currbufnr + 1
  endwhile
  if(nummatches == 1)
    execute ":buffer ". firstmatchingbufnr
  elseif(nummatches > 1)
    let desiredbufnr = input("Enter buffer number: ")
    if(strlen(desiredbufnr) != 0)
      execute ":buffer ". desiredbufnr
    endif
  else
    echo "No matching buffers"
  endif
endfunction

function SelectBuffer(type = '') abort
  if a:type == ''
    set opfunc=SelectBuffer
    return 'g@'
  endif

  let sel_save = &selection
  let reg_save = getreginfo('"')
  let g:aaa=reg_save
  let cb_save = &clipboard
  let visual_marks_save = [getpos("'<"), getpos("'>")]

  try
    set clipboard= selection=inclusive
    let commands = #{line: "'[V']y", char: "`[v`]y", block: "`[\<c-v>`]y"}
    silent exe 'noautocmd keepjumps normal! ' .. get(commands, a:type, '')
    " echom getreg('"')->count(' ')
  finally
  let charr = s:inputtarget()
  let head=charr[:-2]
  let tail=charr[-1:-1]
  let g:aa=head
  let g:bb=tail
  if tail =~ "e"
      silent exe 'e #' ..head 
  else
      silent exe 'vsp #' ..head 
  endif
    call setreg('"', reg_save)
    call setpos("'<", visual_marks_save[0])
    call setpos("'>", visual_marks_save[1])
    let &clipboard = cb_save
    let &selection = sel_save
endtry
endfunction

function! s:getchar()
  let c = getchar()
  if c =~ '^\d\+$'
    let c = nr2char(c)
  endif
  return c
endfunction
function! s:inputtarget()
  let c = s:getchar()
  while c =~ '^\d\+$'
    let c .= s:getchar()
  endwhile
  if c == " "
    let c .= s:getchar()
  endif
  if c =~ "\<Esc>\|\<C-C>\|\0"
    return ""
  else
    return c
  endif
endfunction

"Bind the s:bufSel() function to a user-command
command! -nargs=1 Bs :call s:bufSel("<args>")
command! -nargs=0 Bss :call s:bufSelPwd()
command! -nargs=0 NewTab :call s:newTab()
" command! -nargs=0 SetTcd :call s:setTcd()
nnoremap <silent> <Plug>SetTcd  :<C-U>call <SID>setTcd()<CR>
nmap <leader>SetTcd <Plug>SetTcd
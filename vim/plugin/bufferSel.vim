" bufferSel
nnoremap <expr> e SelectBuffer("") ..'_'
nnoremap <leader>e :call OpenBufferList()<cr>
let s:bufname = "/tmp/bufferList/".rand().".hideseek"
augroup bufferSel
    au!
     autocmd bufEnter * call LRCread()
     autocmd bufEnter,tabEnter * call BufferRead()
augroup END

function! OpenBufferList()
  let activebuffers = tabpagebuflist("'")
  let bufnr = bufnr('bufferList')
  let filterbuffers = filter(copy(activebuffers),'v:val == bufnr')
  if len(filterbuffers) == 1
    for i in range(winnr('$')+1)
      if winbufnr(i) == bufnr
        execute i."wincmd c"
        redraw
      endif
    endfor
  else
    execute "vert botright sbuffer ".bufnr." \| vert resize 40"
    setlocal nonumber norelativenumber  nobuflisted noswapfile nowrap
    \ modifiable statusline=>\ Buffers nocursorline nofoldenable
    execute "wincmd p"
  endif
endfunction
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
    let l:command = "sh ". expand("~/dotfile/vim/script/LRC.sh") ." ". $lrcfilename ." " . $pwd
    if has("nvim")
        let job = jobstart(l:command, {"in_io": "null", "out_io": "null", "err_io": "null"})
    else
        let job = job_start(l:command, {"in_io": "null", "out_io": "null", "err_io": "null"})
    end
endfunction

function! BufferRead()
    let pwd= getcwd()
    let bufnr = bufadd(s:bufname)
    call bufload(bufnr)
    let linenr = len(getbufline(bufnr,1,'$'))
    call s:clearAllLines(bufnr,linenr)
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
            call setbufline(bufnr,nummatches,bufname)
          endif
        endif
        let currbufnr = currbufnr + 1
    endwhile
    " silent! wa
endfunction


function SelectBuffer(type) abort
  if a:type == ''
    set opfunc=SelectBuffer
    return 'g@'
  endif

  let sel_save = &selection
  if has("nvim")
      let reg_save = @@
  else
      let reg_save = getreginfo('"')
  end
  let cb_save = &clipboard
  let visual_marks_save = [getpos("'<"), getpos("'>")]

  try
    set clipboard= selection=inclusive
  finally
  let charr = s:inputtarget()
  let head=charr[:-2]
  let tail=charr[-1:-1]
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

function s:clearAllLines(bufnr,linenr)
  let bufnr = a:bufnr
  let linenr = a:linenr
  if (linenr == 0 )
    return 0
  endif
  call setbufline(bufnr,linenr,"")
  let linenr = linenr - 1
  return  s:clearAllLines(bufnr,linenr)
endfunction



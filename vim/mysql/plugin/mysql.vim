let s:plugin_root_dir = fnamemodify(resolve(expand('<sfile>:p')), ':h')

python3 << EOF
import sys
from os.path import normpath, join
import vim
plugin_root_dir = vim.eval('s:plugin_root_dir')
python_root_dir = normpath(join(plugin_root_dir, '..', 'python'))
sys.path.insert(0, python_root_dir)
import vmysql

EOF

fun! TestPy()
    python3 vmysql.new_window()
endfun
fun! NewWindow(nickname)
    python3 vmysql.new_window(vim.eval('a:nickname'))
endfun

fun! QueryResult(type = '')
  if a:type == ''
    set opfunc=QueryResult
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
    echom getreg('"')->count(' ')
    let g:mysql_stmt = getreg('"')
    python3 vmysql.send_message()
    execute "redraw!"
  finally
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
func! s:sourceConfigFile()
    execute "source %"
endfun

command! -nargs=0 ShowCreateTable :call s:showCreateTable()
command! -nargs=1 NewWindow call NewWindow('<args>')

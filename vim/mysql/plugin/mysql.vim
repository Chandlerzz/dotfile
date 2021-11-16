augroup mysql
    au!
    autocmd bufLeave mysql.vimrc call s:login()
augroup END
fun! s:login()
    execute "source " . g:mysqlvimrc
    let name = g:sql_name
    let database = g:sql_database
    let config = {"config":{"name": g:sql_name,"database": g:sql_database}}
    let configStr = string(config)
	let channel = ch_open('localhost:8765')
	let response = ch_evalexpr(channel, configStr)
    let $stmt = "quit;"
    let $mysql_expect = g:mysql_expect
    silent !expect $HOME$mysql_expect "$stmt" 
    let $stmt1 = "mymysql ".name
    silent !expect $HOME$mysql_expect "$stmt1" 
    let $stmt2 = "use " . database.";" 
    silent !expect $HOME$mysql_expect "$stmt2" 
    execute "redraw!"
    
endfun
fun! s:showCreateTable()
    let tableName = {"tableName":expand("<cword>")}
    let tableNameStr = string(tableName)
	let channel = ch_open('localhost:8765')
	let response = ch_evalexpr(channel, tableNameStr)
    execute "split /tmp/createTableInfo.mysql"
endfun
fun! QueryResult(type = '')abort
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
    let $mysql_expect = g:mysql_expect
    set clipboard= selection=inclusive
    let commands = #{line: "'[V']y", char: "`[v`]y", block: "`[\<c-v>`]y"}
    silent exe 'noautocmd keepjumps normal! ' .. get(commands, a:type, '')
    echom getreg('"')->count(' ')
    let stmt = {"stmt":getreg('"')} 
    let stmt = getreg('"')
    let stmt = substitute(stmt,"\\n","","g")
    let $stmt = substitute(stmt,"\\s\\+"," ","g")
    silent !expect $HOME$mysql_expect "$stmt"
    execute "silent !tmux select-pane -t 2"
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
command! -nargs=0 LoginMysql :call s:login()

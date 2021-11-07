augroup mysql
    au!
    autocmd bufLeave mysql.vimrc call s:login()
augroup END
fun! s:login()
    execute "source ~/mysql/mysql.vimrc"
    let name = g:sql_name
    let database = g:sql_database
    let config = {"config":{"name": g:sql_name,"database": g:sql_database}}
    let configStr = string(config)
	let channel = ch_open('localhost:8765')
	let response = ch_evalexpr(channel, configStr)
    let stmt = "\"quit;\""
    let g:stmt = stmt
    execute "silent !expect /home/chandler/dotfile/vim/mysql/mysql_expect " . stmt
    let stmt1 = "\"mymysql " . name. "\""
    let g:stmt1 = stmt1
    execute "silent !expect /home/chandler/dotfile/vim/mysql/mysql_expect " . stmt1
    let stmt2 = "\"use " . database. ";\""
    let g:stmt2 = stmt2
    execute "silent !expect /home/chandler/dotfile/vim/mysql/mysql_expect " . stmt2
    
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
    set clipboard= selection=inclusive
    let commands = #{line: "'[V']y", char: "`[v`]y", block: "`[\<c-v>`]y"}
    silent exe 'noautocmd keepjumps normal! ' .. get(commands, a:type, '')
    echom getreg('"')->count(' ')
    let stmt = {"stmt":getreg('"')} 
    let stmt = getreg('"')
    let stmt = substitute(stmt,"\\n","","g")
    let stmt = substitute(stmt,"\\s\\+"," ","g")
    execute "silent !expect /home/chandler/dotfile/vim/mysql/mysql_expect " . "\"" .stmt."\""
    execute "silent !tmux select-window -t mysql"
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

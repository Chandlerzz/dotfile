" program diary
" Fri 30 Jul 2021 04:41:57 PM CST
" 文件尾缀为.diary
" 第一种排序为按照顺序
" 第二种排序为按照 done todo 排序
" 在两种排序中转换
" 状态 done 已完成 todo 未完成
" done 后面跟日期 日期格式为 30/07/21
" color: done blue todo white
nnoremap <leader>dv :Diary<CR>

function s:statemachine() abort
    let currentword=expand("<cword>")
    let content=getline('.')
    if (currentword == "TODO")
        let diary = system("date +'%Y/%m/%d'")
        let content = substitute(content,"TODO","DONE","")
        let content = content . diary
        let nulls = setline('.',content)
        execute "%s\/[\\x0]\/\/g"
    endif
    if (currentword == "DONE")
    let content = system(" perl -e 'my $str = qq(" . content . "); $str =~ s/([0-9]\+[\\\/][0-9]\+[\\\/][0-9]\+)//; print $str;'")
        let content = substitute(content,"DONE","TODO","")
        let nulls = setline('.',content)
    endif
endfunction

function s:sort(state) abort
  let state = a:state
  let lineCount = line("$")
  let currlinenr = 1
  let nummatches = 0
  while currlinenr <= lineCount
      if(match(getline(currlinenr),state)) 
          let nummatches =nummatches + 1 
          let result = setline(lineCount + nummatches,getline(currlinenr))
          let result = setline(currlinenr,"")
      endif
    let currlinenr = currlinenr + 1
  endwhile
  execute "g/^$/d"
endfunction

function s:restore() abort
    let lineCount = line("$")
    let currlinenr = 1
    let nummatches = 0
    let sourcelist = []
    while currlinenr <= lineCount
        let digits = system(" perl -e 'my $str = qq(" . getline(currlinenr) . "); my ($first_num) = $str =~ /([0-9]\+[.]\?[0-9]\?)/; print $first_num;'")
        if (digits != "")
            let nulls =  add(sourcelist,[currlinenr,digits,getline(currlinenr)])
        endif
        let currlinenr = currlinenr + 1
    endwhile
    for i in range(len(sourcelist))
        let value = sourcelist[i][1] 
        let key = sourcelist[i]
        let j = i-1
        while j >=0 && value < sourcelist[j][1] 
           let sourcelist[j+1] = sourcelist[j] 
           let j = j - 1
           let sourcelist[j+1] = key 
        endwhile
    endfor
    for i in range(len(sourcelist))
        let nulls = setline(i+1,sourcelist[i][2])
    endfor
endfunction
function s:restorecplugin() abort
    let $pwd= getcwd()
    execute "silent !insertsort ".$pwd
    execute "redraw!"
    execute "e!"

endfunction

function s:diary() abort
    let diary = system("date +'%Y/%m/%d'")
    let diary = substitute(diary,'[[:cntrl:]]','','g')
    let $diarypath = g:diarybasepath . diary . ".diary"
    let $diaryshellscript = g:diaryshellscript
    silent !bash $HOME$diaryshellscript
    execute "split $diarypath"
    execute "redraw!"
endfunction

command -nargs=0  Diary        call s:diary() 
command -nargs=0  DiaryRestore call s:restore() 
command -nargs=0  DiaryRestoreCplugin call s:restore() 
command -nargs=1  DiarySort    call s:sort("<args>")
command -nargs=0  DiaryState    call s:statemachine()

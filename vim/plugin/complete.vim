fun! CompleteJson(findstart, base)

  if a:findstart
    " locate the start of the word
    let line = getline('.')
    let start = col('.') - 1
    while start > 0 && line[start - 1] =~ '\a'
      let start -= 1
    endwhile
    return start
  else
      let g:completefiletype=&filetype
    " find months matching with "a:base"
    call s:docomplete()
    " for m in split("Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec")
    let res=[]
    for m in g:completediy 
      if m =~ a:base
    call add(res, m)
      endif
    endfor
    return res
  endif
endfun
fun! s:docomplete()
python3 << EOF
import vim
import json
import os
from IPython import embed
import re
from jsonwalk import jsonwalk
filet = vim.vars['completefiletype']
cb = vim.current.buffer
complete_head = cb.vars['complete_head']
special_head = cb.vars['special_head']
special_head = special_head.decode()

jwalk = jsonwalk('/tmp/aa.json')
jwalk.open()
lists = jwalk.walk('result')
if (filet == b'javascript') | (filet == b'vue'):
    for index in range(len(lists)):
        item=lists[index]
        item1=jwalk.python2javascript(item)
        lists[index]=item1
if (complete_head == b'0'):
    lists = [re.sub("result(\[\d*\])?(\.)?","",li) for li in lists]
else:
    if (special_head != ""):
        lists = [re.sub("result(\[\d*\])?",special_head,li) for li in lists]
vim.vars["completediy"]=lists
EOF
endfun


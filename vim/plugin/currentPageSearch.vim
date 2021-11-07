"" bufferSel
nnoremap <leader>mm :execute 'Sch '.expand("<cword>")<CR>

function! s:search(pattern)
  let @/ = a:pattern 
  let bufLineCount = line("$") 
  let currLineNr = 1
  let nummatches = 0
  let firstMatchingLineNr = 0
  while currLineNr <= bufLineCount 
      let currComtent = getline(currLineNr)
      if(match(currComtent,a:pattern) > -1)
          echo currLineNr . ": ". getline(currLineNr)
          let nummatches += 1
          let firstmatchingbufnr = currLineNr
      endif
      let currLineNr = currLineNr + 1
  endwhile
  if(nummatches == 1)
    execute ":". firstmatchingbufnr
  elseif(nummatches > 1)
    let desiredLineNr = input("Enter line  number: ")
    if(strlen(desiredLineNr) != 0)
      execute ":". desiredLineNr 
    endif
  else
    echo "No matching search"
  endif
endfunction

"Bind the BufSel() function to a user-command
command! -nargs=1 Sch :call s:search("<args>")

command! -nargs=0 Setcomment call s:SET_COMMENT()
command! -nargs=0 SetcommentV call s:SET_COMMENTV()

function! s:SET_COMMENT()
    let lindex=line(".")
    let str=getline(lindex)
    let CommentMsg=s:IsComment(str)
    call s:SET_COMMENTV_LINE(lindex,CommentMsg[1],CommentMsg[0])
endfunction
let flag = 0
function! s:SET_COMMENTV()
    let lbeginindex=line("'<") 
    let lendindex=line("'>") 
    for i in range(lbeginindex, lendindex)
        let str=getline(i)
        let CommentMsg=s:IsComment(str)
        call s:SET_COMMENTV_LINE(i,CommentMsg[1],CommentMsg[0])
        let i += 1
    endfor
endfunction

function! s:SET_COMMENTV_LINE( index,pos, comment_flag )
    let poscur = [0, 0,0, 0]
    let poscur[1]=a:index
    let poscur[2]=a:pos+1
    call setpos(".",poscur) 

    if a:comment_flag==0
        exec "normal! i//"
    else
        exec "normal! xx"
    endif
endfunction

function! s:IsComment(str)
    let ret= [0, 0] 
    let i=0
    let strlen=len(a:str)
    while i <= strlen 
    if !(a:str[i]==' ' || a:str[i] == ' ' )
        let ret[1]=i
        if a:str[i]=='/' && a:str[i+1]=='/'
            let ret[0]=1
        else
            let ret[0]=0
        endif
        return ret
    endif
    let i=i+1
    endwhile
    return [0,0] 
endfunction

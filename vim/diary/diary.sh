#!/usr/bin/bash

function create {
    if [ -d "~/report" ];
        then mkdir ~/report;
    fi
    prevfile=""
    findprevdate
    currentdate="$(date +'%Y/%m/%d')"
    file=$HOME/report/$currentdate.diary
    [[ -f $prevfile ]] && echo 21 >> /dev/null  || mkdir -p "${prevfile%/*}" && touch $prevfile
    [[ -f $file ]] && echo 11 >>/dev/null ||  copyFile
}
function copyFile {
    mkdir -p "${file%/*}" && cp "${prevfile}" "${file}"
}
function findprevdate {
    num=1
    flag=true
    while $flag;
    do
        prevdate="$(date  +"%Y/%m/%d" -d  "-${num} days")"
        prevfile=$HOME/report/$prevdate.diary
        [[ -f $prevfile ]]  && flag=false || echo 10 >> /dev/null 
        ((num++))
    done
    return 1
}

[[ $HOME == "/home/chandler" ]] && create
[[ $HOME == "/home/chandlerxu" ]] && create

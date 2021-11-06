#!/bin/bash
monitorfile(){
  bb="";
  while [[ "$#" -gt 0 ]] 
    do
    	case $1 in
    		-f | --file) 
    			shift
    			file=$1
    			;;
    		-t | --tail)
    			shift
    			tail=$@
    			;;
    esac
    shift
    done
    
  while :; 
   	do
   		aa=$(stat -t $file | awk '{print $12}')
      [[ $aa -eq $bb ]] && sleep 1 || excute 
   	  bb=$aa;
    done
}

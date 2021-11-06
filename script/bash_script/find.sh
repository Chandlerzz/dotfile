#!/bin/sh

finds() {
    local path=$1
	local parameter=$2;
find "${path}" -name "*${parameter}*" -not -path "./node_modules/*" -not -path "./.*"| fzf;
}

js(){
	while [[ "$#" -gt 0 ]]
	do
		case $1 in
			-s|--script)
  		local script="script"
  		cat package.json | grep $script -A5
			;;
		esac
		shift
	done
}

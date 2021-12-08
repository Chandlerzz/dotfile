#!/bin/bash
_upload() {
    local bucket=""
    local source=""
    local target=""
    local pwd=$(pwd)
	while [ "$1" ]; do
		case "$1" in
			-b) local bucket="$2" ;;
			-s) local source="$2" ;;
			-t) local target="$2" ;;
			*) break ;;
		esac
		shift 2
	done
    if [[ -f $source ]]; then
        upload -b $bucket -s $source -t $target
    elif [[ -d $source ]]; then
        files=$(find $source)
        files=`echo $files | sed 's/ /,/g'`
        IFS=',' read -r -a array <<< "$files"
        sub=$pwd/$source
        for element in "${array[@]}"
        do
            # echo -n $element | od -An -tuC
            if [[ -f $element ]]; then
                element=$(realpath $element)
                local source=$element
                target1="${element/$sub/}"
                target1=$target$target1
                echo $target1
                echo $source
                upload -b $bucket -s $source -t $target1
            fi
        done
    else
        echo "file is not existed"
    fi
}
# alias ${_ZL_CMD:-z}='_zlua 2>&1'
alias ${_UPLOAD:-minio}='_upload'

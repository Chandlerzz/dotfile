# todo shell script to count the lines if linecount >200, delete the first
# line
# todo count everypath 
lrcfilename=$1
lines=$(cat $lrcfilename  | wc -l)
if [ "$lines" -gt "300" ];
    then sed -i "1d" $lrcfilename;
fi

#去重 统计数量  # 按数字排序  # 数字和名称置换列
sort $lrcfilename | uniq -c | sort -nr | awk 'BEGIN{FS=" "} {print $2,$1}' > /tmp/lrccount 

python3 $HOME/vim/script/LRC.py $2

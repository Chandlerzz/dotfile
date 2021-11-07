import re
import os
import sys
os.system("echo "+"LRC file" +">/tmp/lrccount1")
with open("/tmp/lrccount") as f:
    for line in f:
        obj = {}
        line = re.sub("\n","",line)
        list1 = line.split(" ")
        pwd = sys.argv[1] 
        if re.match(pwd,list1[0]):
            os.system("echo "+re.sub(pwd,"",list1[0])+">>/tmp/lrccount1")

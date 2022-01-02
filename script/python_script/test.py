import subprocess

p = subprocess.Popen("cat ~/.zlua | awk -F '|' '{print $1;}'",shell=True,executable="bash",stdout=subprocess.PIPE)
files=p.stdout.read()
files=files.decode()
files=files.split("\n")
for file in files:


type = ['companies','departments','subdepartments']

def test(mylist,limit,curr_depth):
    if len(mylist) ==0:
        return
    else:
        head, tail = mylist[0], mylist[1:]
        limit = limit - 1
        curr_depth=curr_depth + 1
    return test(tail,limit,curr_depth)

def comsume(elment, curr_depth):
    pass

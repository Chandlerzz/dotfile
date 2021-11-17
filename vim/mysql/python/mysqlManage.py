import json
import os
import sys
from IPython import embed
argv1 = sys.argv[1]
configFile = os.environ['HOME']+"/dotfile/mysql_config.json"
#获取配置表config.json 获取所有账号信息
def login(nickName):
    with open(configFile) as f:
        result = json.load(f)
    accounts = result['accounts']
    account = [ account for account in accounts if account ['nickName'] == nickName][0]
    host = account['host']
    passWord = account['passWord']
    name = account['name']
    port = account['port']
    command = "mysql -h" + host + " -u" + name +" -p" + passWord + " -P" + port
    os.system(command)
    # embed()
def show():
    command = "cat "+configFile 
    os.system(command)

if argv1 == "show":
    show()
else:
    login(argv1)

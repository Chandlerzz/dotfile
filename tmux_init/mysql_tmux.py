#!/usr/bin/python
import json
import os
import libtmux

server = libtmux.Server()
flag = os.system("tmux has-session -t mysql")
if flag != 0: 
    os.system("tmux new-session -s mysql -n 'vim' -d")
    session = server.find_where({ "session_name": "mysql" })
    configFile = os.environ['HOME']+"/dotfile/mysql_config.json"
    with open(configFile) as f:
        result = json.load(f)
        in_use = result['in_use']
        for i in in_use:
            name = i['name']
            database = i['database']
            session.new_window(attach=True, window_name=name)
            pane = session.attached_window.attached_pane
            pane.send_keys("cd $HOME/mysql")
            pane.send_keys("vim "+name+".mysql")
            # login mysql
            pane.send_keys(":python3 from mysql import mysql")
            pane.send_keys(":python3 my = mysql()")
            pane.send_keys(":python3 name = '"+name+"'")
            pane.send_keys(":python3 database = '"+database+"'")
            pane.send_keys(":python3 my.getcursor(name,database)")

            window = session.attached_window
            window.split_window(vertical=False)
            pane = window.attached_pane
            pane.send_keys("mymysql "+name)
            pane.send_keys("use "+database+";")
            window.select_pane("-R")
os.system("tmux kill-window -t vim")
os.system("tmux attach -t mysql")

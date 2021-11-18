import vim
import os 
import subprocess

def send_message():
    stmt = vim.vars['mysql_stmt']
    stmt = stmt.decode("utf-8")
    print(stmt)
    output = subprocess.Popen("tmux list-panes | grep \"active\" | cut -d':' -f1",shell=True,stdout=subprocess.PIPE)
    output=output.stdout.read()
    if (output[0] == 49):
        os.system("tmux send-keys -t 2 '" + stmt + "' C-m")
    else:
        os.system("tmux send-keys -t 1 '" + stmt + "' C-m")

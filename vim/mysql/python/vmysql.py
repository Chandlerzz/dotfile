import vim
import json
import os 
import subprocess
import libtmux
from functools import update_wrapper
import typing as t
F = t.TypeVar("F", bound=t.Callable[..., t.Any])

def setupmethod(f: F) -> F:
    """Wraps a method so that it performs a check in debug mode if the
    first request was already handled.
    """

    def wrapper_func( *args: t.Any, **kwargs: t.Any) -> t.Any:
        if _is_account_exist():
            raise AssertionError(
                    "this account is not defined in mysql_config.json"
            )
        return f( *args, **kwargs)

    return t.cast(F, update_wrapper(wrapper_func, f))

def send_message():
    stmt = vim.vars['mysql_stmt']
    stmt = stmt.decode("utf-8")
    output = subprocess.Popen("tmux list-panes | grep \"active\" | cut -d':' -f1",shell=True,stdout=subprocess.PIPE)
    output=output.stdout.read()
    if (output[0] == 49):
        os.system("tmux send-keys -t 2 '" + stmt + "' C-m")
    else:
        os.system("tmux send-keys -t 1 '" + stmt + "' C-m")

@setupmethod
def new_window(account):
    print("new_window")



def _is_account_exist():
    configFile = os.environ['HOME']+"/dotfile/mysql_config.json"
    with open(configFile) as f:
        result = json.load(f)
        accounts= result['accounts']
        accounts = [account['nickName'] for account in accounts]
        
    return  account in accounts 

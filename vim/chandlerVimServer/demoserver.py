#!/usr/bin/python

from __future__ import print_function
import json
import re
import os
import socket
import sys
import threading
from mysql import mysql
from functools import reduce
from IPython import embed
from server.server import ThreadedTCPServer
from server.forked_tcp_handler import ThreadedTCPHandler

try:
    # Python 3
    import socketserver
except ImportError:
    # Python 2
    import SocketServer as socketserver

thesocket = None
sql = mysql()

def login(name,database):
    global sql
    sql.getcursor(name,database)

def showCreateTable(tableName):
    global sql
    query = "show create table " + tableName + ";"
    sql.cursor.execute(query)
    createTableInfo = sql.cursor.fetchall()
    print(createTableInfo[0][1])
    os.system("echo "+"\""+re.sub("`","\\\\`",createTableInfo[0][1])+"\"" +" > /tmp/createTableInfo.mysql")


if __name__ == "__main__":
    HOST, PORT = "localhost", 8765

    server = ThreadedTCPServer((HOST, PORT), ThreadedTCPHandler)
    ip, port = server.server_address

    # Start a thread with the server -- that thread will then start one
    # more thread for each request
    server_thread = threading.Thread(target=server.serve_forever)

    # Exit the server thread when the main thread terminates
    server_thread.daemon = True
    server_thread.start()
    print("Server loop running in thread: ", server_thread.name)

    print("Listening on port {0}".format(PORT))
    while True:
        typed = sys.stdin.readline()
        if "quit" in typed:
            print("Goodbye!")
            break
        if thesocket is None:
            print("No socket yet")
        else:
            print("sending {0}".format(typed))
            thesocket.sendall(typed.encode('utf-8'))

    server.shutdown()
    server.server_close()

# Server that will accept connections from a Vim channel.
# Run this server and then in Vim you can open the channel:
#  :let handle = ch_open('localhost:8765')
#
# Then Vim can send requests to the server:
#  :let response = ch_sendexpr(handle, 'hello!')
#
# And you can control Vim by typing a JSON message here, e.g.:
#   ["ex","echo 'hi there'"]
#
# There is no prompt, just type a line and press Enter.
# To exit cleanly type "quit<Enter>".
#
# See ":help channel-demo" in Vim.
#
# This requires Python 2.6 or later.

import socketserver
import os

"""
Request handler class for ForkingTCP server.  It is instantiated once per connection to the server,
and must override the handle() method to implement communication to the client.
"""


class ForkedPalindromeTCPHandler(socketserver.BaseRequestHandler):
    def handle(self):
        # Echo the back to the client
        data = str(self.request.recv(1024), 'ascii')
        cur_pid = os.getpid()  # get current process ID
        response = bytes("{}: {}".format(cur_pid, data), 'ascii')
        self.request.sendall(response)
        return

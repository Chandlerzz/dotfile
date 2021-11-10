import socketserver
import threading

"""
Request handler class for ThreadedTCP server.  It is instantiated once per connection to the server,
and must override the handle() method to implement communication to the client.
"""


class ThreadedPalindromeTCPHandler(socketserver.BaseRequestHandler):
    def handle(self):
        # Echo the back to the client
        data = str(self.request.recv(1024), 'ascii')
        cur_thread = threading.currentThread()
        response = bytes("{}: {}".format(cur_thread.name, data), 'ascii')
        self.request.sendall(response)
        return

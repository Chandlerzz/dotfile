import socketserver
import logging

logging.basicConfig(level=logging.DEBUG, format='%(name)s: %(message)s')

"""
Request handler class for TCP server.  It is instantiated once per connection to the server,
and must override the handle() method to implement communication to the client.
"""


class PalindromeTCPHandler(socketserver.BaseRequestHandler):

    def __init__(self, request, client_address, server):
        self.logger = logging.getLogger('PalindromeTCPHandler')
        self.logger.debug('__init__')
        socketserver.BaseRequestHandler.__init__(self, request, client_address, server)
        return

    def setup(self) -> None:
        self.logger.debug('SETUP()')
        return socketserver.BaseRequestHandler.setup(self)

    def handle(self):
        # self.request is the TCP socket connected to the client
        self.logger.debug('HANDLE()')
        data = self.request.recv(1024)
        self.logger.debug('recv()->"%s', data)
        self.request.send(data)
        return

    def finish(self) -> None:
        self.logger.debug('FINISH()')
        return socketserver.BaseRequestHandler.finish(self)

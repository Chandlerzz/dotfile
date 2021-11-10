import socketserver
import selectors
from server.tcp_handler import PalindromeTCPHandler
import logging


logging.basicConfig(level=logging.DEBUG, format='%(name)s: %(message)s')


class PalindromeTCPServer(socketserver.TCPServer):

    def __init__(self, server_address, handler=PalindromeTCPHandler, bind_and_activate=True):
        self.selector = selectors.DefaultSelector()
        self.bind_and_activate = bind_and_activate
        self.logger = logging.getLogger('PalindromeTCPServer')
        self.logger.debug('__init__')
        socketserver.TCPServer.__init__(self, server_address, handler)
        return

    def handle_request(self) -> None:
        self.logger.debug('HANDLE_REQUEST()')
        return socketserver.TCPServer.handle_request(self)


class ThreadedPalindromeTCPServer(socketserver.ThreadingMixIn, socketserver.TCPServer):
    pass


class ForkedPalindromeTCPServer(socketserver.ForkingMixIn, socketserver.TCPServer):
    pass

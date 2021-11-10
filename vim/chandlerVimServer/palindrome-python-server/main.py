import socket
import threading
import os
import datetime
from server.server import ForkedPalindromeTCPServer
from server.forked_tcp_handler import ForkedPalindromeTCPHandler
import logging

logging.basicConfig(level=logging.DEBUG, format='%(name)s: %(message)s')
path = os.getcwd()
file_creation_date = datetime.datetime.now()
updated_file = path + "/data/updated-data-" + file_creation_date.strftime("%d%B%Y") + ".txt"
current_file = os.path.abspath("data.txt")

"""
This method takes in a String and compares the original to its reverse (e.g. abba) to determine
if it's a palindrome
"""


def is_palindrome(word):
    if word == word[::-1]:
        return "YES"
    else:
        return "NO"


"""
This method handles the client socket.  The client socket connects to the server socket, a data file is opened
and read as bytes.  The data from the file is then decoded and stored in an array.
"""


def client(ip, port):
    print("client")
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
        sock.connect((ip, port))

        with open(current_file, "rb") as file_reader, open(updated_file, 'w') as file_writer:
            data = file_reader.read()  # bytes
            data = [line.casefold() for line in data.decode('utf-8')]  # list of strings
            data = "".join(data).split("\n")  # join characters
            file_writer.write(str(data) + "\n")  # write data to update file
            file_writer.write(str(list(map(is_palindrome, data))))  # write YES Or NO for palindrome method
            word_dict = str(list(map(is_palindrome, data))).encode('utf-8')  # map palindrome method results to word
            sock.sendall(bytearray(word_dict))
            response = str(sock.recv(1024), 'ascii')

        print("Received: {}".format(response))
        file_reader.close()


if __name__ == '__main__':
    HOST, PORT = "localhost", 0
    addr = (HOST, PORT)
    file_name = "data.txt"

    forked_server = ForkedPalindromeTCPServer(addr, ForkedPalindromeTCPHandler)
    with forked_server:
        ip, port = forked_server.server_address
        th = threading.Thread(target=forked_server.serve_forever)
        th.setDaemon(True)
        th.start()

        print('Server loop running in process:', os.getpid())
        client(ip, port)
        print('\n')
        client(ip, port)
        print('\n')
        client(ip, port)

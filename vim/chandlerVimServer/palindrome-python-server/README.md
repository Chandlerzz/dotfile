# Palindrome Python Server

## Overview
A server program using TCP/IP socket programming implemented in Python.  This project was created for my Computer Networking course.

## Requirements
* Python 3.6+
* An IDE (e.g. [Pycharm](https://www.jetbrains.com/pycharm/), [Visual Studio Code](https://code.visualstudio.com/))

## How to Install
Clone the project by downloading and unzipping the project or running `git clone`.

## Goals
* Clients must input arrays of strings of ASCII characters from a file in the client process and send them to the server process on the host using the TCP/IP protocols and sockets implemented in the Python language. The server checks whether the string is a palindrome and returns the string with an answer of "YES" or "NO". The client and the server must be on separate processes.
* The server should be able to handle multiple connections from many clients concurrently using the select() command.  In other words, the server will not block every time one request arrives and satisfy that request before going to the next one.  Instead, it will ask the operating system through select to receive the requests asynchronously.  Also, the server must use the accept() system call in order to process multiple requests concurrently.

## How to Run The Program
Run `main.py`.  After running the program, it will generate 3 separate processes along with their respective IDs.  A file named `updated-data-<TODAY'S DATE>.txt`
will be generated with the original file's content along with whether or not a word is a palindrome.

## References
[Socket Server Framework](https://docs.python.org/3/library/socketserver.html)

[Real Python Sockets Guide](https://realpython.com/python-sockets/)

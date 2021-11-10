import socketserver
import threading

"""
Request handler class for ThreadedTCP server.  It is instantiated once per connection to the server,
and must override the handle() method to implement communication to the client.
"""


class ThreadedTCPHandler(socketserver.BaseRequestHandler):
    def handle(self):
        print("=== socket opened ===")
        global thesocket
        global sql
        thesocket = self.request
        while True:
            try:
                data = self.request.recv(4096).decode('utf-8')
            except socket.error:
                print("=== socket error ===")
                break
            except IOError:
                print("=== socket closed ===")
                break
            if data == '':
                print("=== socket closed ===")
                break
            print("received: {0}".format(data))
            try:
                decoded = json.loads(data)
            except ValueError:
                print("json decoding failed")
                decoded = [-1, '']

            # Send a response if the sequence number is positive.
            # Negative numbers are used for "eval" responses.
            if decoded[0] >= 0:
                decoded1 = re.sub("'","\"",decoded[1])
                decoded1=json.loads(decoded1)
                if decoded[1] == 'hello!':
                    response = "got it"
                elif "config" in decoded1.keys():
                    name=decoded1['config']['name']
                    database=decoded1['config']['database']
                    login(name,database)
                    for item in sql.tableNames:
                        os.system("echo " + item + " >> /tmp/tables.mysql")
                    response = "haha"
                elif "tableName" in decoded1.keys():
                    name=decoded1['tableName']
                    try:
                        showCreateTable(name)
                    except Exception as e:
                        login(name,database)
                        showCreateTable(name)
                    response = "haha"
                elif "stmt" in decoded1.keys():
                    pass
                else:
                    response = "what?"
                encoded = json.dumps([decoded[0], response])
                print("sending {0}".format(encoded))
                self.request.sendall(encoded.encode('utf-8'))
        thesocket = None

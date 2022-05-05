#import socket module
from socket import *
import testb
serverSocket = socket(AF_INET, SOCK_STREAM)
serverPort = 8001
serverIP = "206.87.134.3"
serverIP = "172.20.10.6"
serverSocket.bind((serverIP,serverPort))
serverSocket.listen(1)
#Fill in end
while True:
    #Establish the connection
    print('Ready to serve...')
    connectionSocket, addr = serverSocket.accept()
    print('connection established')
    MESSAGE = ""
    try:
        count = 0
        for i in range(60):
            MESSAGE = ""
            for i in range(8):
                message = connectionSocket.recv(20000).decode()
                print(message)
                MESSAGE = MESSAGE + message
                count = count + 1
                connectionSocket.send("okay".encode());
                print(count)
            testb.test(MESSAGE)
        connectionSocket.close()

    except IOError:
        #Send response message for file not found
        #Fill in start
        connectionSocket.send("HTTP/1.1 404 Not Found".encode())
        #Fill in end
        #Close client socket
        #Fill in start
        connectionSocket.close()
        #Fill in end
serverSocket.close()
sys.exit()#Terminate the program after sending the corresponding data
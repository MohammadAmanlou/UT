# import socket module
from socket import *
import sys  # In order to terminate the program

serverSocket = socket(AF_INET, SOCK_STREAM)

# Prepare a server socket
# Fill in start
serverPort = 6789                     # شماره پورتی که می‌خواهید روی آن گوش بدهید
serverSocket.bind(('', serverPort))   # به همه‌ی اینترفیس‌ها روی serverPort بایند می‌شود
serverSocket.listen(1)                # صف اتصالات در حال انتظار (backlog) = 1
# Fill in end
from socket import socket, AF_INET, SOCK_DGRAM

def get_local_ip():
    s = socket(AF_INET, SOCK_DGRAM)
    try:
        s.connect(("8.8.8.8", 80))   # فقط برای انتخاب اینترفیس مناسب
        ip = s.getsockname()[0]
    finally:
        s.close()
    return ip

print("Server will listen on:", get_local_ip())

while True:
    # Establish the connection
    print('Ready to serve...')
    # Fill in start
    connectionSocket, addr = serverSocket.accept()
    # Fill in end

    try:
        # Fill in start
        message = connectionSocket.recv(1024).decode()  # دریافت درخواست HTTP
        # Fill in end

        filename = message.split()[1]  # مسیر فایل پس از GET
        f = open(filename[1:], 'rb')   # حذف "/" ابتدای مسیر و باز کردن فایل باینری

        # Fill in start
        outputdata = f.read()          # محتوای فایل
        f.close()
        # Fill in end

        # Send one HTTP header line into socket
        # Fill in start
        header = (
            "HTTP/1.1 200 OK\r\n"
            "Content-Type: text/html; charset=utf-8\r\n"
            f"Content-Length: {len(outputdata)}\r\n"
            "Connection: close\r\n"
            "\r\n"
        )
        connectionSocket.send(header.encode())
        # Fill in end

        # Send the content of the requested file to the client
        # (نسخه‌ی اسکلت حلقه می‌خواست؛ اگر خروجی باینری بود، قطعه‌قطعه ارسال می‌کنیم)
        for i in range(0, len(outputdata)):
            connectionSocket.send(outputdata[i:i+1])  # ارسال بایت به بایت طبق اسکلت
        connectionSocket.send("\r\n".encode())

        connectionSocket.close()

    except IOError:
        # Send response message for file not found
        # Fill in start
        not_found_body = (
            b"<html><head><title>404 Not Found</title></head>"
            b"<body><h1>404 Not Found</h1><p>File not found.</p></body></html>"
        )
        header = (
            "HTTP/1.1 404 Not Found\r\n"
            "Content-Type: text/html; charset=utf-8\r\n"
            f"Content-Length: {len(not_found_body)}\r\n"
            "Connection: close\r\n"
            "\r\n"
        )
        connectionSocket.send(header.encode())
        connectionSocket.send(not_found_body)
        # Fill in end

        # Close client socket
        # Fill in start
        connectionSocket.close()
        # Fill in end

# بسته شدن سوکت اصلی (در عمل به این‌جا نمی‌رسیم چون حلقه‌ی بی‌نهایت است)
serverSocket.close()
sys.exit()  # Terminate the program after sending the corresponding data

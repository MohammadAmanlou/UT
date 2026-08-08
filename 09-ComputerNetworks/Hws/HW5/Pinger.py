from socket import *
import os
import sys
import struct
import time
import select
import binascii

ICMP_ECHO_REQUEST = 8

def checksum (string):
    # Compatibility for Python 3 (ensure we are working with bytes)
    if isinstance(string, str):
        string = string.encode()
        
    csum = 0
    countTo = (len(string) // 2) * 2
    count = 0
    while count < countTo:
        thisVal = string[count+1] * 256 + string[count]
        csum = csum + thisVal
        csum = csum & 0xffffffff
        count = count + 2
    if countTo < len(string):
        csum = csum + string[len(string) - 1]
        csum = csum & 0xffffffff
    csum = (csum >> 16) + (csum & 0xffff)
    csum = csum + (csum >> 16)
    answer = ~csum
    answer = answer & 0xffff
    answer = answer >> 8 | (answer << 8 & 0xff00)
    return answer

def receiveOnePing (mySocket, ID, timeout, destAddr):
    timeLeft = timeout
    while 1:
        startedSelect = time.time()
        whatReady = select.select([mySocket], [], [], timeLeft)
        howLongInSelect = (time.time() - startedSelect)
        if whatReady[0] == []: # Timeout
            return None # Changed to return None for statistical processing
        timeReceived = time.time()
        recPacket, addr = mySocket.recvfrom(1024)
        
        #Fill in start
        #Fetch the ICMP header from the IP packet
        
        # IP header is the first 20 bytes. ICMP header starts at byte 20.
        icmpHeader = recPacket[20:28]
        # Unpack the header: type, code, checksum, packetID, sequence
        icmpType, code, mychecksum, packetID, sequence = struct.unpack("bbHHh", icmpHeader)
        
        # OPTIONAL EXERCISE 2: Analyze ICMP Error Codes
        # Type 3 is Destination Unreachable
        if icmpType == 3:
            if code == 0:
                return "Error: Destination Network Unreachable"
            elif code == 1:
                return "Error: Destination Host Unreachable"
            elif code == 3:
                return "Error: Destination Port Unreachable"
            else:
                return "Error: Destination Unreachable, Code: %d" % code
        
        # Check if it is an Echo Reply (Type 0) and ID matches
        if icmpType == 0 and packetID == ID:
            # Data/Payload starts after the 8-byte ICMP header
            bytesInDouble = struct.calcsize("d")
            timeSent = struct.unpack("d", recPacket[28:28 + bytesInDouble])[0]
            # Fetch TTL from IP header (at offset 8)
            ttl = struct.unpack("B", recPacket[8:9])[0]
            
            rtt = (timeReceived - timeSent) * 1000 # Convert to milliseconds
            return (rtt, ttl, len(recPacket)) # Return a tuple for statistics
        
        #Fill in end
        
        timeLeft = timeLeft - howLongInSelect
        if timeLeft <= 0:
            return None

def sendOnePing (mySocket, destAddr, ID):
    #Header is type (8), code (8), checksum (16), id (16), sequence (16)
    myChecksum = 0
    #Make a dummy header with a 0 checksum
    # struct -- Interpret strings as packed binary data.
    header = struct.pack("bbHHh", ICMP_ECHO_REQUEST, 0, myChecksum, ID, 1)
    data = struct.pack("d", time.time())
    #Calculate the checksum on the data and the dummy header.
    # Note: Using byte concatenation instead of str conversion for Python 3
    myChecksum = checksum (header + data)
    #Get the right checksum, and put in the header
    if sys.platform == 'darwin':
        # Convert 16-bit integers from host to network byte order
        myChecksum = htons (myChecksum) & 0xffff
    else:
        myChecksum = htons (myChecksum)
    header = struct.pack("bbHHh", ICMP_ECHO_REQUEST, 0, myChecksum, ID, 1)
    packet = header + data
    mySocket.sendto (packet, (destAddr, 1)) # AF_INET address must be tuple, not str
    # Both LISTS and TUPLES consist of a number of objects

def doOnePing (destAddr, timeout):
    icmp = getprotobyname("icmp")
    # SOCK_RAW is a powerful socket type. For more details: http://sock-raw.org/papers/sock_raw
    mySocket = socket (AF_INET, SOCK_RAW, icmp)
    myID = os.getpid() & 0xFFFF # Return the current process i
    sendOnePing (mySocket, destAddr, myID)
    delay = receiveOnePing (mySocket, myID, timeout, destAddr)
    mySocket.close()
    return delay

def ping (host, timeout=1):
    #timeout=1 means: If one second goes by without a reply from the server,
    # the client assumes that either the client's ping or the server's pong is lost
    dest = gethostbyname (host)
    print("Pinging " + dest + " using Python:")
    print("")
    
    # OPTIONAL EXERCISE 1: Collect Statistics
    rtts = []
    lost_packets = 0
    total_pings = 4 # We will send 4 pings to match standard behavior
    
    # Send ping requests to a server
    for i in range(total_pings):
        result = doOnePing (dest, timeout)
        
        if result is None:
            print("Request timed out.")
            lost_packets += 1
        elif isinstance(result, str): # ICMP Error Message
            print(result)
            lost_packets += 1
        else:
            rtt, ttl, size = result
            rtts.append(rtt)
            print("Reply from %s: bytes=%d time=%.2fms TTL=%d" % (dest, size, rtt, ttl))
            
        time.sleep(1) # one second
        
    # OPTIONAL EXERCISE 1: Final Statistics Report
    if total_pings > 0:
        loss_rate = (lost_packets / total_pings) * 100
        print("\n--- %s ping statistics ---" % host)
        print("    Packets: Sent = %d, Received = %d, Lost = %d (%.1f%% loss)," % 
              (total_pings, len(rtts), lost_packets, loss_rate))
        
        if rtts:
            print("Approximate round trip times in milli-seconds:")
            print("    Minimum = %.2fms, Maximum = %.2fms, Average = %.2fms" % 
                  (min(rtts), max(rtts), sum(rtts)/len(rtts)))
    
    return rtts

# --- FINAL TEST TARGETS FOR REPORT ---
test_targets = [
    ("Localhost", "127.0.0.1"),
    ("Asia (Tokyo, Japan)", "www.u-tokyo.ac.jp"),
    ("Europe (London, UK)", "www.cam.ac.uk"),
    ("North America (California, USA)", "www.stanford.edu"),
    ("Oceania (Melbourne, Australia)", "www.unimelb.edu.au"),
    ("Africa (Cape Town, SA)", "www.uct.ac.za")
]

for continent, url in test_targets:
    print(f"\n[Testing: {continent}]")
    try:
        ping(url)
    except Exception as e:
        print(f"Failed to reach {url}: {e}")
from socket import *
import os
import sys
import struct
import time
import select
import binascii

ICMP_ECHO_REQUEST = 8
MAX_HOPS = 30
TIMEOUT = 2.0
TRIES = 2

# The packet that we shall send to each router along the path is the ICMP echo
# request packet, which is exactly what we had used in the ICMP ping exercise.
# We shall use the same packet that we built in the Ping exercise

def checksum(string):
    # In this function we make the checksum of our packet
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

def build_packet():
    # In the sendOnePing() method of the ICMP Ping exercise, firstly the header of our
    # packet to be sent was made, secondly the checksum was appended to the header and
    # then finally the complete packet was sent to the destination.
    
    # Fill in start
    # Make the header in a similar way to the ping exercise.
    myID = os.getpid() & 0xFFFF
    # Header is type (8), code (8), checksum (16), id (16), sequence (16)
    header = struct.pack("bbHHh", ICMP_ECHO_REQUEST, 0, 0, myID, 1)
    data = struct.pack("d", time.time())
    
    # Append checksum to the header.
    myChecksum = checksum(header + data)
    if sys.platform == 'darwin':
        myChecksum = htons(myChecksum) & 0xffff
    else:
        myChecksum = htons(myChecksum)
        
    header = struct.pack("bbHHh", ICMP_ECHO_REQUEST, 0, myChecksum, myID, 1)
    # Fill in end
    
    # So the function ending should look like this
    packet = header + data
    return packet

def get_route(hostname):
    timeLeft = TIMEOUT
    print(f"Traceroute to {hostname} over a maximum of {MAX_HOPS} hops:\n")
    
    for ttl in range(1, MAX_HOPS):
        for tries in range(TRIES):
            destAddr = gethostbyname(hostname)
            
            # Fill in start
            # Make a raw socket named mySocket
            icmp = getprotobyname("icmp")
            mySocket = socket(AF_INET, SOCK_RAW, icmp)
            # Fill in end
            
            mySocket.setsockopt(IPPROTO_IP, IP_TTL, struct.pack('I', ttl))
            mySocket.settimeout(TIMEOUT)
            
            try:
                d = build_packet()
                mySocket.sendto(d, (hostname, 0))
                t = time.time()
                
                startedSelect = time.time()
                whatReady = select.select([mySocket], [], [], timeLeft)
                howLongInSelect = (time.time() - startedSelect)
                
                if whatReady[0] == []: # Timeout
                    print(" %d  * * * Request timed out." % ttl)
                    continue

                recvPacket, addr = mySocket.recvfrom(1024)
                timeReceived = time.time()
                timeLeft = timeLeft - howLongInSelect
                
                if timeLeft <= 0:
                    print(" %d  * * * Request timed out." % ttl)
                    continue
                    
            except timeout:
                continue
            
            else:
                # Fill in start
                # Fetch the icmp type from the IP packet
                # ICMP header starts after 20 bytes of IP header
                icmpHeader = recvPacket[20:28]
                types, code, my_checksum, packetID, sequence = struct.unpack("bbHHh", icmpHeader)
                # Fill in end
                
                # Fetching the hostname (Reverse DNS) for the optional part
                try:
                    host_info = gethostbyaddr(addr[0])
                    router_hostname = host_info[0]
                except (herror, gaierror):
                    router_hostname = "hostname not found"

                if types == 11:
                    bytes = struct.calcsize("d")
                    # timeSent = struct.unpack("d", recvPacket[28:28 + bytes])[0] # Can be used if needed
                    print(" %d rtt=%.0f ms %s [%s]" % (ttl, (timeReceived - t) * 1000, addr[0], router_hostname))
                    
                elif types == 3:
                    bytes = struct.calcsize("d")
                    # timeSent = struct.unpack("d", recvPacket[28:28 + bytes])[0]
                    print(" %d rtt=%.0f ms %s [%s] (Destination Unreachable)" % (ttl, (timeReceived - t) * 1000, addr[0], router_hostname))
                    
                elif types == 0:
                    bytes = struct.calcsize("d")
                    timeSent = struct.unpack("d", recvPacket[28:28 + bytes])[0]
                    print(" %d rtt=%.0f ms %s [%s]" % (ttl, (timeReceived - timeSent) * 1000, addr[0], router_hostname))
                    return
                
                else:
                    print("error: unknown ICMP type %d" % types)
                break
            
            finally:
                mySocket.close()

# Example run
if __name__ == "__main__":
    # get_route("google.com")
    # Test targets from different regions
    targets = [
        "google.com",
        "bbc.co.uk",
        "u-tokyo.ac.jp",
        "anu.edu.au"
    ]

    for target in targets:
        get_route(target)
        print("\n" + "="*70)
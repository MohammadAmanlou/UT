barbari,adam = map(eval,input().split())
barbari = barbari%adam
if (barbari == 0 ):
    print (0)
    exit(0)
def gcd(a, b):
    if(b == 0):
        return abs(a)
    else:
        return gcd(b, a % b) 
num = gcd (barbari , adam)
boresh = adam - gcd (adam , barbari)
print (int(boresh))
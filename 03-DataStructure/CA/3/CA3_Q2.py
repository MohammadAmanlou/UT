import heapq as hq
n,q,k = map(int , (input().split()))
arr = list(map(int , (input().split())))
s = -1
for i in range(q):
    instruction = list(input().split())
    if(instruction[0] == '+'):
        arr.append(int(instruction[1]))
    else :
        if (k > len(arr)):
            s = -1
        else:
            s = (hq.nsmallest(k, arr))[-1]
        if(instruction[0] == '-'):
            if (s!=-1):
                arr.remove(s)
        elif(instruction[0] == 'print'):
            print(s)



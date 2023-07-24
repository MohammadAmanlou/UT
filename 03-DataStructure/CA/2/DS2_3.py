length = int(input())
number1 = list(map(eval,input().split()))
number2 = list(map(eval,input().split()))
ans = []
for p in range(length):
    a1 , a2 = [] , []
    for i1,v1 in enumerate(number1) :
        while (a1 and a1[-1] < v1 and len(number1)-i1 > p-len(a1)):
            a1.pop()
        if (len(a1) < p):
            a1.append(v1)
    for i2,v2 in enumerate(number2) :
        while (a2 and a2[-1] < v2 and len(number2)-i2 > (length-p)-len(a2)):
            a2.pop()
        if (len(a2) < length-p):
            a2.append(v2)
    f = []
    while (a1 or a2):
        f.append(max(a1, a2).pop(0))
    ans.append(f)
print(*max(ans))
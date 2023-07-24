length = int(input())
numbers = list(map(eval,input().split()))
numbers.insert(0,0)
numbers.append(0)
ans = []
stack = []
for i in range(1, length+1):
    op = numbers[i] - numbers[i-1]
    cl = numbers[i] - numbers[i+1]
    if ((op <=0 )and (cl<=0)):
        continue
    while ((op > 0) or (cl > 0)):
        if (op > 0):
            x = [i]
            stack.append(x)
        if (cl > 0):
            x = stack.pop()
            x.append(i)
            ans.append(x)
        op-= 1
        cl -= 1
ans.sort()
for p in ans:
    print(*p)

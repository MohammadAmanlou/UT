import heapq as hq
n , t = map(int, input().split())
up = list(map(int, input().split()))
sis_lis , temp , adam = [] , [] , []
ans = [""]*n
for i in range(n):
    sis_lis.append((up[i], i))
sis_lis.sort()
time , i = 0 , 0
first_time = True
while (i<n or len(temp) != 0 or len(adam) != 0):
    if (len(adam) == 0 and len(temp) == 0):
        first_time = True
    while (i < n) :
        if first_time:
            time = sis_lis[i][0] + t
            first_time = False
        if sis_lis[i][0] > time:
            break   
        if (len(adam) != 0 and adam[-1][1] > sis_lis[i][1]) :
            adam.append(sis_lis[i])
        elif len(adam) == 0:
            adam.append(sis_lis[i])
        else:
            hq.heappush(temp, [sis_lis[i][1], sis_lis[i][0]])
        i += 1
    if len(adam):
        ans[adam.pop(0)[1]] = time
    if len(adam) == 0 and len(temp) != 0:
        u = hq.heappop(temp)
        adam.append([u[1], u[0]])
    time += t
print(*ans)

n,m,q = map(int , input().split())
res = 0
blacks = set()
for x in range(q):
    i,j = map(int , input().split())
    if ((i , j ) in blacks ):
        pass
    else:
        blacks.add((i,j))
        if ( i ==1):
            H = 0
        elif((i-1,j) in blacks):
            H = 1
        else:
            H = 0
        if (i==n):
            G = 0
        elif((i + 1 , j) in blacks):
            G = 1
        else :
            G= 0
        if (j == 1):
            D = 0
        elif ((i , j-1) in blacks):
            D = 1
        else:
            D= 0
        if (j == m):
            C = 0
        elif((i , j+1) in blacks):
            C = 1
        else:
            C = 0
        res = res + (2-(D+C+H+G))
    print(res)
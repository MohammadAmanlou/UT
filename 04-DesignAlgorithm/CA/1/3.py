j = 0
level = 1
l  = ['L','L','S','S']
r = []
ans = ""
ans = ans + str(str("State{}: ".format(level)) +str(l) +str(r) +'\n')
n = 4
while(n > 0):
    if(j == 1):
        j = 0
        r.remove('S')
        n+=1
        l = l + ['S']
        ans = ans + "Action: Left\n"
        level +=1
        ans = ans + str(str("State{}: ".format(level)) +str(l) +str(r) +'\n')
    elif('S' not in r ):
        j = 1
        l.remove('S')
        l.remove('S')
        n -=2
        r = r + ['S','S']
        ans = ans + "Action: Right\n"
        level +=1
        ans = ans + str(str("State{}: ".format(level)) +str(l) +str(r) +'\n')
    elif('S' in r ):
        j = 1
        l.remove('L')
        n -=1
        r = ['L'] + r 
        ans = ans + "Action: Right\n"
        level +=1
        ans = ans + str(str("State{}: ".format(level)) +str(l) +str(r) +'\n')
print("Solution: " + str(level-1))
print(ans)
        
        



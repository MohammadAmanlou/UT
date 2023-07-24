person , round , goal = map(eval,input().split())
def find_prime_list(n):
    prime_list = []
    num = 2
    while (len(prime_list) < n):
        if all(num%i!=0 for i in range(2,int(num**0.5)+1)):
            prime_list.append(num)
        num = num + 1
    return (prime_list)
prime_list = find_prime_list(round)
start_list = list(range(1,person+1))
def update_list(start_list,k):
    i,j=0,1
    while(k>0):
        start_list[i],start_list[j]=start_list[j],start_list[i]
        i,j = i+1,j+1
        k -= 1
        if(i>len(start_list)-1):
            i = 0
        if(j>len(start_list)-1):
            j = 0
    return (start_list)
for k in range(1,round+1):
    b = prime_list[k-1]
    print(start_list) 
    start_list = update_list(start_list , b)
right_index = ( start_list.index(goal) + 1 )
if (right_index > len(start_list) - 1):
    right_index = 0
left_index = ( start_list.index(goal) - 1 )
print(start_list)
#print(start_list[right_index] , start_list[left_index])
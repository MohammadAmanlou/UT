person , round , goal = map(eval,input().split())
def SieveOfEratosthenes(num):
    prime = [True for i in range(num+1)]
    p = 2
    while (p * p <= num):
        if (prime[p] == True):
            for i in range(p * p, num+1, p):
                prime[i] = False
        p += 1
    prime_list = [i for i, x in enumerate(prime) if x][2:round+2]
    return (prime_list)
prime_list =SieveOfEratosthenes(620000)
index = goal - 1
for b in prime_list :
    if (index == 0):
        index = b%person
    elif (b >= index and b < person):
        index -=1
    elif (b >= person):
        dor = (int(b/person))%(person -1)
        if (index <= dor):
            index  = index - dor - 1
            index = index%person
        elif (dor < index):
            index -= dor
            index = index%person
        if (index <= b%person):
            index -= 1
            index = index%person
right_index = (index + 1)%person
left_index = (index - 1)%person
def find_first_number_of_index(index , index2 ):
    for prime in prime_list[::-1]:
        head_move = prime%person
        start = (1-int(prime/(person-1))-1)%person
        end = ((prime%(person-1))-int(prime/(person-1))-1)%person
        if(index == head_move):
            index = 0
        else :
            if ((prime%(person-1))==0):
                index = (index+int(prime/(person-1)))%person
            else:
                if ((start > end and (index >= start or index<= end)) or ((start < end) and (index >= start and index<= end)) or ((start==end)and(index==start))):
                    index = (index+int(prime/(person-1))+1)%person
                else:
                    index = (index+int(prime/(person-1)))%person
        if(index2 == head_move):
            index2 = 0
        else :
            if ((prime%(person-1))==0):
                index2 = (index2+int(prime/(person-1)))%person
            else:
                if ((start > end and (index2 >= start or index2<= end)) or ((start < end) and (index2 >= start and index2<= end)) or ((start==end)and(index2==start))):
                    index2 = (index2+int(prime/(person-1))+1)%person
                else:
                    index2 = (index2+int(prime/(person-1)))%person
    return (index+1 , index2+1)
right_number , left_number = find_first_number_of_index(right_index , left_index)
print(right_number , left_number)
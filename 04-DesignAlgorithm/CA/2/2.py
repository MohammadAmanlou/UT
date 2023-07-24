def jongle(planet, times, values, T):
    dp = [[0] * (T+1) for _ in range(len(planet) + 1)]
    for i in range(1, len(planet) + 1):
        for j in range(1, T + 1):
            tsum = 0        
            vsum = 0        
            for k in range(len(planet[i - 1])):
                tsum = tsum + times[planet[i - 1][k]-1]
                vsum = vsum + values[planet[i - 1][k]-1]
            jongle_selected = -1
            max_ = -1
            for k in range(len(planet[i - 1])):
                if times[planet[i-1][k] - 1] <= j and max_ < dp[i - 1][j - times[planet[i-1][k] - 1]] + values[planet[i-1][k] - 1]:
                    jongle_selected = planet[i - 1][k]
                    max_ = dp[i - 1][j - times[planet[i-1][k] - 1]] + values[planet[i-1][k] - 1]
            choose_all = -1
            choose_one = -1
            if tsum <= j:
                choose_all = dp[i - 1][j - tsum] + vsum
            if jongle_selected != -1 and times[jongle_selected - 1] <= j:
                choose_one = dp[i - 1][j - times[jongle_selected - 1]] + values[jongle_selected - 1]
            dp [i][j] = max(dp[i - 1][j], choose_all, choose_one)

    return dp[len(planet)][T]


def check_duplicate(pair, k):
    inx = []
    for i in range(len(pair)):
        if k[0] in pair[i]:
            inx.append(i)
        if k[1] in pair[i]:
            inx.append(i)
    if len(inx) == 1:
        inx.append(-1)
    elif len(inx) == 0:
        inx.append(-1)
        inx.append(-1)
    return inx


def process_planet(pair, k):
    check = 0
    if len(pair) == 0:
        pair.append(k)
    elif len(pair) >= 2:
        inx = check_duplicate(pair, k)
        if inx[0] != inx[1] and inx[1] != -1 and inx[0] != -1:
            combined = pair[inx[0]] + list(set(pair[inx[1]]))
            pair[inx[0]] = combined
            del pair[inx[1]]
        else:
            for x in range(len(pair)):
                for j in range(len(pair[x])):
                    if k[0] == pair[x][j]:
                        check = 1
                        if k[1] not in pair[x]:
                            pair[x].append(k[1])
                    elif k[1] == pair[x][j]:
                        check = 1
                        if k[0] not in pair[x]:
                            pair[x].append(k[0])
            if check == 0:
                pair.append(k) 
    
    else:
        for x in range(len(pair)):
            for j in range(len(pair[x])):
                if k[0] == pair[x][j]:
                    check = 1
                    if k[1] not in pair[x]:
                        pair[x].append(k[1])
                elif k[1] == pair[x][j]:
                    check = 1
                    if k[0] not in pair[x]:
                        pair[x].append(k[0])
        if check == 0:
            pair.append(k) 
    

def generate_planet(pair, values, times, T, check_list):
    if not len(pair) == 0:
        planet = [[] for _ in range(len(pair))]
    
        for i in range(len(pair)):
            for j in range(len(pair[i])):
                inx = pair[i][j]
                planet[i].append(inx)

        for i in range(len(check_list)):
            if check_list[i] == 0:
                planet.append([i+1])
                           
        max_value = jongle(planet, times, values, T)

    else:
        planet = [[x] for x in times]
        max_value = jongle(planet, times, values, T)

    return max_value


pair = []
n, m, T = map(int, input().split(" "))
times = [int(x) for x in input().strip().split(" ")]
values = [int(x) for x in input().strip().split(" ")]
check_list = [ 0 for _ in range(n)]
for i in range(m):
    k = [int(x) for x in input().strip().split(" ")]
    process_planet(pair, k)
    check_list[k[0]-1] = 1
    check_list[k[1]-1] = 1

max_val = generate_planet(pair, values, times, T, check_list)
print(max_val)
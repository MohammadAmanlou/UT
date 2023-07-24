word = ""
length = int(input())
for i in range(length):
    command = list(input().split())
    if command[0] == "push":
        word += command[1]
    elif command[0] == "pop":
        word = word[1:]
    used = []
    for i in range(len(word)):
        for j in range(i+1, len(word)+1):
            s = set(used)
            if not ((word[i:j] != word[i:j][::-1])or(word[i:j] in s)):
                used.append(word[i:j])
    print(len(used))
number_of_words = input()
words = ""
letters = ""
for i in range(0,int(number_of_words)):
    word = input()
    words = words + word[0]
for letter in words :
    if (5 <= words.count(letter)):
        letters = letters + letter
if (len(letters) < 5):
    print ("How long must I suffer")
else :
    print (''.join(sorted(set(letters))))
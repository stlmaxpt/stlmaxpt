import random
import math
from PIL import Image


def getword(wordlist):
    wordnum = math.floor(len(wordlist)*random.random())
    return wordlist[wordnum]


def num2colors(keys):
    size = 50
    imgmat = [[0] for i in range(size*len(keys))]

    for i in range(len(keys)):
        intimgvec = [(40, 40, 40) for i in range(size*len(keys[0]))]
        intimgmat = [intimgvec for i in range(size)]
        for k in range(len(keys[0])):
            if keys[i][k] == 'y':
                for p in range(size):
                    for q in range(size * k, size * (k + 1)):
                        intimgmat[p][q] = (204, 204, 0)
            elif keys[i][k] == 'g':
                for p in range(size):
                    for q in range(size * k, size * (k + 1)):
                        intimgmat[p][q] = (0, 167, 0)
            elif keys[i][k] == 'b':
                for p in range(size):
                    for q in range(size * k, size * (k + 1)):
                        intimgmat[p][q] = (0, 0, 0)
        for l in range(size):
            imgmat[size*i + l] = intimgmat[l]
    imgact = Image.new("RGB", (len(keys[0])*size, len(keys)*size))
    for m in range(size*len(keys)):
        for n in range(size*len(keys[0])):
            imgact.putpixel((n, m), imgmat[m][n])
    imgact.show()


testfile = "words5txt"

wordlewords = []

with open(testfile) as filein:
    for line in filein:
        if line[len(line) - 2] != '*':
            eachword = line[len(line) - 6:len(line) - 1]
        else:
            eachword = line[len(line) - 8:len(line) - 3]
        wordlewords.append(eachword.lower())

key = getword(wordlewords)
print('Target word: ' + key)
acceptablewordsfinal = []
guesses = 0
numguesses = 6
results = [['r' for l in range(len(key))] for j in range(numguesses)]
checker = False
x = False
resultsstr = ''

while guesses <= numguesses and checker != True:
    # this one
    if x != key:
        x = getword(wordlewords)
        print(x)
    if len(x) == len(key):
        if x in wordlewords:
            if x != key:
                for j in range(len(key)):
                    inword = False
                    rightplace = False
                    if x[j] in key:
                        inword = True
                    if x[j] == key[j]:
                        rightplace = True
                    if inword is True and rightplace is False:
                        results[guesses][j] = 'y'
                    elif inword is True and rightplace is True:
                        results[guesses][j] = 'g'
                    else:
                        results[guesses][j] = 'b'

                print('Current status:')
                num2colors(results)

                resultsstr = ''
                for i in range(len(results[guesses])):
                    resultsstr = resultsstr + results[guesses][i]

            if guesses == numguesses:
                print('Better luck next time!')
                break
        else:
            print('Not in word list! Guess again.')
    elif len(x) < len(key):
        print('Not enough letters! Guess again.')
    elif len(x) > len(key):
        print('Too many letters! Guess again.')

    acceptablewordsg = []
    acceptablewordsb = []
    acceptablewordsy = []
    acceptablewords = []
    # here also
    y = resultsstr
    numg = 0
    numy = 0
    numb = 0
    for i in range(len(y)):
        if y[i] == 'g':
            numg += 1
        if y[i] == 'y':
            numy += 1
        if y[i] == 'b':
            numb += 1

    for i in range(len(x)):
        if y[i] == 'g':
            for j in wordlewords:
                if x[i] == j[i]:
                    acceptablewordsg.append(j)
        elif y[i] == 'b':
            for j in wordlewords:
                if x[i] not in j:
                    acceptablewordsb.append(j)

    if y.count('y') == 1:
        for i in range(len(x)):
            for j in wordlewords:
                if x[i] in j and y[i] == 'y':
                    acceptablewordsy.append(j)
    elif y.count('y') >= 2:
        ylist = []
        for i in range(len(y)):
            if y[i] == 'y':
                ylist.append(x[i])
        if len(ylist) >= len(set(ylist)):
            county = []
            for j in range(len(ylist)):
                county.append(ylist.count(ylist[j]))
            for j in range(len(county)):
                for k in wordlewords:
                    if k.count(ylist[j]) >= county[j]:
                        acceptablewordsy.append(k)

    acceptablewordsglong = []
    acceptablewordsblong = []
    acceptablewordsylong = []
    gnums = [0 for i in range(len(acceptablewordsg))]
    bnums = [0 for i in range(len(acceptablewordsb))]
    ynums = [0 for i in range(len(acceptablewordsy))]

    for i in range(len(acceptablewordsg)):
        gnums[i] = acceptablewordsg.count(acceptablewordsg[i])
    for i in range(len(acceptablewordsg)):
        if gnums[i] == numg:
            acceptablewordsglong.append(acceptablewordsg[i])
    acceptablewordsgfinal = list(set(acceptablewordsglong))

    for i in range(len(acceptablewordsb)):
        bnums[i] = acceptablewordsb.count(acceptablewordsb[i])
    for i in range(len(acceptablewordsb)):
        if bnums[i] == numb:
            acceptablewordsblong.append(acceptablewordsb[i])
    acceptablewordsbfinal = list(set(acceptablewordsblong))

    for i in range(len(acceptablewordsy)):
        ynums[i] = acceptablewordsy.count(acceptablewordsy[i])
    for i in range(len(acceptablewordsy)):
        if ynums[i] == numy:
            acceptablewordsylong.append(acceptablewordsy[i])
    acceptablewordsyfinal = list(set(acceptablewordsylong))

    rejecty = []
    for i in range(len(acceptablewordsyfinal)):
        for j in range(len(y)):
            if y[j] == 'y':
                if x[j] == acceptablewordsyfinal[i][j]:
                    rejecty.append(acceptablewordsyfinal[i])
    acceptablewordsyfinalfinal = []
    for i in acceptablewordsyfinal:
        if i not in rejecty:
            acceptablewordsyfinalfinal.append(i)

    acceptablewordsfinal = []
    acceptablewordsfinallong = acceptablewordsyfinalfinal + acceptablewordsgfinal + acceptablewordsbfinal
    finalnums = [0 for i in range(len(acceptablewordsfinallong))]
    for i in range(len(acceptablewordsfinallong)):
        finalnums[i] = acceptablewordsfinallong.count(acceptablewordsfinallong[i])
    for i in range(len(acceptablewordsfinallong)):
        counts = [len(acceptablewordsyfinal), len(acceptablewordsbfinal), len(acceptablewordsgfinal)]
        if finalnums[i] == 3 - counts.count(0):
            acceptablewordsfinal.append(acceptablewordsfinallong[i])
    acceptablewordsfinal = list(set(acceptablewordsfinal))

    wordlewords = acceptablewordsfinal

    print(acceptablewordsfinal)

    guesses += 1

    if len(acceptablewordsfinal) == 1:
        checker = True

if acceptablewordsfinal[0] == key:
    print('Solver converged to ' + acceptablewordsfinal[0] + ' in ' + str(guesses) + ' guesses.')
else:
    print('Solver failed to converge.')

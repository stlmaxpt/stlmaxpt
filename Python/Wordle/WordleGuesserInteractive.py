testfile = "words5txt"

wordlewords = []

with open(testfile) as filein:
    for line in filein:
        if line[len(line) - 2] != '*':
            eachword = line[len(line) - 6:len(line) - 1]
        else:
            eachword = line[len(line) - 8:len(line) - 3]
        wordlewords.append(eachword.lower())

guesses = 0

checker = False

while checker is not True and guesses < 6:
    acceptablewordsg = []
    acceptablewordsb = []
    acceptablewordsy = []
    acceptablewords = []
    x = input('Guessed word: ')
    y = input('Given hints: ')
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

print('Solver converged in ' + str(guesses) + ' guesses.')

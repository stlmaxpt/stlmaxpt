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
        eachword = line[len(line) - 6:len(line) - 1]
        wordlewords.append(eachword.lower())


key = getword(wordlewords)
guesses = 0
numguesses = 6
results = [['r' for l in range(len(key))] for j in range(numguesses)]

while guesses <= numguesses:
    x = input('Guess a word with ' + str(len(key)) + ' letters: ')
    if len(x) == len(key):
        guesses += 1
        if x == key:
            if guesses == 1:
                print('Success in ' + str(guesses) + ' guess')
            elif guesses > 1:
                print('Success in ' + str(guesses) + ' guesses')
            break
        for j in range(len(key)):
            inword = False
            rightplace = False
            if x[j] in key:
                inword = True
            if x[j] == key[j]:
                rightplace = True
            if inword is True and rightplace is False:
                results[guesses - 1][j] = 'y'
            elif inword is True and rightplace is True:
                results[guesses - 1][j] = 'g'
            else:
                results[guesses - 1][j] = 'b'

        print('Current status:')
        num2colors(results)

        if guesses == numguesses:
            print('Better luck next time!')
            print('Answer was: ' + key)
            break
    elif len(x) < len(key):
        print('Not enough letters! Guess again.')
    elif len(x) > len(key):
        print('Too many letters! Guess again.')

import re
def filter(inF):
    ouFile = open(inF + '-filtered', 'w')
    inFile = open(inF)
    for line in inFile:
        line = line.strip()
        g = re.findall(r'(\w+)', line)
        for x in g:
            if (x.isupper()):
                if x[0:3] != 'NM_':
                    ouFile.write(x + '\n')
    inFile.close()
    ouFile.close()

#filter('parkinson-down')
filter('parkinson-up')

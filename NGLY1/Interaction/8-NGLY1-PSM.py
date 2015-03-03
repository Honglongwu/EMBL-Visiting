inFile = open('BIOGRID-ALL-Interaction')
for line in  inFile:
    line = line.strip()
    fields = line.split('\t')
    if fields[0][0:3] == 'PSM'  and fields[1][0:3] == 'PSM':
        print(line)
inFile.close()

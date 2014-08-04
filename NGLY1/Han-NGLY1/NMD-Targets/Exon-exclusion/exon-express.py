inFile = open('exonBaseMean-ALL-sample.txt')
for line in inFile:
    line = line.strip()
    fields = line.split()
    if sum([float(x) for x in fields[1:]]) >= 50: 
        print(line)
inFile.close()

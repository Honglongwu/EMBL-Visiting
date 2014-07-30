inFile = open('UPF1-regulated.txt')
D = {}
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    fs =(fields[4]).strip().split(';')
    for x in fs:
        D[x] = 1
inFile.close()

inFile = open('de.txt')
line = inFile.readline()
for line in inFile:
    line = line.strip()
    fields = line.split()
    try:
        if float(fields[6]) <0.01:
            if fields[7] in D:
                print(line)
    except:
        pass
inFile.close()

inFile = open('UPF1-regulated.txt')
D = {}
line = inFile.readline()
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    if float(fields[5]) > 0:
        fs =(fields[4]).strip().split(';')
        for x in fs:
            if x.find(' ')==-1 and len(x) > 0:
                D[x] = 1
inFile.close()
print(len(D))




'''
inFile = open('DE_treatment_six_samples.txt')
line = inFile.readline()
for line in inFile:
    line = line.strip()
    fields = line.split()
    if fields[1] in D:
        print(line)
inFile.close()
'''

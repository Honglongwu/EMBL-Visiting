inFile = open('UPF1-regulated.txt')
D = {}
line = inFile.readline()
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    if float(fields[5]) > 0:
        fs =(fields[4]).strip().split(';')
        for x in fs:
            D[x] = 1
inFile.close()



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

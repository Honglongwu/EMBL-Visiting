inFile = open('BIOGRID-ALL-3.2.115.tab2.txt')
ouFile1 = open('BIOGRID-ALL-Interaction', 'w')
ouFile2 = open('BIOGRID-ALL-Interaction-No-UBC', 'w')
head = inFile.readline()
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    ouFile1.write(fields[7] + '\t' + fields[8] + '\n')
    if fields[7] != 'UBC' and fields[8] != 'UBC':
        ouFile2.write(fields[7] + '\t' + fields[8] + '\n')
inFile.close()
ouFile1.close()
ouFile2.close()

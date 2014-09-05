inFile = open('NGLY1-unmapped.aligned.paired4')
while True:
    line = inFile.readline().strip()
    if line:
        line_next = inFile.readline().strip()
        fields = line_next.split('\t')
    else:
        break

inFile.close()

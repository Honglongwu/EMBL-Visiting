inFile = open('ENSG00000151092-GRCh37-transcripts-unique-region')
while True:
    line1 = inFile.readline().strip()
    line2 = inFile.readline().strip()
    if line1:
        gene = line1.split('"')[1]
        print(gene)
    else:
        break
inFile.close()

inFile = open('uniprot_sprot.fasta.fa')
ouFile = open('Human_uniprot_sprot.fasta.fa', 'w')
while True:
    line1 = inFile.readline()
    line2 = inFile.readline()
    if line1:
        if line1.find('HUMAN') != -1:
            ouFile.write(line1)
            ouFile.write(line2)
    else:
        break

inFile.close()
ouFile.close()

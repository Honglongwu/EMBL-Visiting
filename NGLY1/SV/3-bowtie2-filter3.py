import string
trans = string.maketrans('atcgATCG','tagcTAGC')
inFile = open('NGLY1-unmapped.aligned.paired')
ouFile = open('NGLY1-unmapped.aligned.paired2', 'w')
while True:
    line1 = inFile.readline().strip()
    line2 = inFile.readline().strip()
    if line1:
        seq1 = line1.split('\t')[9]
        seq2 = line2.split('\t')[9]
        seq2_rev = string.translate(seq2[::-1], trans)
        if seq1 != seq2 and seq1 != seq2_rev:
            ouFile.write(line1 + '\n')
            ouFile.write(line2 + '\n')
    else:
        break
inFile.close()
ouFile.close()

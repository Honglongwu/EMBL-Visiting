#!/usr/bin/env python
import sys
import string

Codon={'TTT':'F','TTC':'F','TCT':'S','TCC':'S','TAT':'Y','TAC':'Y','TGT':'C','TGC':'C','TTA':'L','TCA':'S','TAA':'*','TGA':'*','TTG':'L','TCG':'S','TAG':'*','TGG':'W','CTT':'L','CTC':'L','CCT':'P','CCC':'P','CAT':'H','CAC':'H','CGT':'R','CGC':'R','CTA':'L','CTG':'L','CCA':'P','CCG':'P','CAA':'Q','CAG':'Q','CGA':'R','CGG':'R','ATT':'I','ATC':'I','ACT':'T','ACC':'T','AAT':'N','AAC':'N','AGT':'S','AGC':'S','ATA':'I','ACA':'T','AAA':'K','AGA':'R','ATG':'M','ACG':'T','AAG':'K','AGG':'R','GTT':'V','GTC':'V','GCT':'A','GCC':'A','GAT':'D','GAC':'D','GGT':'G','GGC':'G','GTA':'V','GTG':'V','GCA':'A','GCG':'A','GAA':'E','GAG':'E','GGA':'G','GGG':'G'}

def translate(seq):
    six = []
    trans = string.maketrans('atcgATCG','tagcTAGC')
    seq1 = seq.upper()
    seq2 = string.translate(seq1[::-1],trans)
    for i in range(3):
        pep = []
        for j in range(i,len(seq1),3):
            c = seq1[j:j+3]
            if len(c) == 3:
                pep.append(Codon[c])
        six.append(''.join(pep))
    for i in range(3):
        pep = []
        for j in range(i,len(seq2),3):
            c = seq2[j:j+3]
            if len(c) == 3:
                pep.append(Codon[c])
        six.append(''.join(pep))

    return six


D = {}
inFile = open('Homo_sapiens_NGLY1_GRCh38_3_25699113_25803551_sequence_and_some_ENST.fa')
while True:
    line1 = inFile.readline().strip()
    if line1:
        six = translate(line1)
        for i in range(len(six)):
            seq=six[i].split('*')
            for x in seq:
                if x:
                    D[x] = 1
    else:
        break
inFile.close()
ouFile = open('Homo_sapiens_NGLY1_GRCh38_3_25699113_25803551_sequence_and_some_ENST_peptide.fa', 'w')
n = 0
for x in D:
    if len(x) >= 20:
        n += 1
        ouFile.write('>GENOME|Q96IV0-18-%d(ENST00000280700)|NGLY1_HUMAN\n'%n)
        ouFile.write(x + '\n')
ouFile.close()


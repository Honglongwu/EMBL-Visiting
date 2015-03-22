#!/usr/bin/env python
import sys
import string

Codon = {'ACC': 'T', 'ATG': 'M', 'AAG': 'K', 'AAA': 'K', 'ATC': 'I', 'AAC': 'N', 'ATA': 'I', 'AGG': 'R', 'CCT': 'P', 'CTC': 'L', 'AGC': 'S', 'ACA': 'T', 'AGA': 'R', 'CAT': 'H', 'AAT': 'N', 'ATT': 'I', 'CTG': 'L', 'CTA': 'L', 'ACT': 'T', 'CAC': 'H', 'ACG': 'T', 'CAA': 'Q', 'AGT': 'S', 'CCA': 'P', 'CCG': 'P', 'CCC': 'P', 'TAT': 'Y', 'GGT': 'G', 'TGT': 'C', 'CGA': 'R', 'CAG': 'Q', 'CGC': 'R', 'GAT': 'D', 'CGG': 'R', 'CTT': 'L', 'TGC': 'C', 'GGG': 'G', 'TAG': '*', 'GGA': 'G', 'TAA': '*', 'GGC': 'G', 'TAC': 'Y', 'GAG': 'E', 'TCG': 'S', 'TTA': 'L', 'TTT': 'F', 'GAC': 'D', 'CGT': 'R', 'GAA': 'E', 'TCA': 'S', 'GCA': 'A', 'GTA': 'V', 'GCC': 'A', 'GTC': 'V', 'GCG': 'A', 'GTG': 'V', 'TTC': 'F', 'GTT': 'V', 'GCT': 'A', 'TGA': '*', 'TTG': 'L', 'TCC': 'S', 'TGG': 'W', 'TCT': 'S'}

def translate(seq):
    six = []
    trans = string.maketrans('atcgATCG','tagcTAGC')
    seq1 = seq
    seq2 = string.translate(seq[::-1],trans)
    for i in range(3):
        pep = []
        for j in range(i,len(seq1),3):
            c = seq1[j:j+3].upper()
            if len(c) == 3:
                pep.append(Codon[c])
        six.append(''.join(pep))
    '''
    for i in range(3):
        pep = []
        for j in range(i,len(seq2),3):
            c = seq2[j:j+3].upper()
            if len(c) == 3:
                pep.append(Codon[c])
        six.append(''.join(pep))
    '''

    return six


inF = 'Saccharomyces_cerevisiae.R64-1-1.ncrna.fa.fa'
inFile = open(inF)
ouFile = open(inF+'.pep','w')
while True:
    line1 = inFile.readline().strip()
    line2 = inFile.readline().strip()
    if line1:
        fields = line1.split('\t')
        six = translate(line2)
        for i in range(len(six)):
            #if six[i].find('*')==-1:
            ouFile.write(line1+':'+str(i)+'\n')
            ouFile.write(six[i]+'\n')
    else:
        break
inFile.close()
ouFile.close()



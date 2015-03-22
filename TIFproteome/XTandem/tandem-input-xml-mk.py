#!/usr/bin/env python
import sys
import os

DIR = 'input-Tryp'

F = os.listdir(DIR)

L = []

for inF in F:
    if inF[-4:]=='.mzML':
        ouF = inF.split('.mzML')[0]+'.xml'
        ouFile = open(ouF,'w')

        ouFile.write('<?xml version="1.0"?>\n')
        ouFile.write('<bioml>\n')
        ouFile.write('\t<note type="input" label="spectrum, parent monoisotopic mass error plus">10</note>\n')
        ouFile.write('\t<note type="input" label="spectrum, parent monoisotopic mass error minus">10</note>\n')
        ouFile.write('\t<note type="input" label="spectrum, parent monoisotopic mass isotope error">no</note>\n')
        ouFile.write('\t<note type="input" label="list path, default parameters">default_input.xml</note>\n')
        ouFile.write('\t<note type="input" label="list path, taxonomy information">taxonomy.xml</note>\n')
        ouFile.write('\t<note type="input" label="residue, modification mass">57.022@C</note>\n')
        #ouFile.write('\t<note type="input" label="residue, modification mass 1">57.022@C,8@K,10@R</note>\n')
        ouFile.write('\t<note type="input" label="protein, cleavage site">[RK]|{P}</note>\n')
        ouFile.write('\t<note type="input" label="refine">no</note>\n')
        ouFile.write('\t<note type="input" label="protein, taxon">homo sapiens</note>\n')
        ouFile.write('\t<note type="input" label="spectrum, path">input/%s</note>\n'%inF)
        ouFile.write('\t<note type="input" label="output, path">output/%s</note>\n'%ouF)
        ouFile.write('</bioml>\n')

        ouFile.close()
    
        ouF2 = inF[0:-4]+'.sh'
        ouFile2 = open(ouF2,'w')
        cwd = os.getcwd().split('/inputxml')[0]
        ouFile2.write('cd %s\n\n'%cwd)
        ouFile2.write('tandem.exe inputxml/%s\n'%ouF)
        ouFile2.close()
        L.append(ouF2)

ouFile = open('qsub.sh','w')
for item in L:
    ouFile.write('qsub -l nodes=cu11 %s\n'%item)
ouFile.close()


N = 20
n = 0
for i in range(0,len(L),N):
    n += 1
    ouFile = open('run-%d.sh'%n,'w')
    ouFile.write('cd %s\n'%os.getcwd())
    for x in range(N):
        if x+i < len(L): 
            ouFile.write('sh %s\n'%L[i+x])
    ouFile.close()



    


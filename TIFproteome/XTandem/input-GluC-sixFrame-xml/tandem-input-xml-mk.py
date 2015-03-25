#!/usr/bin/env python
import sys
import os

input_spec = 'input-GluC'

input_xml = os.getcwd().split('/')[-1]
output_xml = 'output' + input_xml[5:]

if not os.path.exists('../'+ output_xml):
    os.makedirs('../'+ output_xml)


DIR = '../' + input_spec
F = os.listdir(DIR)

L = []

for inF in F:
    if inF[-5:]=='.mzML':
        ouF = inF.split('.mzML')[0]+'.xml'
        ouFile = open(ouF,'w')

        ouFile.write('<?xml version="1.0"?>\n')
        ouFile.write('<bioml>\n')
        ouFile.write('\t<note type="input" label="spectrum, parent monoisotopic mass error plus">10</note>\n')
        ouFile.write('\t<note type="input" label="spectrum, parent monoisotopic mass error minus">10</note>\n')
        ouFile.write('\t<note type="input" label="spectrum, parent monoisotopic mass isotope error">no</note>\n')
        ouFile.write('\t<note type="input" label="list path, default parameters">default_input.xml</note>\n')
        ouFile.write('\t<note type="input" label="list path, taxonomy information">taxonomy-sixFrame.xml</note>\n')
        ouFile.write('\t<note type="input" label="residue, modification mass">57.022@C</note>\n')
        #ouFile.write('\t<note type="input" label="residue, modification mass 1">57.022@C,8@K,10@R</note>\n')
        ouFile.write('\t<note type="input" label="protein, cleavage site">[ED]|[X]</note>\n')
        ouFile.write('\t<note type="input" label="refine">no</note>\n')
        ouFile.write('\t<note type="input" label="protein, taxon">Saccharomyces cerevisiae</note>\n')
        ouFile.write('\t<note type="input" label="spectrum, path">%s/%s</note>\n'%(input_spec,inF))
        ouFile.write('\t<note type="input" label="output, path">%s/%s</note>\n'%(output_xml,ouF))
        ouFile.write('</bioml>\n')

        ouFile.close()
    
        ouF2 = inF.split('.mzML')[0]+'.sh'
        ouFile2 = open(ouF2,'w')
        cwd = '/'.join(os.getcwd().split('/')[0:-1])
        ouFile2.write('cd %s\n\n'%cwd)
        ouFile2.write('tandem.exe %s/%s\n'%(input_xml,ouF))
        ouFile2.close()
        L.append(ouF2)
ouFile = open('qsub.sh','w')
for item in L:
    ouFile.write('sh %s\n'%item)
ouFile.close()


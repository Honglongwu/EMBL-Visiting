#!/usr/bin/env python
from xml.etree.ElementTree import *
import sys

class Spectrum:
    def __init__(self):
        self.name = ''
        self.protein = []
class Protein:
    def __init__(self):
        self.name = ''
        self.attr = ''
        self.seq = ''
        self.peptide = []
class Peptide:
    def __init__(self):
        self.seq = ''
        self.attr = ''
        self.modification = []


inF = sys.argv[1]
ouFile = open(sys.argv[1]+'.txt','w')
tree = ElementTree()
tree.parse(inF)
group=tree.findall('group')
for item in group :
    if item.get('id') :
        Spec = Spectrum()
        #s = item.findall('group/note')
        #if len(s) == 1:
        #    Spec.name = s[0].text.strip()
        #else:
        #    print('spec error')
        s = item.getchildren()[-1].getchildren()[0].get('label')
        if s.find('.spectrum') != -1:
            Spec.name=s
        else:
            print('spec error')

        pro=item.findall('protein')
        for x in pro :
            p = Protein()
            s = x.findall('note')
            if len(s) == 1:
                p.name = s[0].text.strip()
            else:
                print('protein error')
            s = x.findall('peptide')
            if len(s)==1:
                p.attr = s[0].get('start')+':'+s[0].get('end')+':'+x.get('expect')
            else:
                print('protein peptide error')
            pep = x.findall('peptide/domain')
            for y in pep:
                pe = Peptide()
                pe.seq = y.get('seq')
                pe.attr = y.get('start')+':'+y.get('end')+':'+y.get('expect')+':'\
                        +y.get('hyperscore')+':'+y.get('nextscore')+':'+y.get('pre')+':'+y.get('post')+':'+y.get('missed_cleavages')
                mod = y.findall('aa')
                for m in mod:
                    pe.modification.append(m.get('type'))
                    pe.modification.append(m.get('at'))
                    pe.modification.append(m.get('modified'))
                p.peptide.append(pe)
            Spec.protein.append(p)

        ouFile.write(Spec.name+'\t')
        for protein in Spec.protein:
            for peptide in protein.peptide:
                ouFile.write(protein.name+'\t'+protein.attr+'\t'+peptide.seq+'\t'+peptide.attr+'\t'+':'.join(peptide.modification)+'\t')
        ouFile.write('\n')

ouFile.close()

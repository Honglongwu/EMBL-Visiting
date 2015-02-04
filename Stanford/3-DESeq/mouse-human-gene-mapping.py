D = {}
inFile = open('/g/steinmetz/hsun/Stanford/data/Ensembl/Ortholog-Human-Mouse.txt')
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    mouse = fields[2]
    D.setdefault(mouse, [])
    D[mouse].append(line)
inFile.close()

def ortholog(inF):
    inFile = open(inF)
    ouFile = open(inF.split('.txt')[0] + '.ortholog.txt','w')
    head = inFile.readline()
    ouFile.write(head)
    for line in inFile:
        line = line.strip()
        fields = line.split('\t')
        mouse = fields[0]
        if mouse in D:
            print(D[mouse])
            ouFile.write(line + '\t' + D[mouse][0] + '\n')
        else:
            ouFile.write(line + '\t' + '' + '\n')
    inFile.close()
    ouFile.close()

ortholog('de_ENGase-KO_Double-KO_immortP3.sig.txt')
    

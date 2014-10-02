D = {}

def similar(k, D):
    for y in D:
        x = y.split('\t')
        if (x[0] == k[0] and -10<=int(x[1]) - int(k[1]) <=10 and x[2] == k[2] and -10 <= int(x[3]) - int(k[3]) <= 10) \
                or (x[0] == k[2] and -10<=int(x[1]) - int(k[3]) <=10 and x[2] == k[0] and -10 <= int(x[3]) - int(k[1]) <= 10):
                    return y
    return 0
inFile = open('NGLY1-unmapped.aligned.paired3')
ouFile = open('NGLY1-unmapped.aligned.paired4','w')
while True:
    line1 = inFile.readline().strip()
    line2 = inFile.readline().strip()
    if line1:
        fields1 = line1.split('\t')
        fields2 = line2.split('\t')
        ch1 = fields1[2]
        pos1 = fields1[3]
        ch2 = fields2[2]
        pos2 = fields2[3]
        k = [ch1,pos1,ch2,pos2]
        x = similar(k, D)
        if x:
            D[x].append([line1, line2])
        else:
            D.setdefault('\t'.join(k),[[line1, line2]])
    else:
        break
inFile.close()
d = D.items()
d.sort(cmp=lambda x,y:cmp(len(x[1]),len(y[1])),reverse= True)
for x in d:
    if len(x[1]) > 1:
        ouFile.write('>' + str(len(x[1]))+ '\t' + x[0]+'\n')
        for y in x[1]:
            ouFile.write('\n'.join(y)+'\n')
ouFile.close()

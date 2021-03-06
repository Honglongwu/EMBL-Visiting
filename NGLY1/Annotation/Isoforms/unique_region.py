Region = {}
inFile = open('ENSG00000151092-GRCh37-transcripts-unique-region')
while True:
    line1 = inFile.readline().strip()
    line2 = inFile.readline().strip()
    if line1:
        gene = line1.split('"')[1]
        fields = line2.split('\t')
        min = int(fields[0])
        max = int(fields[-1])
        i = min
        while i <= max:
            if str(i) in fields:
                start = i
                j = i+1
                while j <= max:
                    if j == max:
                        end = j 
                        Region.setdefault(gene, [])
                        Region[gene].append([start, end])
                        i = j + 1
                        break
                    elif str(j) not in fields:
                        end = j - 1
                        Region.setdefault(gene, [])
                        Region[gene].append([start, end])
                        i = j + 1
                        break
                    else:
                        j += 1
            else:
                i += 1
                        
    else:
        break
inFile.close()
ouFile = open('ENSG00000151092-GRCh37-transcripts-unique-region2', 'w')
if __name__=='__main__':
    for k in Region:
        ouFile.write(k+'\n')
        for x in Region[k]:
            for y in x:
                ouFile.write(str(y) + '\t')
        ouFile.write('\n')
ouFile.close()

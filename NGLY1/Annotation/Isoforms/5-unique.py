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
                        print(start)
                        print(end)
                        i = j + 1
                        break
                    elif str(j) not in fields:
                        end = j - 1
                        print(start)
                        print(end)
                        i = j + 1
                        break
                    else:
                        j += 1
                        
    else:
        break
inFile.close()

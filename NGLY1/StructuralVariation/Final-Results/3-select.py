inFile = open('NGLY1-Structural-Variatioin-Candidates-cut5-sample3')
Sample = ['CP1','CP2','CP3','CP4','FCP1','MCP1','CP1-B','CP3-B','MCP1-B','Ctrl-B','Ctrl-19']
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    if fields[6] == '0' and fields[7] == '0' and fields[10] == '0' and fields[11] == '0' and  fields[12] == '0':
        print(line)
    
inFile.close()

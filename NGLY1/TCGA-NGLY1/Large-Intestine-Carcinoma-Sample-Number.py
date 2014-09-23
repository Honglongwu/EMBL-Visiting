D = {}

inFile = open('READ__unc.edu__illuminaga_rnaseqv2__rsem.genes.results__Jul-08-2014.txt')
head = inFile.readline().strip()
for x in head[2:]:
    D[x]=1
inFile.close()

inFile = open('READ__unc.edu__illuminahiseq_rnaseqv2__rsem.genes.results__Jul-08-2014.txt')
head = inFile.readline().strip()
for x in head[2:]:
    D[x]=1
inFile.close()

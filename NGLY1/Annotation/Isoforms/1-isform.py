D = {}
inFile = open('ENSG00000151092-GRCh37')
ouFile = open('ENSG00000151092-GRCh37-transcripts', 'w')
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    transcript_id = fields[-1].split(';')[1].strip()
    exon_number = fields[-1].split(';')[2].strip()

    if fields[2] == 'exon':
        D.setdefault(transcript_id, [])
        D[transcript_id].append([exon_number, fields[3], fields[4]])
inFile.close()

for k in D:
    ouFile.write(k+'\t'+'\t'.join(['\t'.join(x) for x in D[k]])+'\n')

CP1 = {}
inFile = open('CP1.six.txt')
head = inFile.readline()
for line in inFile:
    line = line.strip()
    fields = line.split()
    CP1[fields[0]]=[fields[2],fields[-2]]
inFile.close()

CP2 = {}
inFile = open('CP2.six.txt')
head = inFile.readline()
for line in inFile:
    line = line.strip()
    fields = line.split()
    CP2[fields[0]]=[fields[2],fields[-2]]
inFile.close()

CP3 = {}
inFile = open('CP3.six.txt')
head = inFile.readline()
for line in inFile:
    line = line.strip()
    fields = line.split()
    CP3[fields[0]]=[fields[2],fields[-2]]
inFile.close()

CP4 = {}
inFile = open('CP4.six.txt')
head = inFile.readline()
for line in inFile:
    line = line.strip()
    fields = line.split()
    CP4[fields[0]]=[fields[2],fields[-2]]
inFile.close()

MCP1 = {}
inFile = open('MCP1.six.txt')
head = inFile.readline()
for line in inFile:
    line = line.strip()
    fields = line.split()
    MCP1[fields[0]]=[fields[2],fields[-2]]
inFile.close()

FCP1 = {}
inFile = open('FCP1.six.txt')
head = inFile.readline()
for line in inFile:
    line = line.strip()
    fields = line.split()
    FCP1[fields[0]]=[fields[2],fields[-2]]
inFile.close()

RAW= {}
inFile = open('NGLY1-raw-count.txt')
head = inFile.readline()
for line in inFile:
    line = line.strip()
    fields = line.split()
    RAW[fields[0]]=fields[1:]
inFile.close()

GENE = {}
inFile = open('DE_treatment_six_samples.txt')
for line in inFile:
    line = line.strip()
    fields = line.split()
    GENE[fields[0]]=fields[1]
inFile.close()

ouFile = open('NGLY1-significant-gene-six-individul.txt','w')
cp1='CP1_AzaC_biorep1\tCP1_AzaC_biorep2\tCP1_DMSO_biorep1\tCP1_DMSO_biorep2\tCP1_AzaC_DMSO_log2_fold_change\tCP1_AzaC_DMSO_padj'
cp2='CP2_AzaC_biorep1\tCP2_AzaC_biorep2\tCP2_DMSO_biorep1\tCP2_DMSO_biorep2\tCP2_AzaC_DMSO_log2_fold_change\tCP2_AzaC_DMSO_padj'
cp3='CP3_AzaC_biorep1\tCP3_AzaC_biorep2\tCP3_DMSO_biorep1\tCP3_DMSO_biorep2\tCP3_AzaC_DMSO_log2_fold_change\tCP3_AzaC_DMSO_padj'
cp4='CP4_AzaC_biorep1\tCP4_AzaC_biorep2\tCP4_DMSO_biorep1\tCP4_DMSO_biorep2\tCP4_AzaC_DMSO_log2_fold_change\tCP4_AzaC_DMSO_padj'
fcp1='FCP1_AzaC_biorep1\tFCP1_AzaC_biorep2\tFCP1_DMSO_biorep1\tFCP1_DMSO_biorep2\tFCP1_AzaC_DMSO_log2_fold_change\tFCP1_AzaC_DMSO_padj'
mcp1='MCP1_AzaC_biorep1\tMCP1_AzaC_biorep2\tMCP1_DMSO_biorep1\tMCP1_DMSO_biorep2\tMCP1_AzaC_DMSO_log2_fold_change\tMCP1_AzaC_DMSO_padj'
ouFile.write('Gene\tGene_Ensembl_ID\t'+'\t'.join([cp1,cp2,cp3,cp4,fcp1,mcp1])+'\n')
for k in RAW:
    ouFile.write(GENE[k]+'\t'+k+'\t'+'\t'.join(RAW[k][0:4])+'\t'+'\t'.join(CP1[k])+'\t'+'\t'.join(RAW[k][4:8])+'\t'+'\t'.join(CP2[k])+'\t'+'\t'.join(RAW[k][8:12])+'\t'+'\t'.join(CP3[k])+'\t'+'\t'.join(RAW[k][12:16])+'\t'+'\t'.join(CP4[k]) +'\t'+'\t'.join(RAW[k][16:20])+'\t'+'\t'.join(FCP1[k])+'\t'+'\t'.join(RAW[k][20:24])+'\t'+'\t'.join(MCP1[k])+'\n')

ouFile.close()



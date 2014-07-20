import os
Fs = os.listdir('.')
for F in Fs:
    if F[-4:] == '.bam':
        raw = F[0:-4] + '.raw.vcf'
        filtered = F[0:-4] + '.flt.vcf'
        ouFile = open(F[0:-4] + '.sh', 'w')
        ouFile.write('cd /g/steinmetz/hsun/NGLY1/SNV/alignment_filtered\n')
        ouFile.write('#samtools mpileup -uDf /g/steinmetz/hsun/NGLY1/SNV/Homo_sapiens.GRCh37.68.dna.chromosomes.withIVTs.fa %s | bcftools view -bvcg - > %s \n'%(F, raw))
        ouFile.write('bcftools view %s |/g/steinmetz/hsun/MySoft/samtools/samtools-0.1.19/bcftools/vcfutils.pl varFilter - > %s\n'%(raw, filtered))
        ouFile.close()


cd /g/steinmetz/hsun/NGLY1/Virus/NGLY1-unmapped-bam-fasta
db=/g/steinmetz/hsun/NGLY1/Genome/viral.1.1.genomic.fna.fa
query=ngly1_FCP1_20uM_AzaC_rep1_lane7.fasta
out=${query}.blated
blat $db $query -out=blast8 $out

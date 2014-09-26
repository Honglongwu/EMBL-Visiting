#!/bin/bash
cd /g/steinmetz/hsun/NGLY1/Virus/NGLY1-unmapped-bam-fasta-BCells
db=/g/steinmetz/hsun/NGLY1/Genome/viral.1.1.genomic.fna.fa
query=ngly1_CP3-B_1_lane8.fasta
out=${query}.blated
blat $db $query -out=blast8 $out

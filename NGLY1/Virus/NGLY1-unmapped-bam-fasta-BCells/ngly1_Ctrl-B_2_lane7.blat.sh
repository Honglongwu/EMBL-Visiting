#!/bin/bash
cd /g/steinmetz/hsun/NGLY1/Virus/NGLY1-unmapped-bam-fasta-BCells
db=/g/steinmetz/hsun/NGLY1/Genome/viral.1.1.genomic.fna.fa
query=ngly1_Ctrl-B_2_lane7.fasta
out=${query}.blated
blat $db $query -out=blast8 $out

#!/bin/bash
cd /g/steinmetz/hsun/NGLY1/SV
db=/g/steinmetz/hsun/NGLY1/Genome/Homo_sapiens.GRCh37.68.dna.chromosomes.withIVTs.viral.fa
query=ngly1_CP1_20uM_AzaC_rep1_lane7.fasta
out=${query}.blated
blat $db $query -out=blast8 $out

#!/bin/bash
cd /g/steinmetz/hsun/NGLY1/SV
db=/g/steinmetz/hsun/NGLY1/Genome/Homo_sapiens.GRCh37.68.dna.chromosomes.withIVTs.viral.fa
query=ngly1_ngly1_MCP1_20uM_AzaC_rep2_lane7.fasta
out=${query}.blated
blat $db $query -out=blast8 $out

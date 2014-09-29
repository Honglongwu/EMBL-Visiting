#!/bin/bash
cd /g/steinmetz/hsun/NGLY1/Virus/NGLY1-unmapped-bam-fasta
db=/g/steinmetz/hsun/NGLY1/Genome/HumanUn-and-Viral.fa
query=ngly1_CP1_20uM_AzaC_rep2_lane8.fasta.blated
out=${query}.blated
blat $db $query -out=blast8 $out

#!/bin/bash
cd /g/steinmetz/hsun/NGLY1/Virus/NGLY1-unmapped-bam-fasta
db=/g/steinmetz/hsun/NGLY1/Genome/HumanUn-and-Viral.fa
query=ngly1_CP2_DMSO_rep2_lane6.fasta.blated
out=${query}.blated
blat $db $query -out=blast8 $out

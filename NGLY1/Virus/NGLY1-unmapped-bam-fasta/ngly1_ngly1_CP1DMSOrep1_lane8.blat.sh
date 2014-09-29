#!/bin/bash
cd /g/steinmetz/hsun/NGLY1/Virus/NGLY1-unmapped-bam-fasta
db=/g/steinmetz/hsun/NGLY1/Genome/HumanUn-and-Viral.fa
query=ngly1_ngly1_CP1DMSOrep1_lane8.fasta
out=${query}.blated
blat $db $query -out=blast8 $out

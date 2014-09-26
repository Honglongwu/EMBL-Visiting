#!/bin/bash
cd /g/steinmetz/hsun/NGLY1/Virus/NGLY1-unmapped-bam-fasta-BCells
db=/g/steinmetz/hsun/NGLY1/Genome/viral.1.1.genomic.fna.fa
query=ngly1_MCP1-B_2_lane8.fasta
out=${query}.blated
blat $db $query -out=blast8 $out

#!/bin/bash
cd /g/steinmetz/hsun/NGLY1/SV
db=/g/steinmetz/hsun/NGLY1/Genome/Homo_sapiens.GRCh37.68.dna.chromosomes.withIVTs.viral.fa
query=test.3.fa
out=${query}.blated
blat $db $query -out=blast8 $out

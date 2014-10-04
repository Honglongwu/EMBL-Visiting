cd /g/steinmetz/hsun/NGLY1/StructuralVariation
db=/g/steinmetz/hsun/NGLY1/Genome/Homo_sapiens.GRCh37.68.dna.chromosomes.withIVTs.fa
query=NGLY1-unmapped.aligned.paired6
out=${query}.blated
blat $db $query -out=blast8 $out

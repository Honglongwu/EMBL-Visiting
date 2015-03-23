cd /g/steinmetz/hsun/NGLY1/StructuralVariation
db=/g/steinmetz/hsun/MySoft/ANNOVAR/annovar/humandb/hg19_refGeneMrna.fa
query=NGLY1-unmapped.aligned.paired6.blated.filtered.seq2.fa
out=${query}.blated
blat $db $query -out=blast8 $out

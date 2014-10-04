cd /g/steinmetz/hsun/NGLY1/StructuralVariation
db=/g/steinmetz/hsun/NGLY1/Data/Human-Un/Human-Un.fa
query=NGLY1-unmapped.aligned.paired5
out=${query}.blated
blat $db $query -out=blast8 $out

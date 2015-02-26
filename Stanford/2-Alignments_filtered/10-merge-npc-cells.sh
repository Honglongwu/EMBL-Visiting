
samtools merge -r -@ 10 -1 CP1-NPC_biorep1.bam CP1-NPC-A2_biorep1.bam CP1-NPC-A2_biorep2.bam
samtools merge -r -@ 10 -1 CP1-NPC_biorep2.bam CP1-NPC-A3_biorep1.bam CP1-NPC-A3_biorep2.bam

samtools index CP1-NPC_biorep1.bam
samtools index CP1-NPC_biorep2.bam



samtools merge -r -@ 10 -1 NGLY1-KO_biorep3_primaryP4.bam NGLY1-KO_biorep3_primaryP4_2014.10.21.bam NGLY1-KO_biorep3_primaryP4_2014.11.10.bam
samtools index NGLY1-KO_biorep3_primaryP4.bam
samtools merge -r -@ 10 -1 Double-KO_biorep1_primaryP4.bam Double-KO_biorep1_primaryP4_2014.10.21.bam Double-KO_biorep1_primaryP4_2014.11.10.bam
samtools index Double-KO_biorep1_primaryP4.bam
samtools merge -r -@ 10 -1 WT_biorep3_primaryP4.bam WT_biorep3_primaryP4_2014.10.21.bam WT_biorep3_primaryP4_2014.11.10.bam
samtools index WT_biorep3_primaryP4.bam
samtools merge -r -@ 10 -1 WT_biorep1_primaryP4.bam WT_biorep1_primaryP4_2014.10.21.bam WT_biorep1_primaryP4_2014.11.10.bam
samtools index WT_biorep1_primaryP4.bam
samtools merge -r -@ 10 -1 NGLY1-KO_biorep1_primaryP4.bam NGLY1-KO_biorep1_primaryP4_2014.10.21.bam NGLY1-KO_biorep1_primaryP4_2014.11.10.bam
samtools index NGLY1-KO_biorep1_primaryP4.bam
samtools merge -r -@ 10 -1 ENGase-KO_biorep1_primaryP4.bam ENGase-KO_biorep1_primaryP4_2014.10.21.bam ENGase-KO_biorep1_primaryP4_2014.11.10.bam
samtools index ENGase-KO_biorep1_primaryP4.bam
samtools merge -r -@ 10 -1 NGLY1-KO_biorep2_primaryP4.bam NGLY1-KO_biorep2_primaryP4_2014.10.21.bam NGLY1-KO_biorep2_primaryP4_2014.11.10.bam
samtools index NGLY1-KO_biorep2_primaryP4.bam
samtools merge -r -@ 10 -1 WT_biorep2_primaryP4.bam WT_biorep2_primaryP4_2014.10.21.bam WT_biorep2_primaryP4_2014.11.10.bam
samtools index WT_biorep2_primaryP4.bam
samtools merge -r -@ 10 -1 Double-KO_biorep2_primaryP4.bam Double-KO_biorep2_primaryP4_2014.10.21.bam Double-KO_biorep2_primaryP4_2014.11.10.bam
samtools index Double-KO_biorep2_primaryP4.bam

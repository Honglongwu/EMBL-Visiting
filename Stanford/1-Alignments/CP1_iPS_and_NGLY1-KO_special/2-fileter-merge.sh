samtools view -@ 10 -q 30 -b /g/steinmetz/hsun/Stanford/1-Alignments/CP1_iPS_and_NGLY1-KO_special/CP1_iPS_lane7_toMouse/accepted_hits.bam > NGLY1-KO-biorep2-immportP3-lane7.bam
samtools view -@ 10 -q 30 -b /g/steinmetz/hsun/Stanford/1-Alignments/CP1_iPS_and_NGLY1-KO_special/CP1_iPS_lane8_toMouse/accepted_hits.bam > NGLY1-KO-biorep2-immportP3-lane8.bam

samtools view -@ 10 -q 30 -b /g/steinmetz/hsun/Stanford/1-Alignments/CP1_iPS_and_NGLY1-KO_special/NGLY1-KO_WT_lane7_toHuman/accepted_hits.bam > CP1-iPS-biorep2-lane7.bam
samtools view -@ 10 -q 30 -b /g/steinmetz/hsun/Stanford/1-Alignments/CP1_iPS_and_NGLY1-KO_special/NGLY1-KO_WT_lane8_toHuman/accepted_hits.bam > CP1-iPS-biorep2-lane8.bam

samtools merge -r -@ 10 -1 NGLY1-KO-biorep2-immportP3.bam  NGLY1-KO-biorep2-immportP3-lane7.bam NGLY1-KO-biorep2-immportP3-lane8.bam
samtools merge -r -@ 10 -1  CP1-iPS-biorep2.bam  CP1-iPS-biorep2-lane7.bam  CP1-iPS-biorep2-lane8.bam

samtools index NGLY1-KO-biorep2-immportP3.bam
samtools index CP1-iPS-biorep2.bam



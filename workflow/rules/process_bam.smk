rule process_bam:
    input:
        cell_bam = "results/split_bams/{barcode}.bam"
    output:
        clean_bam = "results/clean_bams/{barcode}.clean_sorted.bam",
        clean_bai = "results/clean_bams/{barcode}.clean_sorted.bam.bai",
        flagstat_filtered = "results/flagstat/{barcode}.flagstat.filtered.txt",
        flagstat_original = "results/flagstat/{barcode}.flagstat.original.txt"
    params:
        tmp_bam = "results/clean_bams/{barcode}.tmp.bam",
        header = "results/clean_bams/{barcode}.tmp.header.sam"
    container:
        config["docker_img"]
    shell:
        """
        samtools view -F 3844 -q 30 -hbS {input} | samtools sort -o {params.tmp_bam}
        samtools view -H {params.tmp_bam} | sed "1s/.*/@HD\tVN:1.3\tSO:coordinate/" > {params.header}
        samtools reheader {params.header} {params.tmp_bam} > {output.clean_bam}
        samtools index {output.clean_bam}
        samtools flagstat {output.clean_bam} > {output.flagstat_filtered}
        samtools flagstat {input.cell_bam} > {output.flagstat_original}
        """
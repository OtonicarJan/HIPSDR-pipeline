rule read_counter:
    input:
        bam="results/clean_bams/{barcode}.clean_sorted.bam"
    output:
        seg="results/readCounts/{barcode}_counts_" + str(config["binsize"]) + "kb.seg"
    params:
        binsize=int(config["binsize"])*1000
    container:
        config["docker_img"]
    shell:
        """
        readCounter -q 30 -w {params.binsize} \
        -c chr1,chr2,chr3,chr4,chr5,chr6,chr7,chr8,chr9,chr10,chr11,chr12,chr13,chr14,chr15,chr16,chr17,chr18,chr19,chr20,chr21,chr22,chrX,chrY \
        {input.bam} > {output.seg}
        """
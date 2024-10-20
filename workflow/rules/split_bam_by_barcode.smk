rule split_bam_by_barcode:
    input:
        config["bamfile"]
    output:
        "results/split_bams/{barcode}.bam"
    container:
        config["docker_img"]
    params:
        bar="{barcode}"
    threads:
        12
    shell:
        """
        echo "{params.bar}\t{params.bar}" > results/{params.bar}.txt

        sinto filterbarcodes -b {input} -c results/{params.bar}.txt -p {threads} --outdir results/split_bams/

        rm results/{params.bar}.txt
        """

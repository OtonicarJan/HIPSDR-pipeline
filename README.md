# HIPSDR-seq pipeline

Snakemake pipeline to split and process the initial BAM file to multiple BAM files and .seg files.

First clone this repo:

```bash
git clone git@github.com:OtonicarJan/HIPSDR-pipeline.git

cd HIPSDR-pipeline
```

If you are using Singularity, do:

```bash
singularity build HIPSD.sif docker://jotonicar/HIPSD
```

If you have snakemake installed, you can run the pipeline:
```bash
snakemake --jobs 999 --latency-wait 60 --use-singularity --singularity-args \
"-B /cellranger/outs/" --cluster-config config/cluster.json --cluster \
"bsub -R {cluster.resources} -q {cluster.queue} -n {cluster.nCPUs} -J {cluster.name} -o {cluster.output} -e {cluster.error}"
```

In `config.yaml` you can set up the inputs for the pipeline: barcodes and cellranger's output BAM file.

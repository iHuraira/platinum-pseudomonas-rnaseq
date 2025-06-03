configfile: "config/config.yaml"

with open(config["samples"]) as f:
    samples = [line.strip() for line in f if line.strip()]

include: "rules/download.smk"
include: "rules/fastq_convert.smk"
include: "rules/qc.smk"
include: "rules/trim.smk"
include: "rules/star_index.smk"
include: "rules/star_align.smk"
include: "rules/sorted_bam.smk"
include: "rules/read_counts.smk"

rule all:
    input:
        expand("results/aligned/{sample}.sorted.bam", sample=samples),
        expand("results/aligned/{sample}.sorted.bam.bai", sample=samples),
        expand("results/counts/{sample}.counts.txt", sample=samples)


configfile: "config/config.yaml"

with open(config["samples"]) as f:
    samples = [line.strip() for line in f if line.strip()]

include: "rules/download.smk"
include: "rules/fastq_convert.smk"
include: "rules/qc.smk"
include: "rules/multi_qc.smk"
include: "rules/trim.smk"
include: "rules/salmon_index.smk"
include: "rules/salmon_quant.smk"
include: "rules/deseq2.smk"

rule all:
    input:
        expand("results/trim/{sample}/{sample}_1.fastq", sample=samples),
        expand("results/trim/{sample}/{sample}_2.fastq", sample=samples),
        expand("results/qc/{sample}/{sample}_1_fastqc.html", sample=samples),
        expand("results/qc/{sample}/{sample}_1_fastqc.zip", sample=samples),
        expand("results/qc/{sample}/{sample}_2_fastqc.html", sample=samples),
        expand("results/qc/{sample}/{sample}_2_fastqc.zip", sample=samples),
        "resources/genome/salmon_index",
        expand("results/salmon/{sample}", sample=samples),
        "results/dge_complete.flag",
        "results/qc/multiqc_report.html"


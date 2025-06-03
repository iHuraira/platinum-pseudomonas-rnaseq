configfile: "config/config.yaml"

with open(config["samples"]) as f:
    samples = [line.strip() for line in f if line.strip()]


include: "rules/download.smk"
include: "rules/fastq_convert.smk"

rule all:
    input:
        expand("results/fastq/{sample}/{sample}_1.fastq", sample=samples),
        expand("results/fastq/{sample}/{sample}_2.fastq", sample=samples)




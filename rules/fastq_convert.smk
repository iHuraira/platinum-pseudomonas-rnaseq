rule fastq_convert:
    input: 
        "results/sra/{sample}/{sample}.sra"
    conda:
        "../envs/fastq_convert.yaml"
    output:
        "results/fastq/{sample}/{sample}_1.fastq",
        "results/fastq/{sample}/{sample}_2.fastq"
    shell:
        "fasterq-dump {input} --outdir results/fastq/{wildcards.sample}"
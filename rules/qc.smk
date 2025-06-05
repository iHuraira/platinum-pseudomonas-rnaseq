rule quality_control:
    input: 
        r1="results/fastq/{sample}/{sample}_1.fastq",
        r2="results/fastq/{sample}/{sample}_2.fastq"
    conda:
        "../envs/qc.yaml"
    output:
        r1_html="results/qc/{sample}/{sample}_1_fastqc.html",
        r1_zip="results/qc/{sample}/{sample}_1_fastqc.zip",
        r2_html="results/qc/{sample}/{sample}_2_fastqc.html",
        r2_zip="results/qc/{sample}/{sample}_2_fastqc.zip"
    shell:
        """
        mkdir -p results/qc/{wildcards.sample}
        fastqc {input.r1} --outdir results/qc/{wildcards.sample}
        fastqc {input.r2} --outdir results/qc/{wildcards.sample}
        """




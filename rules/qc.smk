rule quality_control:
    input: 
        "results/fastq/{sample}/{sample}_1.fastq",
        "results/fastq/{sample}/{sample}_2.fastq"
    conda:
        "../envs/qc.yaml"
    output:
        "results/qc/{sample}_1_fastqc.html",
        "results/qc/{sample}_1_fastqc.zip",
        "results/qc/{sample}_2_fastqc.html",
        "results/qc/{sample}_2_fastqc.zip"
    shell:
        """
        fastqc {input[0]} --outdir results/qc
        fastqc {input[1]} --outdir results/qc
        """

rule multiqc:
    input:
        expand("results/qc/{sample}_1_fastqc.zip", sample=samples),
        expand("results/qc/{sample}_2_fastqc.zip", sample=samples)
    output:
        "results/qc/multiqc_report.html"
    conda:
        "../envs/qc.yaml"
    shell:
        """
        multiqc results/qc --outdir results/qc
        """

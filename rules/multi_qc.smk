rule multiqc:
    input:
        expand("results/qc/{sample}/{sample}_1_fastqc.zip", sample=samples),
        expand("results/qc/{sample}/{sample}_2_fastqc.zip", sample=samples)
    output:
        "results/qc/multiqc_report.html"
    conda:
        "../envs/qc.yaml"
    shell:
        """
        multiqc results/qc --outdir results/qc
        """

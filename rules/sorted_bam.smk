rule sort_index_bam:
    input:
        bam = "results/aligned/{sample}.bam"
    output:
        sorted = "results/aligned/{sample}.sorted.bam",
        index = "results/aligned/{sample}.sorted.bam.bai"
    threads: 2
    conda:
        "../envs/samtools.yaml"
    shell:
        """
        samtools sort -@ {threads} -o {output.sorted} {input.bam}
        samtools index {output.sorted}
        """

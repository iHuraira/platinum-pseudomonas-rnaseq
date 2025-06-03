rule count_reads:
    input:
        bam = "results/aligned/{sample}.sorted.bam",
        annotation = "resources/genome/annotation.gtf"
    output:
        "results/counts/{sample}.counts.txt"
    conda:
        "../envs/subread.yaml"
    shell:
        """
        featureCounts -T {threads} -p -a {input.annotation} -o {output} {input.bam}
        """

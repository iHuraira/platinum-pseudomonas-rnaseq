rule salmon_quant:
    input:
        r1 = "results/trim/{sample}/{sample}_1.fastq",
        r2 = "results/trim/{sample}/{sample}_2.fastq",
        index = "resources/salmon_index"
    output:
        "results/salmon/{sample}/quant.sf"
    conda:
        "../envs/salmon.yaml"
    threads: 4
    shell:
        """
        salmon quant -i {input.index} \
                      -l A \
                      -1 {input.r1} -2 {input.r2} \
                      -p {threads} \
                      -o results/salmon/{wildcards.sample}
        """

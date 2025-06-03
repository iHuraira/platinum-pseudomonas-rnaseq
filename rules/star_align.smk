rule star_align:
    input:
        read1 = "results/trim/{sample}_1.fastq",
        read2 = "results/trim/{sample}_2.fastq",
        index = config["genome_index"]
    output:
        bam = "results/aligned/{sample}.unsorted.bam"
    threads: config["threads"]
    conda:
        "../envs/star.yaml"
    shell:
        """
        STAR --runThreadN {threads} \
             --genomeDir {input.index} \
             --readFilesIn {input.read1} {input.read2} \
             --outSAMtype BAM Unsorted \
             --outFileNamePrefix results/aligned/{wildcards.sample}_ \
            --outStd BAM_Unsorted > {output.bam}
        """

rule star_index:
    input:
        fasta = config["genome_fasta"],
        gtf = config["annotation_gtf"]
    output:
        directory(config["genome_index"])
    threads: config["threads"]
    conda:
        "../envs/star.yaml"
    shell:
        """
        STAR --runThreadN {threads} \
             --runMode genomeGenerate \
             --genomeDir {output} \
             --genomeFastaFiles {input.fasta} \
             --sjdbGTFfile {input.gtf} \
             --sjdbOverhang 100
        """

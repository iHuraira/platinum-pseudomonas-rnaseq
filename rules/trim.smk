rule trim_reads:
    input:
        read1 = "results/fastq/{sample}/{sample}_1.fastq",
        read2 = "results/fastq/{sample}/{sample}_2.fastq"
    output:
        trimmed_read1 = "results/trim/{sample}_1.fastq",
        trimmed_read2 = "results/trim/{sample}_2.fastq",
        unpaired_read1 = "results/trim/{sample}_1_unpaired.fastq",
        unpaired_read2 = "results/trim/{sample}_2_unpaired.fastq"
    conda:
        "../envs/trim.yaml"
    params:
        adapters = config["adapters"]
    threads:
        config["threads"]
    shell:
        """
        trimmomatic PE -threads {threads} -phred33 \
        {input.read1} {input.read2} \
        {output.trimmed_read1} {output.unpaired_read1} \
        {output.trimmed_read2} {output.unpaired_read2} \
        ILLUMINACLIP:{params.adapters}:2:30:10 \
        LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
        """

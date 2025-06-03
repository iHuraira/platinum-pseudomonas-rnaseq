rule download:
    output:
        "results/sra/{sample}/{sample}.sra"
    conda:
        "../envs/sra.yaml"
    shell:
        "prefetch {wildcards.sample} -O results/sra/"

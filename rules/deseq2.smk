rule deseq2_dge:
    input:
        quant = expand("results/salmon/{sample}/quant.sf", sample=samples),
        metadata = "config/samples.tsv"
    output:
        touch("results/dge_complete.flag")
    conda:
        "../envs/deseq2.yaml"
    script:
        "../scripts/deseq2_dge.R"

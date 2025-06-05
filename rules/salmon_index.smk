rule salmon_index:
    input:
        "resources/genome/transcripts.fa"
    output:
        directory("resources/genome/salmon_index")
    conda:
        "../envs/salmon.yaml"
    shell:
        """
        salmon index -t {input} -i {output}
        """

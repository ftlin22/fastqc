#!/usr/bin/env nextflow


params.input = "/Users/ftl7634/fastqc_1/input_reads/*.fastq.gz"
read_pair = Channel.fromPath(params.input)

process runFastQC{

    input:
        each in_fastq from read_pair

    """
    mkdir output_fastqc
    fastqc --outdir output_fastqc \
    ${in_fastq}
"""

}

workflow.onComplete {

    println ( workflow.success ? """
        Pipeline execution summary
        ---------------------------
        Completed at: ${workflow.complete}
        Duration    : ${workflow.duration}
        Success     : ${workflow.success}
        workDir     : ${workflow.workDir}
        exit status : ${workflow.exitStatus}
        """ : """
        Failed: ${workflow.errorReport}
        exit status : ${workflow.exitStatus}
        """
    )
}

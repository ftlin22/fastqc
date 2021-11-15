#! /usr/bin/env nextflow

/*************************************
 FastQC
 *************************************/


 def helpMessage() {
     log.info """
      Usage:
      The typical command for running the pipeline is as follows:
      nextflow run main.nf fastqc -h
      """
 }
 
  // Show help message
 if (params.help) {
     helpMessage()
     exit 0
 }
 

raw_reads = params.rawReads
out_dir = file(params.outDir)

out_dir.mkdir()

read_pair = Channel.fromFilePairs("${raw_reads}/*R[1,2].fastq", type: 'file')

process runFastQC{
    tag { "${params.projectName}.rFQC.${sample}" }
    cpus { 2 }
    publishDir "${out_dir}/qc/raw/${sample}", mode: 'copy', overwrite: false

    input:
        set sample, file(in_fastq) from read_pair

    output:
        file("${sample}_fastqc/*.zip") into fastqc_files

    """
    mkdir ${sample}_fastqc
    fastqc --outdir ${sample}_fastqc \
    -t ${task.cpus} \
    ${in_fastq.get(0)} \
    ${in_fastq.get(1)}
    """
}

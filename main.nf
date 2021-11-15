#!/usr/bin/env nextflow

process foo {
  conda 'fastqc=0.11.9'

  '''
  fastqc -h
  '''
}

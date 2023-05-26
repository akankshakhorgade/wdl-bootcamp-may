version 1.0
workflow SamtoolsMetrics {
  input {
    File inputBam 
  }
  call indexBam{
    input: 
      bam_path = inputBam
  }
  output {
    File outpath = indexBam.counts_idxstats
  }
}

task indexBam{
  input {
    File bam_path
  }
  command <<<
    samtools index ~{bam_path}
    samtools idxstats ~{bam_path} > counts.txt 
  >>>
  output {
   File counts_idxstats = "counts.txt"
  }
  runtime {
    docker: "us-east4-docker.pkg.dev/methods-dev-lab/masseq-dataproc/masseq_prod:tag1"
  }
}

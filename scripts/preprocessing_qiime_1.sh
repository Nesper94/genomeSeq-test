#!/bin/bash
### Preproccessing with QIIME2 2020.8 ####
# Script 1

#mkdir dir_name
#cd dir_name

#In the "Earth Microbiome Project (EMP) protocol" format for paired-end reads, 
#there are three ``fastq.gz`` files, one containing forward sequence reads, one 
#containing reverse sequence reads, and one containing the associated barcode 
#reads, with the sequence data still multiplexed. The order of the records in 
#the three ``fastq.gz`` files defines the association between the sequences 
#reads and barcode reads.

source activate qiime2-2020.8

qiime tools import \
  --type 'SampleData[PairedEndSequencesWithQuality]' \ 
  --input-path manifest.tsv \
  --output-path demux.qza \
  --source-format PairedEndFastqManifestPhred33

qiime demux summarize \
  --i-data demux.qza \
  --o-visualization demux.qzv

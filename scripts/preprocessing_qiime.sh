#!/bin/bash
### Preproccessing with QIIME2 2020.8 ####

#mkdir dir_name
#cd dir_name

#In the "Earth Microbiome Project (EMP) protocol" format for paired-end reads, there are three ``fastq.gz`` files, one containing forward sequence reads, one containing reverse sequence reads, and one containing the associated barcode reads, with the sequence data still multiplexed. The order of the records in the three ``fastq.gz`` files defines the association between the sequences reads and barcode reads.

qiime tools import \
  --type 'SampleData[PairedEndSequencesWithQuality]' \ 
  --input-path manifest.csv \
  --output-path demux.qza \
  --source-format PairedEndFastqManifestPhred33

qiime demux summarize \
  --i-data demux.qza \
  --o-visualization demux.qzv

qiime dada2 denoise-paired \
  --i-demultiplexed-seqs demux.qza \
  --p-trim-left-f 0 \
  --p-trim-left-r 0 \
  --p-trunc-len-f 0 \
  --p-trunc-len-r 0 \
  --o-representative-sequences rep-seqs-dada2.qza \
  --o-table table-dada2.qza \
  --o-denoising-stats stats-dada2.qza
  --verbose

#Cambiar el nombre de los archivos, por ejemplo que las tablas no queden con el dada2 en el nombre 

#Para generar finalmente las tablas de ASV

qiime feature-table summarize \
  --i-table table.qza \
  --o-visualization table.qzv \
  --m-sample-metadata-file sample-metadata.tsv
qiime feature-table tabulate-seqs \
  --i-data rep-seqs.qza \
  --o-visualization rep-seqs.qzv

#!/bin/bash
### Preproccessing with QIIME2 2020.8 ####
# Script 2

source activate qiime2-2020.8

# Cambiar los flags --p-* según sea necesario dependiendo de la visualización
# de demux.qzv
qiime dada2 denoise-paired \
  --i-demultiplexed-seqs demux.qza \
  --p-trim-left-f "$1" \
  --p-trim-left-r "$2" \
  --p-trunc-len-f "$3" \
  --p-trunc-len-r "$4" \
  --o-representative-sequences rep-seqs.qza \
  --o-table table.qza \
  --o-denoising-stats stats-dada2.qza
  --verbose

#Para generar finalmente las tablas de ASV

qiime feature-table summarize \
  --i-table table.qza \
  --o-visualization table.qzv \
  --m-sample-metadata-file metadata.tsv

qiime feature-table tabulate-seqs \
  --i-data rep-seqs.qza \
  --o-visualization rep-seqs.qzv

# Bitácora trabajo datos espermosfera

## 2020-03-04 Árbol filogenético a partir de clasificación taxonómica

Usando el archivo **table-dada2.qza** y el archivo **taxonomy.qza** arrojado por el clasificador de Qiime usando como datos de entrenamiento secuencias de Silva se ejecutó el siguiente comando:

```bash
qiime taxa collapse \
      --i-table table-dada2.qza \
      --i-taxonomy taxonomy.qza \
      --p-level 6 \ # or whatever level of taxonomy you want
      --output-dir taxtable/
```

Esto estaba en esta página: https://forum.qiime2.org/t/how-to-make-classic-otu-table-with-qiime2/3612/3

En el directorio output "taxtable/" quedó un archivo llamado "collapsed-table.qza", este archivo fue descomprimido y luego el archivo **feature-table.biom** allí contenido fue convertido en un archivo .tsv usando el siguiente comando:

`(qiime2-2019.10) nesper@gojira-E402MA:~/Documentos/genomeseq/taxonomy-spermosphere/phylogenetic-tree/taxtable$ biom convert -i 8f17f216-8ae0-43ba-a691-fbb0428afc4d/data/feature-table.biom -o feature-table-taxonomy.tsv --to-tsv`


También se hizo un barplot de los taxones encontrados en la clasficación mediante el siguiente comando:

```bash
qiime taxa barplot \
  --i-table table-dada2.qza \
  --i-taxonomy taxonomy.qza \
  --m-metadata-file metadatos.tsv \
  --o-visualization taxa-bar-plots.qzv
```
  
Esto se hizo siguiendo las instrucciones de este enlace: https://chmi-sops.github.io/mydoc_qiime2.html#step-9-assign-taxonomy

La siguiente es la ruta absoluta del archivo "metadatos.tsv" original:
`/home/nesper/Documentos/maestría/maestría-sistemas-dinámicos/2019-2/semillero-bioinformatica/data/metadatos.tsv`

El archivo de salida fue visualizado con el comando:
`qiime tools view taxa-bar-plots.qzv`

![taxa-bar-plot-spermosphere](taxonomy-spermosphere/taxa-bar-plot-spe.png)

**Fig 1.** Taxonomical bar graphs showing the phyla of bacteria found in the different samples. Colors are presented from the top to the bottom of the graph (A: Ancestral, M: Modern, Soil: Uncultured soil).

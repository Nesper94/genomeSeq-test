#### Alpha diversity with QIIME2 2020.8

#Para esto requerimos una tabla de OTUs o de ASVs, resultado del preprocesamiento, en este caso con dada2. El output que esperamos es un carpeta
#llamada core metrics, en donde están todos lo índices de diversidad alfa.

qiime diversity core-metrics
 --i-table table.qza \
 --p-sampling-depth ` El número de secuencias menos uno, recomendación de Juanes, para ver esto se debe visualizar la tabla table.qza ` \
 --m-metadata-file metadata.tsv \ 
 --o-rarefied-table rarefied-table.qza \ 
 --o-observed-otus-vector observed-asvs-vector.qza \ 
 --o-shannon-vector shannon-vector.qza \ 
 --o-evenness-vector evenness-vector.qza \ 
 --o-jaccard-distance-matrix jaccard-distance-matrix.qza \ 
 --o-bray-curtis-distance-matrix bray-curtis-distance-matrix.qza \ 
 --o-jaccard-pcoa-results jaccard-pcoa-results.qza \ 
 --o-bray-curtis-pcoa-results bray-curtis-pcoa-results.qza\ 
 --o-jaccard-emperor jaccard-emperor.qzv \ 
 --o-bray-curtis-emperor bray-curtis-emperor.qzv \

# Indice de diversidad filogenética

#Además de los indices de diversidad más comunmente utilizados se puede obtener un indice de diversidad filogenetica: 'faith_pd'.
#Esta es una medida de la diversidad que incorpora las diferencias filogenéticas entre las especies.
#Primero necesitamos generar dos archivos importantes: unrooted-tree.qza y rooted-tree.qza.
#Para ello usamos la función align-to-tree-mafft-fasttree:

qiime phylogeny align-to-tree-mafft-fasttree \
 --i-sequences rep.seqs.qza \
 --o-alignment aligned-rep-seqs.qza \
 --o-masked-alignment masked-aligned-rep-seqs.qza \
 --o-tree unrooted-tree.qza \
 --o-rooted-tree rooted-tree.qza

#Ahora que tenemos estos archivos podemos generar el artefacto alpha-phylogenetic.qza que nos servira para hacer otros analisis que  $
#incorporen la diversidad filogenética. 

qiime diversity alpha-phylogenetic \
 --i-table table.qza \
 --i-phylogeny rooted-tree.qza \
 --p-metric 'faith_pd' \
 --o-alpha-diversity alpha-phylogenetic.qza

#ANALISIS DE SIGNIFICANCIA

qiime diversity alpha-group-significance \
 --i-alpha-diversity alpha-diversity-chao1.qza \
 --m-metadata-file metadata.tsv \
 --o-visualization alpha-group-significance.qzv

qiime diversity alpha-group-significance \
 --i-alpha-diversity alpha-phylogenetic.qza \
 --m-metadata-file metadata.tsv \
 --o-visualization alpha-group-significance.qzv

#Alpha-rarefaction

#Alpha-rarefación: con este grafico podemos explorar la alfa-diversidad como una función de la profundidad de muestreo (sampling depth).$
#Con el visualizador de la fución "qiime diversity alpha-rarefaction" podemos graficar uno o más indices de alfa-diversidad vs multiples$
#profundidades de muestreo 

qiime diversity alpha-rarefaction \
 --i-table table.qza \
 --p-max-depth 0 \
 --p-metrics 'observed_otus' \
 --m-metadata-file metadata.tsv \
 --o-visualization alpha-rarefaction3.qzv

#Es posible además hacer un plot de rarefacción con el indice de diversidad filigenetica:

qiime diversity alpha-rarefaction \
 --i-table table.qza \
 --i-phylogeny rooted-tree.qza \
 --p-max-depth 0 \
 --m-metadata-file metadata.tsv \
 --o-visualization alpha-rarefaction-with-phylogeny.qzv
 

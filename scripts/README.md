# Carpeta de scripts

En esta carpeta pondremos los scripts para procesar los datos. La idea es que mediante los scripts se pueda ejecutar TODO el proceso a partir de los datos en bruto.

## Guías

- El nombre de cada script debería hacer referencia a lo que hace ese script.
- Los scripts deben estar muy bien comentados, estos comentarios deben escribirse en inglés.
- Recordar que los scripts son también material suplementario del artículo, por lo tanto deben ser claros y estar escritos en inglés.
- La extensión del archivo debe concordar con el tipo de lenguaje usado en el script, por ejemplo, si se trata de un script de R 
debería llamarse `PCoA.R`, si es un archivo con comandos de la terminal de Linux debería ser `preprocesing.sh`.
- Debería especificarse qué versiones se usaron para cada programa, esta información puede añadirse como comentarios en el script 
o ejecutar comandos dentro del script que digan la version del programa.
- Se puede un solo script por análisis, por ejemplo, un solo script que calcule índices de alfa diversidad, y que ese script se use tanto para 
las tablas de OTUs como para las de ASVs. Los únicos scripts que deben ser diferentes son los que generan precisamente las tablas de OTUs o ASVs.
- Los nombres de los archivos input van a ser iguales en los 4 tratamientos (espermósfera ASVs, espermósfera OTUs, 
rizósfera ASVs, rizósfera OTUs) y usaremos en lo posible los mismos nombres que usa Qiime2 (e.g. `table.qza`).

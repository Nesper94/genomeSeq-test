#loading packages in windows####

library("ggplot2")
library("phyloseq")
library("vegan")

getwd()
#Ordination plots with phyloseq####


#BDiversidad
tmp <-read.delim("OTU_table_spermosphere.txt", h = T)
head(tmp)
c <- tmp[,2:37]
head(c)
d <- otu_table (c, taxa_are_rows = TRUE)
head(d)
mapfile          <- import_qiime_sample_data("metadata.txt") 
endo_metg         <- merge_phyloseq(d, mapfile)
head(otu_table(endo_metg))

#Analysis Without Soil# 

biom_modified <- subset_samples(endo_metg, !Plant_status=="Bulk_soil")


# Ordination: Bray_PCoA
endo_total.ord       <- ordinate(biom_modified, "NMDS", "manhattan", ~ Plant_status)
endo_plot            <- plot_ordination(biom_modified, endo_total.ord, type = "sites",
                                        color = "Plant_status",
                                        shape = "Plant_status",
                                        title = NULL, label = NULL)


all_plot_2       = endo_plot  + geom_point(aes(shape=Plant_status),   
                                           size = 4) + geom_text(aes(label = Plant_status), size=0) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), 
                                                                                                         rect = element_rect(fill = "white",  colour = "black", size = 0.5, linetype = 1),
                                                                                                         axis.ticks = element_line(colour = "black"),
                                                                                                         axis.title.x = element_text(face="plain", colour="black", size=15),
                                                                                                         axis.title.y = element_text(face="plain", colour="black", size=15),
                                                                                                         axis.text.x  = element_text(face="plain", colour = "black", angle=360, vjust=0.5, size=12),
                                                                                                         axis.text.y  = element_text(face="plain", colour = "black", angle=360, vjust=0.5, size=12),
                                                                                                         panel.background = element_rect(fill = "white", colour = "black", linetype = 1, size = 0.5),
                                                                                                         panel.border = element_blank())  + scale_colour_manual(values=c("orangered2","orchid2","aquamarine3","gold1","blueviolet","coral","chartreuse3", "gray")) + scale_shape_manual(values=c(16,16,16,16,16, 16,16,16)) 

all_plot_2
#+ labs(x = "PCoA 1 (19.3%)", y= "PCoA 2 (14.9%)")


#PERMANOVA
#PCoA####
Distance      <- phyloseq::distance(endo_metg, "jaccard")
adonis(Distance ~ Plant_status, as(sample_data(endo_metg), "data.frame"))


  #CAP#
perm_anova <- anova.cca(endo_total.ord)
perm_anova
perm_anovatest <- permutest(endo_total.ord)
perm_anovatest

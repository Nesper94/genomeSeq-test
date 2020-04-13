###########################################################################################
#                                                                                         #
#Scripts to reproduce the Figures  of Pérez-Jaramillo et al., 2016                        #
#Differential abundant features analysis using a Zero Inflated Gaussian Model             #
#from Paulson et al, 2013.                                                                #
#                                                                                         #
#                                                                                         #
#Juan Esteban Pérez Jaramillo - Victor J. Carrión                                         #
#Netherlands Institute of Ecology                                                         #
#j.perez@nioo.knaw.nl                                                                     #
#biojep@gmail.com                                                                         #
###########################################################################################




#Exporting Normalization####
exportMat(mat, file = file.path("/home/nesper/Documentos/genomeseq/rhizosphere/metagenomeSeq/datos-estefany/CSS_normalized_spermosphere2.txt")) #Colocar la ruta y el nombre del archivo#

res = fitZig(obj = obj, mod = mod, useCSSoffset = TRUE, control = settings)

#res$fit #This shows an error, see below:
################# 2020-04-04 Error report #####################
# Previous command gave the following error:
# Error in res$fit : $ operator not defined for this S4 class.
# Problem solution: Use @ instead of $ for S4 objects.
# Error will be commented and solution will be added. Other lines affected with the same problem will be corrected.
# Juan C. Arboleda R.
###############################################################
res@fit

#zigFit = res$fit #Error, solution below:
zigFit = res@fit
#finalMod = res$fit$design #Error, solution below:
finalMod = res@fit$design
finalMod
contrast.matrix = makeContrasts(Wild_A - Variety_G, levels = finalMod)
############### 2020-04-05 Error report ################
# Previous command gave the following error:
# Error in eval(ej, envir = levelsenv) : objeto 'Wild_A' no encontrado
# Error seems to be caused because Wild_A is not a column name in our table, we must use A1, A2, etc.
# Juan C. Arboleda R.
########################################################

fit2 = contrasts.fit(zigFit, contrast.matrix)
fit3 = eBayes(fit2)
toptable(fit3, coef="Wild_A - Variety_G")


res <- topTable(fit3,coef=1,adjust="BH",n=Inf)
head(res)

res[,6] = ifelse(res$adj.P.Val > 0.05,"gray", ifelse(res$logFC > -0 & res$logFC > 0,"green", "red")) #green, red, firebrick2, gold2, dodgerblue3, green4
size <- ifelse((res$adj.P.Val < 0.05 & abs(res$logFC) > 0), 4, 2)

write.table((res),"D:/Users/JuanP/Documents/Analysis of the sequences/MetagenomeSeq/Finalfiltering/A vs G.txt")

##Construct the plot object
g <- ggplot(data=res, aes(x=res[,1], y=-log10(res$P.Val))) +
  geom_point(size=size, colour=res[,6]) +
  theme_bw() + 
  xlim(c(-6, 6)) + ylim(c(0,10)) +
  xlab("log2 fold change") + ylab("-log10P.val") +
  guides(colour = guide_legend(override.aes = list(shape=16))) + 
  labs(title = "G22304 vs G5773")
g

# G22304    G51283k1   G50632I1      G50398       G23998       G5773        G14947       G51695        
#"Wild_A"  "Wild_C"   "Landrace_D"  "Landrace_E" "Landrace_F" "Variety_G"  "Variety_H"  "Variety_I"  











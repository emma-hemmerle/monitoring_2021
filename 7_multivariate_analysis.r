# R code for multivariate analysis
# We have downloaded the "vegan" package (vegetation analysis, contains many multivariate techniques)
install.packages("vegan")
library(vegan)
setwd("/Users/emmahemmerle/Documents/EDU/UniBo/Ecosystem Monitoring/R Lab")
getwd()
# loading a worksapce that contains several data sets
# you can see description of multivar analyis and data set in pdf presentation
load("biomes_multivar.RData")
# listing all of the objects that we have in our workspace
ls()
# reducing plots that would generate many dimensions into only 2 dimensions
# by looking at "biomes" you can figure out which biomes each row corresponds to by looking at which species are present
# distance on plot will determine whether they live together in space or not 

# Detrended Correlation Analysis DCA (Decorana) 
multivar<-decorana(biomes)
multivar
# you get the output of the analysis
# eigenvalues tell you how much variance is explained by each axis
# sum of eigenvalues is 1. 
# in this case with just the first 2 axes, you are explaining about 75% of the variance
plot(multivar)

#now looking at "biomes_types" data in our dataframe
biomes_types
attach(biome_types)
# putting an ellipse in the ordination (type of multivariate analysis, DCA related to this)
# using biome "type" column to group plots together, each with a different color. 
# ehull is the shape of the ellipse
# enclossing all of the plots belonging to a single biome within an ellipse
ordiellipse(multivar, type, col=c("black","red","green","blue"), kind = "ehull", lwd=3)
# at the moment we cannot see the names of the biomes on the plot. 
ordispider(multivar, type, col=c("black","red","green","blue"), label = T) 

#downloading the image we have obtained
pdf("multivar.pdf")
plot(multivar)
ordiellipse(multivar, type, col=c("black","red","green","blue"), kind = "ehull", lwd=3)
ordispider(multivar, type, col=c("black","red","green","blue"), label = T) 
dev.off()

# next step will be related to the use of remote sensing

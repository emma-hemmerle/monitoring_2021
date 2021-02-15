#setting my working directory 
setwd("/Users/emmahemmerle/Documents/EDU/UniBo/S1/Ecosystem Monitoring/R Lab/Final Exam")
getwd()


#recalling all of the libraries that I will be needing, and installing the ones I have not yet installed 
library(rgdal)
library(rgeos)
library(raster)
library(scales)
install.packages("dismo")
library(dismo)
install.packages("rgbif")
library(rgbif)
install.packages("maxnet")
install.packages("geosphere")
library(maxnet)
library(geosphere)


# downloading species occurence data from GBIF for Bombus affinis
# cleaning up occurence data into clean .csv file 

gbif <- read.csv('./GBIF/occurrences_bombus_affinis_min.csv',header=TRUE, sep=',')
head(gbif)
plot(decimalLatitude, decimalLongitude, pch=17, cex=0.35, col='blue')

# downloading world's borders dataset 
countries <- readOGR('./TM_WORLD_BORDERS_SIMPL-0.3/TM_WORLD_BORDERS_SIMPL-0.3.shp')
plot(countries, col='gray')
#adding species occurence data on top of world map
points(gbif$decimalLongitude,gbif$decimalLatitude,col='mediumseagreen',pch=17,cex=0.35)







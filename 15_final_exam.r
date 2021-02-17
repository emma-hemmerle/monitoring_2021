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

#plotting occurence coordinates in R
gbif <- read.csv('./GBIF/occurrences_bombus_affinis_min.csv',header=TRUE, sep=',')
head(gbif)
plot(decimalLatitude, decimalLongitude, pch=17, cex=0.35, col='blue')

# downloading world's borders dataset 
countries <- readOGR('./TM_WORLD_BORDERS_SIMPL-0.3/TM_WORLD_BORDERS_SIMPL-0.3.shp')
plot(countries, col='gray')
#adding species occurence data on top of world map
points(gbif$decimalLongitude,gbif$decimalLatitude,col='cyan',pch=20,cex=0.25)

# rescaling map over area of interest 
recordsSpatial <- SpatialPointsDataFrame(coords=cbind(gbif$decimalLongitude, gbif$decimalLatitude),data=gbif,proj4string=CRS('+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0'))
plot(recordsSpatial, col='white')
plot(countries, add=TRUE, col='gray')
points(recordsSpatial, pch=20, col='black',cex=0.25)

# downloading scaled species occurence map 
pdf("bombus_affinis_occurrence_map.pdf")
plot(recordsSpatial, col='white')
plot(countries, add=TRUE, col='gray')
points(recordsSpatial, pch=20, col='black',cex=0.25)
dev.off()


# Saving work done so far:
save.image('SDM project', compress=TRUE)

#staring off from where we had left off
setwd("/Users/emmahemmerle/Documents/EDU/UniBo/S1/Ecosystem Monitoring/R Lab/Final Exam")
load("/Users/emmahemmerle/Documents/EDU/UniBo/S1/Ecosystem Monitoring/R Lab/Final Exam/SDM Project")


# Using Historical Bioclim Data 
# Downloading 2.5 min data from worldclim 

#looking the mean annual temperature layer
mat <- raster('./WORLDCLIM/2.5m_bio_1970_2000/wc2.1_2.5m_bio_1.tif')
mat 
plot(mat,main="Mean Annual Temperature 1970-2000")

# downloading mean annual temperature map
pdf("Mean Annual Temp 1970-2000.pdf")
plot(mat,main="Mean Annual Temperature 1970-2000")
dev.off()

# creating a stack with all of the variables we have identified as relevant for our study 
WC01<-raster('./WORLDCLIM/2.5m_bio_1970_2000/wc2.1_2.5m_bio_1.tif')
WC03<-raster('./WORLDCLIM/2.5m_bio_1970_2000/wc2.1_2.5m_bio_3.tif')
WC04<-raster('./WORLDCLIM/2.5m_bio_1970_2000/wc2.1_2.5m_bio_4.tif')
WC05<-raster('./WORLDCLIM/2.5m_bio_1970_2000/wc2.1_2.5m_bio_5.tif')
WC12<-raster('./WORLDCLIM/2.5m_bio_1970_2000/wc2.1_2.5m_bio_12.tif')
WC15<-raster('./WORLDCLIM/2.5m_bio_1970_2000/wc2.1_2.5m_bio_15.tif')
WC17<-raster('./WORLDCLIM/2.5m_bio_1970_2000/wc2.1_2.5m_bio_17.tif')
bio_clim<-stack(WC01,WC03,WC04,WC05,WC12,WC15,WC17)
pdf("bio_clim_stack_1970_2000.pdf")
plot(bio_clim)
dev.off()

# clipping the bioclim rasters to fit our study area 
cropped_WC01<-crop(WC01, recordsSpatial)
cropped_WC03<-crop(WC03, recordsSpatial)
cropped_WC04<-crop(WC04, recordsSpatial)
cropped_WC05<-crop(WC05, recordsSpatial)
cropped_WC12<-crop(WC12, recordsSpatial)
cropped_WC15<-crop(WC15, recordsSpatial)
cropped_WC17<-crop(WC17, recordsSpatial)
cropped_bio_clim<-stack(cropped_WC01,cropped_WC03,cropped_WC04,cropped_WC05,cropped_WC12,cropped_WC15,cropped_WC17)
cropped_bio_clim<-crop(bio_clim, recordsSpatial)
fun <- function() {
points(recordsSpatial, pch=20, col='blue4',cex=0.25)
}
pdf("cropped_bio_clim_1970_2020.pdf")
plot(cropped_bio_clim, main=paste0('BIO', c(1,3,4,5,12,15,17)),addfun=fun)
dev.off()

dir.create('./WORLDCLIM/2.5m_bio_1970_2000/Study Region', recursive=TRUE, showWarnings=FALSE)
writeRaster(cropped_WC01,paste0('./WORLDCLIM/2.5m_bio_1970_2000/Study Region/cropped_WC01'), format='GTiff', datatype='INT2S',overwrite=TRUE)
writeRaster(cropped_WC03,paste0('./WORLDCLIM/2.5m_bio_1970_2000/Study Region/cropped_WC03'), format='GTiff', datatype='INT2S',overwrite=TRUE)
writeRaster(cropped_WC04,paste0('./WORLDCLIM/2.5m_bio_1970_2000/Study Region/cropped_WC04'), format='GTiff', datatype='INT2S',overwrite=TRUE)
writeRaster(cropped_WC05,paste0('./WORLDCLIM/2.5m_bio_1970_2000/Study Region/cropped_WC05'), format='GTiff', datatype='INT2S',overwrite=TRUE)
writeRaster(cropped_WC12,paste0('./WORLDCLIM/2.5m_bio_1970_2000/Study Region/cropped_WC12'), format='GTiff', datatype='INT2S',overwrite=TRUE)
writeRaster(cropped_WC15,paste0('./WORLDCLIM/2.5m_bio_1970_2000/Study Region/cropped_WC15'), format='GTiff', datatype='INT2S',overwrite=TRUE)
writeRaster(cropped_WC17,paste0('./WORLDCLIM/2.5m_bio_1970_2000/Study Region/cropped_WC17'), format='GTiff', datatype='INT2S',overwrite=TRUE)

# Saving work done so far:
save.image('SDM project', compress=TRUE)

# starting off from where we left off again 
setwd("/Users/emmahemmerle/Documents/EDU/UniBo/S1/Ecosystem Monitoring/R Lab/Final Exam")
load("/Users/emmahemmerle/Documents/EDU/UniBo/S1/Ecosystem Monitoring/R Lab/Final Exam/SDM Project")
ls()


# running a species distribution model using Maxent
# first we need to convert our raster files into .asc 
writeRaster(cropped_WC01,'./WORLDCLIM/2.5m_bio_1970_2000/Study Region/cropped_WC01.asc', format='ascii')
writeRaster(cropped_WC03,'./WORLDCLIM/2.5m_bio_1970_2000/Study Region/cropped_WC03.asc', format='ascii')
writeRaster(cropped_WC04,'./WORLDCLIM/2.5m_bio_1970_2000/Study Region/cropped_WC04.asc', format='ascii')
writeRaster(cropped_WC05,'./WORLDCLIM/2.5m_bio_1970_2000/Study Region/cropped_WC05.asc', format='ascii')
writeRaster(cropped_WC12,'./WORLDCLIM/2.5m_bio_1970_2000/Study Region/cropped_WC12.asc', format='ascii')
writeRaster(cropped_WC15,'./WORLDCLIM/2.5m_bio_1970_2000/Study Region/cropped_WC15.asc', format='ascii')
writeRaster(cropped_WC17,'./WORLDCLIM/2.5m_bio_1970_2000/Study Region/cropped_WC17.asc', format='ascii')
# running maxent with occurence and environmental data
# we get an .asc output that we convert into a raster in R
maxentoutput<-read.asciigrid('./maxent/Bombus_affinis.asc')
plot(maxentoutput)
raster(maxentoutput) -> rastermaxentoutput
writeRaster(rastermaxentoutput,'./maxent/rastermaxentoutput', format='GTiff',datatype='INT2S',overwrite=TRUE)
plot(rastermaxentoutput)


# reclassifying our raster output into present/absent predictions for our species 
# based on 10 percentile training presence
predictions<-c(0,0.349,0,0.349,1,1)
rpredictions<-matrix(predictions,ncol=3,byrow=TRUE)
predictionsmaxentoutput<-reclassify(rastermaxentoutput,rpredictions)
writeRaster(predictionsmaxentoutput,'./maxent/predictionsmaxentoutput', format='GTiff',datatype='INT2S',overwrite=TRUE)



#ploting the predicted distribution of Bombus affinis based on environmental var data 
cl<-colorRampPalette(c('gray','violetred'))(100)
pdf("Prediction Distribution of Bombus affinis.pdf")
plot(predictionsmaxentoutput, col=cl,main="Prediction Distribution of Bombus affinis")
dev.off()

# testing the goodness of our model
# omission test combined with binomial test, as well as the Area Under the Receiver Operating Curve (AUC)
# splitting the data set into two parts in maxent for training and testing (with random test percentage set at 30%)
# based on 30% test data and 10% minimum training presence we obtain an omission rate of 0.105, as well as a very small p-value
# the AUC based of the 30% test data is 0.907
# overall, we can conclude that our model is pretty good! 


###########

WC2061_2080_bio1<-raster('./WORLDCLIM/2.5m_bio_Future/wc2.1_2.5m_bioc_CNRM-CM6-1_ssp245_2061-2080.tif',band=1)
WC2061_2080_bio3<-raster('./WORLDCLIM/2.5m_bio_Future/wc2.1_2.5m_bioc_CNRM-CM6-1_ssp245_2061-2080.tif',band=3)
WC2061_2080_bio4<-raster('./WORLDCLIM/2.5m_bio_Future/wc2.1_2.5m_bioc_CNRM-CM6-1_ssp245_2061-2080.tif',band=4)
WC2061_2080_bio5<-raster('./WORLDCLIM/2.5m_bio_Future/wc2.1_2.5m_bioc_CNRM-CM6-1_ssp245_2061-2080.tif',band=5)
WC2061_2080_bio12<-raster('./WORLDCLIM/2.5m_bio_Future/wc2.1_2.5m_bioc_CNRM-CM6-1_ssp245_2061-2080.tif',band=12)
WC2061_2080_bio15<-raster('./WORLDCLIM/2.5m_bio_Future/wc2.1_2.5m_bioc_CNRM-CM6-1_ssp245_2061-2080.tif',band=15)
WC2061_2080_bio17<-raster('./WORLDCLIM/2.5m_bio_Future/wc2.1_2.5m_bioc_CNRM-CM6-1_ssp245_2061-2080.tif',band=17)
bio_clim_2061_2080<-stack(WC2061_2080_bio1,WC2061_2080_bio3,WC2061_2080_bio4,WC2061_2080_bio5,WC2061_2080_bio12,WC2061_2080_bio15,WC2061_2080_bio17)

#cropping to the extent we are interested in 

cropped_WC2061_2080_bio1<-crop(WC2061_2080_bio1, recordsSpatial)
cropped_WC2061_2080_bio3<-crop(WC2061_2080_bio3, recordsSpatial)
cropped_WC2061_2080_bio4<-crop(WC2061_2080_bio4, recordsSpatial)
cropped_WC2061_2080_bio5<-crop(WC2061_2080_bio5, recordsSpatial)
cropped_WC2061_2080_bio12<-crop(WC2061_2080_bio12, recordsSpatial)
cropped_WC2061_2080_bio15<-crop(WC2061_2080_bio15, recordsSpatial)
cropped_WC2061_2080_bio17<-crop(WC2061_2080_bio17, recordsSpatial)
cropped_WC2061_2080<-stack(cropped_WC2061_2080_bio1,cropped_WC2061_2080_bio3,cropped_WC2061_2080_bio4,cropped_WC2061_2080_bio5,cropped_WC2061_2080_bio12,cropped_WC2061_2080_bio15,cropped_WC2061_2080_bio17)

fun <- function() {
points(recordsSpatial, pch=20, col='blue4',cex=0.25)
}
pdf("cropped_bio_clim_2061_2080.pdf")
plot(cropped_WC2061_2080, main=paste0('BIO', c(1,3,4,5,12,15,17)),addfun=fun)
dev.off()

# saving individual files in directory

dir.create('./WORLDCLIM/2.5m_bio_Future/Study Region 61-80', recursive=TRUE, showWarnings=FALSE)
writeRaster(cropped_WC2061_2080_bio1,paste0('./WORLDCLIM/2.5m_bio_Future/Study Region 61-80/cropped_WC2021_2040_bio1'), format='GTiff', datatype='INT2S',overwrite=TRUE)
writeRaster(cropped_WC2061_2080_bio3,paste0('./WORLDCLIM/2.5m_bio_Future/Study Region 61-80/cropped_WC2021_2040_bio3'), format='GTiff', datatype='INT2S',overwrite=TRUE)
writeRaster(cropped_WC2061_2080_bio4,paste0('./WORLDCLIM/2.5m_bio_Future/Study Region 61-80/cropped_WC2021_2040_bio4'), format='GTiff', datatype='INT2S',overwrite=TRUE)
writeRaster(cropped_WC2061_2080_bio5,paste0('./WORLDCLIM/2.5m_bio_Future/Study Region 61-80/cropped_WC2021_2040_bio5'), format='GTiff', datatype='INT2S',overwrite=TRUE)
writeRaster(cropped_WC2061_2080_bio12,paste0('./WORLDCLIM/2.5m_bio_Future/Study Region 61-80/cropped_WC2021_2040_bio12'), format='GTiff', datatype='INT2S',overwrite=TRUE)
writeRaster(cropped_WC2061_2080_bio15,paste0('./WORLDCLIM/2.5m_bio_Future/Study Region 61-80/cropped_WC2021_2040_bio15'), format='GTiff', datatype='INT2S',overwrite=TRUE)
writeRaster(cropped_WC2061_2080_bio17,paste0('./WORLDCLIM/2.5m_bio_Future/Study Region 61-80/cropped_WC2021_2040_bio17'), format='GTiff', datatype='INT2S',overwrite=TRUE)

# converting them to .asc format to use in maxent 

writeRaster(cropped_WC2061_2080_bio1,'./WORLDCLIM/2.5m_bio_Future/Study Region 61-80/cropped_WC01.asc', format='ascii')
writeRaster(cropped_WC2061_2080_bio3,'./WORLDCLIM/2.5m_bio_Future/Study Region 61-80/cropped_WC03.asc', format='ascii')
writeRaster(cropped_WC2061_2080_bio4,'./WORLDCLIM/2.5m_bio_Future/Study Region 61-80/cropped_WC04.asc', format='ascii')
writeRaster(cropped_WC2061_2080_bio5,'./WORLDCLIM/2.5m_bio_Future/Study Region 61-80/cropped_WC05.asc', format='ascii')
writeRaster(cropped_WC2061_2080_bio12,'./WORLDCLIM/2.5m_bio_Future/Study Region 61-80/cropped_WC12.asc', format='ascii')
writeRaster(cropped_WC2061_2080_bio15,'./WORLDCLIM/2.5m_bio_Future/Study Region 61-80/cropped_WC15.asc', format='ascii')
writeRaster(cropped_WC2061_2080_bio17,'./WORLDCLIM/2.5m_bio_Future/Study Region 61-80/cropped_WC17.asc', format='ascii')

# run maxent with the future climate variables 
# running the occurence and environmental variable data, against the projection layers


# importing the maxent output into R
maxentoutputfuture<-read.asciigrid('./WORLDCLIM/2.5m_bio_Future/projection_output_2/Bombus_affinis_Cresson,_1863_Study Region 61-80.asc')
plot(maxentoutputfuture)
raster(maxentoutputfuture) -> rastermaxentoutputfuture
writeRaster(rastermaxentoutputfuture,'./WORLDCLIM/2.5m_bio_Future/projection_output_2/rastermaxentoutputfuture', format='GTiff',datatype='INT2S',overwrite=TRUE)
plot(rastermaxentoutputfuture)



# reclassifying our raster output into present/absent predictions for our species 
# based on 10 percentile training presence
futurepredictions<-c(0,0.349,0,0.349,1,1)
rfuturepredictions<-matrix(futurepredictions,ncol=3,byrow=TRUE)
futurepredictionsmaxentoutput<-reclassify(rastermaxentoutputfuture,rfuturepredictions)
writeRaster(futurepredictionsmaxentoutput,'./WORLDCLIM/2.5m_bio_Future/projection_output_2/futurepredictionsmaxentoutput', format='GTiff',datatype='INT2S',overwrite=TRUE)


#ploting the predicted distribution of Bombus affinis based on future environmental var data 
cl2<-colorRampPalette(c('grey','cyan'))(100)
pdf("Prediction Future Distribution of Bombus affinis 2061-2080.pdf")
plot(futurepredictionsmaxentoutput, col=cl2,main="Prediction Future Distribution of Bombus affinis")
dev.off()

# Now comparing the distribution predictions based on current climate data, and the ones based on future climate data 
# intersecting the two results using QGIS to get a final output map 

## Ecological relevance analysis based on the results and the methodological choices we have made throughout this project 


## saving everything we have done! 
save.image('SDM project', compress=TRUE)










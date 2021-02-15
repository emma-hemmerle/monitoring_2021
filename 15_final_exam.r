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
points(gbif$decimalLongitude,gbif$decimalLatitude,col='cyan',pch=20,cex=0.25)

# rescaling map over area of interest 
recordsSpatial <- SpatialPointsDataFrame(coords=cbind(gbif$decimalLongitude, gbif$decimalLatitude),data=gbif,proj4string=CRS('+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0'))
plot(recordsSpatial, col='white')
plot(countries, add=TRUE, col='gray')
points(recordsSpatial, pch=20, col='black',cex=0.25)

# downloading scaled species distribution map 
pdf("bombus_affinis_distrib_map.pdf")
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
dir.create('./WORLDCLIM/2.5m_bio_1970_2000/Study Region', recursive=TRUE, showWarnings=FALSE)
for (i in c(1,3,4,5,12,15,17) {print(paste('Clipping current WORLDCLIM raster', i))
                 flush.console()    
                 # get the world raster   
                 rast <- raster(paste0('./WORLDCLIM/2.5m_bio_1970_2000/wc2.1_2.5m_bio_',ifelse(i < 10, '0', ''), i, '.tif'))
                 # crop the raster and update metadata
                 rast <- crop(rast, studyExtent)
                 rast <- setMinMax(rast)
                 projection(rast) <-'+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0'
                 # save raster
                 writeRaster(rast,paste0('./WORLDCLIM/2.5m_bio_1970_2000/Study Region/WC',ifelse(i < 10, '0', ''), i), format='GTiff', datatype='INT2S',overwrite=TRUE)
                }
current <- stack(list.files('./WORLDCLIM/2.5m_bio_1970_2000/Study Region',full.names=TRUE,pattern='.tif'))
plot(current)


rast <- crop(./WORLDCLIM/2.5m_bio_1970_2000/wc2.1_2.5m_bio_1.tif, studyExtent)
rast <- setMinMax(rast)
projection(rast) <-'+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0'
     







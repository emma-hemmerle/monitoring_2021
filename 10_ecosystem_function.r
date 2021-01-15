# Ecosystem functions: energy flow and chemical cycling 
# Looking at NDVI (Normalized difference vegetation index): mounting the reflectance to look at biomass. To assess if the vegetation is alive and healthy
# High index indicates high biomass and low index indicates low biomass (e.g. unhealthy plants or no plants)
# using the function levelplot which takes the mean of all the NDVI values at each latitude lines
# it gives you an NDVI profile, and you can see where the NDVI values are highest very quickly (you can do the same on longitude, but the main pattern will be the presence of oceans actually
# look for Vegetation indicator data on Copernicus

library(rasterdiv)
library(raster)

data(copNDVI) #copernicus NDVI --> copernicus data already downloaded into the package
# mean of NDVI from 1999-2017 in June
plot(copNDVI)

#reclassifying our data, from 253 to 255 we remove the data, replace it by NA. 
# removing the blue (ocean) which is not useful
copNDVI <- reclassify(copNDVI, cbind(253:255, NA))


install.packages("rasterVis") #to use the level plot function 
library(rasterVis)
levelplot(copNDVI)
# gives mean NDVI value for each row and column of pixels 

# aggragting pixels together 
copNDVI10 <- aggregate(copNDVI, fact=10)
levelplot(copNDVI10)

copNDVI100 <- aggregate(copNDVI, fact=100)
levelplot(copNDVI100)

# changing the colors
#yellow in the minimum values
clymin <- colorRampPalette(c('yellow','red','blue'))(100)
plot(copNDVI,col=clymin)
clymed<-colorRampPalette(c('red','yellow','blue'))(100)
plot(copNDVI, col=clymed)
# highest energy/biomass is actually in the blue colors, but our eye is catching the yellow and the red a lot more 
# how to lie with colors 
clymax<-colorRampPalette(c('blue','red','yellow'))(100)
plot(copNDVI,col=clymax)
#now our eyes is focusing on the top values a lot more bc they are in yellow 

#comparing 2 maps in one row and 2 colors 
par(mfrow=c(1,2))
plot(copNDVI, col=clymed)
plot(copNDVI,col=clymax)

dev.off()


#zooming to a certain part
# cropping the image over italy 
#deciding on the extent
#giving minimum  min x, max x, miny, max y, ,) 
italy_ext<-(c(0,20,35,55))
copNDVI_italy<-crop(copNDVI,italy_ext)
plot(copNDVI_italy,col=clymax)
#everything appearing in blue has low biomass for e.g. snowy mountaintops or deserts

#in the next lecture, we will calculate the NDVI in tropical forest, and use statistics to look at the change over time


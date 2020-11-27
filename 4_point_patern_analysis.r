## point pattern analysis 

install.packages("spatstat")
library(spatstat)


#### presentation about point pattern analysis ####

## most ecological data are recorded in the field, in-situ (with x,y coordinates) 
## you have points where each point are just a pair of coordinates
## datasat that are already provided by the spatstat library
## answering the question: how dense are the points in sapce? 
## you can create a density map
## interpolation: estimates data that has not been recorded
## what is the value of the response variable in places where you have not sampled? 
## the easiest way to do it would be to use a linear function: the value between two sample points would be the average of the value of those two points
## you could assign a value to each pixel 
## we are going to use leonardo's data to do interpolation later 


## doing a density map of the covid data 
setwd()
covid<-read.csv("covid_agg.csv", header=TRUE)
covid
attach(covid)
##spatstat document on virtuale that explains everything 

# we make a planar point pattern in spatstat
# we specify x, y, and ranges of each coordinate
covid_planar<-ppp(lon,lat, c(-180,180), c(-90,90))
# in this case, we are using global ranges. If you are looking at local data though, you can choose ranges that are a bit larger than the range of your corrdinates, that way, it is a bit nicer to look at 

# now looking at density
density_map<- density(covid_planar)
plot(density_map)
# we can even add the data points on top of our density map
points(covid_planar)

# we are going to use a function called color ramp
# right now the density map uses default colors, but we can change them
cl<-colorRampPalette(c('blue','orange','red'))(100)
# replotting density map with new color ramp
plot(density_map, col=cl)

# now putting the countried on top of the plots 
install.packages("rgdal")
library(rgdal)

## we will learn next time how to save data on R
## you can do it manually, or you can code for hte export of your plot 

# we start again because we left off here last week 
library(spatstat)
setwd("/Users/emmahemmerle/Documents/EDU/UniBo/Ecosystem Monitoring/R Lab")
covid<-read.csv("covid_agg.csv", header=TRUE)
attach(covid)
# explaining that we are using spatial data x=lon, y=lat
covid_planar<-ppp(lon,lat, c(-180,180), c(-90,90))
# the density of points that we have over our spatial range (here, the planet)
density_map<- density(covid_planar)
plot(density_map)
points(covid_planar)
cl<-colorRampPalette(c('blue','orange','red'))(100)
plot(density_map, col=cl)
points(covid_planar)
# we are now back to what we did last week

#now we are going to add countries

library(rgdal)

# we have downloaded three coastline files from virtuale
# readOGR is 
coastlines<-readOGR("ne_10m_coastline.shp")
# shp file type is related to a shape file. 
# every point has a value in a table. This is in the dbf file 
# the shx file is an index and is linking the shp to the dbf
# vector files when you use x,y coordinates for your points, you can also have lines and polygones in vector files.  
# you also have raster files: images composed of pixels. 
# we get that "It has 3 fields" this means that there are 3 columns in the table of this dataset. 

# replotting the density map with the coastline
plot(density_map, col=cl)
points(covid_planar)
# adding coastlines on top of the density map; if we don't put the 'add' argument, it will only plot the coastline

plot(coastlines, add=TRUE)

# we can change the type of points in order to visualize all of this better 
# using the point character element (pch) 
plot(density_map, col=cl)
points(covid_planar, cex= 0.1, pch = 20)
plot(coastlines, add=TRUE)

# saving the figure to the lab folder
png("figure1.png")
cl<-colorRampPalette(c('blue','orange','red'))(100)
plot(density_map, col = cl)
points(covid_planar, pch = 20, cex = 0.1)
plot(coastlines, add = TRUE)
dev.off()
# can also use the ggsave fucntion 
# https://www.rdocumentation.org/packages/grDevices/versions/3.4.1/topics/png#:~:text=Plots%20in%20PNG%20and%20JPEG,for%20image%20plots%2C%20for%20example.

# or with pdf (better resolution) 
pdf("figure1.pdf")
cl <- colorRampPalette(c('blue','orange','red'))(100) # 
plot(density_map, col = cl)
points(covid_planar, pch = 20, cex = 0.5)
plot(coastlines, add = TRUE)
dev.off()

# interpolation 
# linear interpolation 
# we want to explain to R where you can find the number of covid cases
# the column from which we are taking the data is the cases column. we are marking each point with the cases value
marks(covid_planar)<-cases
# the function to do the interpolation is called Smooth 
# it'll give us a number of cases, even in place where we don't have data 
cases_map<-Smooth(covid_planar)
# we get a warning message, because we don't have enough data points to make cross-validation? but this is okay
plot(cases_map, col=cl)
plot(coastlines, add=TRUE)
points(covid_planar, cex=0.5, pch=20)

## now we are no longer dealing with a density map, but with the number of cases, so the maximum number of cases is indeed in China, and this is what is shown in the map we obtained
## previosuly, europe displayed the highest density of data collected, but this is no longer what we are looking at

# (if it is taking too much time to generate the map, you can use: 
coastlines_simp <- gSimplify(coastlines, tol = 3, topologyPreserve = TRUE)
plot(cases_map, col=cl)
plot(coastlines, add=TRUE)
points(covid_planar, cex=0.5, pch=20)

pdf("figure2.pdf")
cl <- colorRampPalette(c('blue','orange','red'))(100)
plot(cases_map, col=cl)
plot(coastlines, add=TRUE)
points(covid_planar, cex=0.5, pch=20)
dev.off()


## next lecture, we will explain what are different coordinate systems

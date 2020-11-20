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
## we will learn next time how to save data on R

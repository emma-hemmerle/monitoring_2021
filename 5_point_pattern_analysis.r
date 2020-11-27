### getting back to what we had done last time 

setwd("/Users/emmahemmerle/Documents/EDU/UniBo/Ecosystem Monitoring/R Lab")
library(spatstat)
library(rgdal)
covid<-read.csv("covid_agg.csv", header=TRUE)
#checking that everything is ok: 
head(covid)
attach(covid)
covid_planar<-ppp(lon,lat, c(-180,180), c(-90,90)) #if you don't attach, you would have to write covid$lon,covid$lat...
# marking the data that you have to do the interpolation
marks(covid_planar)<-cases
cases_map<-Smooth(covid_planar)
#message says that cross validation is not very efficient because we don't have that many data points
cl <- colorRampPalette(c('blue','orange','red'))(100) # 
plot(cases_map, col=cl)


### plotting points with different size (proportional to the number of covid cases), while also doing interpolation
### (the values in the parts of the map where you didn't take any measurements)
### using code by norma
install.packages("sf")
library(sf)
#st_as_sf() is going to take the covid data, and state what the coordinates are
Spoints<-st_as_sf(covid, woords=c("lon","lat"))
plot(Spoints, cex=Spoints$cases, col = 'purple3', lwd = 3, add=T)
plot(Spoints, cex=Spoints$cases/10000, col = 'purple3', lwd = 3, add=T)
library(rgdal)
coastlines <- readOGR("ne_10m_coastline.shp")
plot(coastines, add=T)

### we can re-sample the coastlines data so that it takes less time to load 


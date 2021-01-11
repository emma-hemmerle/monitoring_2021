# We downloaded from copernicus 2 Land Surface temperature datasets
# averaged over 10 days from Jan 2021 and from Oct 2020
# we put both .nc files in the lab folder 
# ncdf4 library in order to read the nc file in R. 
install.packages("ncdf4")
library(ncdf4) 

setwd("/Users/emmahemmerle/Documents/EDU/UniBo/Ecosystem Monitoring/R Lab")
# last time macking use of brick function to upload several layers together, today, we only have one layer, and we use the function raster
library(raster)
# 10 day av LST in January 
tjan<-raster("c_gls_LST10-DC_202101010000_GLOBE_GEO_V1.2.1.nc")
plot(tjan)

# change colorramppalette
cltjan <- colorRampPalette(c('blue','yellow','orange', 'red'))(100)
plot(tjan, col=cltjan)


toct<-raster("c_gls_LST10-DC_202010010000_GLOBE_GEO_V1.2.1.nc")
plot(toct)
plot(toct, col=cltjan)

# difference in temperature between january and oct in the soil
dift<-tjan-toct
cldift <- colorRampPalette(c('blue','white','red'))(100)
plot(dift,col= cldift)

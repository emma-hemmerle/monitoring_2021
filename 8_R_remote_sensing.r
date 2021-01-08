# R code for remote Sensing analysis
# install.packages(c("raster","RStoolbox")
# raster= data based on images (pixels); RStoolbox used for remote sensing data analysis
library(c("raster","RStoolbox")
setwd("/Users/emmahemmerle/Documents/EDU/UniBo/Ecosystem Monitoring/R Lab")
# data downloaded from virtuale: p224r63_1988/2011 files p indicates the paths, and R the row, allowing you to reconstruct where you find yourself on the planet based on LandSat Data
# We are somewhere in the middle of the Brazilian Amazonia
# 7 sensors: Blue, Green Red, NIR, Thermal IR, Middle IR (2 bands) --> Today we use the first 4
# to upload the whole satellite image, we use function brick (for raster data
p224r63_2011<-brick("p224r63_2011_masked.grd")
# name indicates the path, the row, and the year 
# Error in file(x, "rb") : cannot open the connection
# This is because the file was is an additional folder withing the R Lab folder, so it just needed to be moved directly into the R lab folder and not within an additional folder
p224r63_2011
# gives you information on the raster: RasterBrick (means that we are using different layers, in this case 7) 
# the resolution is 30*30m 
# we have 4 447 533 pixels per layer, and 7 layers so 4 447 533*7= 31132731
# datum=WGS84 the original referencing ellispoid 
#names: B1_sre,B2_sre, B3_sre, B4_sre, B5_sre, B6_bt,B7_sre --> those are the names of the layers
#extent: 579765, 668775, -522705, -477735  (xmin, xmax, ymin, ymax) --> these are the coordinates that delimit our image. Y is distance from the equator, in meters. X is the distance from the central meridian
plot(p224r63_2011)
# the color here is set by default by R 
cl <- colorRampPalette(c('black','grey','light grey'))(100) # 
plot(p224r63_2011, col=cl)
# B5= mid IR; B6= Thermal IR; B7= mid IR
# Now plotting only B1 to B4: blue, green, red, NIR
# For LandSat, Band 1 is always Blue, second green, third red etc. Things are different for sentinel data for instance.         
# we are going to use the par function multiframe c(2,2)= we want a graph with the 4 layers on two rowspar(mfrow=c(2,2))
par(mfrow=c(2,2))
clb <- colorRampPalette(c('dark blue','blue','light blue'))(100) # 
plot(p224r63_2011$B1_sre, col=clb)
# This is for the blue wavelengths 
# Now we add the green, Red, and NIR
clg <- colorRampPalette(c('dark green','green','light green'))(100) 
plot(p224r63_2011$B2_sre, col=clg)
clr <- colorRampPalette(c('dark red','red','pink'))(100)
plot(p224r63_2011$B3_sre, col=clr) 
cln<- colorRampPalette(c('red','orange','yellow'))(100)
plot(p224r63_2011$B4_sre, col=cln)

pdf("p224r63_2011.pdf")        
par(mfrow=c(2,2))
clb <- colorRampPalette(c('dark blue','blue','light blue'))(100) # 
plot(p224r63_2011$B1_sre, col=clb)
clg <- colorRampPalette(c('dark green','green','light green'))(100) 
plot(p224r63_2011$B2_sre, col=clg)
clr <- colorRampPalette(c('dark red','red','pink'))(100)
plot(p224r63_2011$B3_sre, col=clr) 
cln<- colorRampPalette(c('red','orange','yellow'))(100)
plot(p224r63_2011$B4_sre, col=cln)
dev.off()        
        
#RGB = the framework that everybody uses to show color, in the RGB space, we will attribute each layer to R, G, and B, and see the image as the human eye would see it 
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")        
# Lin= linear methods to see the colors better    
# Now we can enhance this image by also including the NIR band (something the human eye cannot see) 
# but RDG scheme is fixed, so we will have to shift everything by one
plotRGB(p224r63_2011, r=4, g=2, b=3, stretch="Lin") #we are leving out the blue band in this case
# in this case, you can actually appreciate the places where vegetation is missing even better
# now we make a switch we put the NIR in the green component, red in the red component, and green in the blue component
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
#last one we put red in red, green in green and NIR in Blue (so we see vegetation in blue!) 
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")   
        
        
pdf("RGBp224r63_2011.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
dev.off()        
        
        

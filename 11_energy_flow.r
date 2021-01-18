## deforestation example

library(raster) 
library(RStoolbox)
setwd("/Users/emmahemmerle/Documents/EDU/UniBo/Ecosystem Monitoring/R Lab")

# in the raster package: importing data from Lab folder 
# only one layer (e.g. vegetation index): use function raster 
# several layers (e.g. NIR, R, G, B): use brick function 
# today we are importing a satellite image with several bands, so we need the brick function 
defor1<-brick("defor1.png")
defor2<-brick("defor2.png")
defor1
defor2
#it shows that each image has 3 bands (under "name")
# min value is 0 max value is 255 
# 8 bit system: 256 colors in each band (from 0 to 255)
# 1 bit: an event being true=1; event being false=0 (black and white)
# 2 bits: 00; 01; 10; 11 -> 4 different values and color associated
# 3 bits: 000; 001; 011; 111; 010; 110; 101; 111 -> 8 different values and color associated
# 4 bits:2^4=16
# 8 bits: 2^8=256

# RGB scheme of this image band1=NRI; band2=Red; band3=Green
# if we but NIR in the red component, we will see the vegetation as red
plotRGB(defor1,r=1,g=2,b=3, stretch="Lin")
# we can reverse the colors
#we put the NIR in the green component, and the vegetation will appear green 
plotRGB(defor1,r=2,g=1,b=3, stretch="Lin")

#back to the original one 
plotRGB(defor1,r=1,g=2,b=3, stretch="Lin")

# we will see how the forest cover has changed over time by looking at defor2
plotRGB(defor2,r=1,g=2,b=3, stretch="Lin")

#multiframe seeing the two images together
par(mfrow=c(2,1))
plotRGB(defor1,r=1,g=2,b=3, stretch="Lin")
plotRGB(defor2,r=1,g=2,b=3, stretch="Lin")
dev.off()

#DVI (difference vegetation index)= NIR-Red
#large value for DVI when there is a lot of vegetation/ it is healthy; DVI decreases as vegetation/health decreases

# DVI for defor1 (first period)
defor1
# we get names of the layers: defor1.1 (NIR), defor1.2 (red), defor1.3 (green)
#difference between NIR and the red band 
DVIdefor1<-defor1$defor1.1-defor1$defor1.2
plot(DVIdefor1)

changing color ramp
cl<-colorRampPalette(c('darkblue','yellow','red','black'))(100)
#high biomass here is in the dark red zone
plot(DVIdefor1,col=cl)

DVIdefor2<-defor2$defor2.1-defor2$defor2.2
plot(DVIdefor2,col=cl)

#plotting the two images together 
par(mfrow=c(2,1))
plot(DVIdefor1,col=cl, main="DVI before cutting")
plot(DVIdefor2,col=cl, main="DVI after cutting")

pdf("deforestation.pdf")
par(mfrow=c(2,1))
plot(DVIdefor1,col=cl, main="DVI before cutting")
plot(DVIdefor2,col=cl, main="DVI after cutting")
dev.off()

dev.off()
#the lower the DVI, the lowest the ability to carry out photosynthesis
# if we do DVI1-DV2, you will have near 0 values where there are no changes, large values where DVI has decreases a lot, negative values if it has actually increased
difdvi<-DVIdefor1-DVIdefor2
plot(difdvi)
cld<-colorRampPalette(c('blue','white','red'))(100)
plot(difdvi,col=cld)
#we are looking at the biomass lost due to cutting, i.e. the amount of energy lost

hist(difdvi,col='red')
#many of the values are positive; this means that in the majority of places, there is less energy/biomass, i.e. has been deforested 
# decrease in biomass between the two periods (defor1 vs defor2) in the majority of the area studied

#final par to show all analysis together 
pdf("deforestation_overview.pdf")
par(mfrow=c(3,2))
plotRGB(defor1,r=1,g=2,b=3, stretch="Lin")
plotRGB(defor2,r=1,g=2,b=3, stretch="Lin")
plot(DVIdefor1,col=cl, main="DVI before cutting")
plot(DVIdefor2,col=cl, main="DVI after cutting")
plot(difdvi,col=cld, main="Amount of energy lost")
hist(difdvi,col='red')
dev.off()

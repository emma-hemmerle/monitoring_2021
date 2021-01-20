# using sentinel data to look at chemical cycling
# satellite by ESA, measuring amount of NO2 in the environment
# 13 png files from january until march 2020 (2020 lockdown period) in the lab folder

setwd("/Users/emmahemmerle/Documents/EDU/UniBo/Ecosystem Monitoring/R Lab")
getwd()

library(raster)
library()
library()


#downloading the data
EN01<-raster("EN_0001.png")
EN02<-raster("EN_0002.png")
EN03<-raster("EN_0003.png")
EN04<-raster("EN_0004.png")
EN05<-raster("EN_0005.png")
EN06<-raster("EN_0006.png")
EN07<-raster("EN_0007.png")
EN08<-raster("EN_0008.png")
EN09<-raster("EN_0009.png")
EN10<-raster("EN_0010.png")
EN11<-raster("EN_0011.png")
EN12<-raster("EN_0012.png")
EN13<-raster("EN_0013.png")

# or a faster way to do it would be to do: 
rlist <- list.files(pattern="EN")
rlist # checking that you have all the files in the list
list_rast<-lapply(rlist, raster)
ENstack <- stack(list_rast)

# "<-" and "=" signs are sometimes used as synonyms

cl<-colorRampPalette(c('red','orange','yellow'))(100)
par(c(1,2)) #2 plots in row and 2 columns 
plot(EN01,col=cl)
plot(EN13,col=cl)
dev.off()

# we can see a huge decrease in energy between january and march (1st and last image)
# relative scale of 0 to 255 units (8 bit image) which measures N02 pollution
# Looking at the difference between the 2: large value in the difference means the decrease has been high
# negative values actually mean that there was an increase in NO2 levels
difNO2<-EN01-EN13
cldif<-colorRampPalette(c('blue','black','yellow'))(100)
plot(difNO2,col=cldif)


# you want to create a video? 
# https://www.r-bloggers.com/2018/10/the-av-package-production-quality-video-in-r/
#simple version, just copy and they will appear one after the other, and you will see the results
plot(EN01, col=cl)
plot(EN02, col=cl)
plot(EN03, col=cl)
plot(EN04, col=cl)
plot(EN05, col=cl)
plot(EN06, col=cl)
plot(EN07, col=cl)
plot(EN08, col=cl)
plot(EN09, col=cl)
plot(EN10, col=cl)
plot(EN11, col=cl)
plot(EN12, col=cl)
plot(EN13, col=cl)


#multiframe plotting everything together
# we have 13 images (prime number), so we will have some empty spots 
par(mfrow=c(4,4))
plot(EN01, col=cl)
plot(EN02, col=cl)
plot(EN03, col=cl)
plot(EN04, col=cl)
plot(EN05, col=cl)
plot(EN06, col=cl)
plot(EN07, col=cl)
plot(EN08, col=cl)
plot(EN09, col=cl)
plot(EN10, col=cl)
plot(EN11, col=cl)
plot(EN12, col=cl)
plot(EN13, col=cl)


# make a stack
EN <- stack(EN01,EN02,EN03,EN04,EN05,EN06,EN07,EN08,EN09,EN10,EN11,EN12,EN13)
plot(EN,col=cl)
# it will plot all of the images, without having to use par etc...


# RGB
#the manner in which electronic devices show images
#we can put a specific image in each RGB component 
plotRGB(EN, red=EN13, green=EN07, blue=EN01, stretch="lin")
#green: highest values at mid-term
#red: highet values in march
#blue: highest values in Jan
#yellow=values are high at all of the dates 
dev.off()

#boxplot
boxplot(EN,horizontal=T,axes=T,outline=F)
# adding the names of the axes + changing color
boxplot(EN, horizontal=T, axis=T, outline=F, xlab="NO2 levels-8bit", ylab="Period",col='red') 
# we see that in this period, it is mostly the maximal values in NO2 levels that changed from Jan to March
# max values are higher in Jan than they are at mid term, and at the end of march
# it also shows the median values for each image
# passing from remote sensing data to statistical analysis of that data
